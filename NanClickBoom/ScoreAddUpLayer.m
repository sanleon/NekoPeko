//
//  ScoreAddUpLayer.m
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/10.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "ScoreAddUpLayer.h"
#import "GameLayer.h"
#import "GameResultLayer.h"
#import "ModalAlert.h"
#import "AttackAnimation.h"

@implementation ScoreAddUpLayer

//@synthesize remainEnemyHp = _remainEnemyHp;
//@synthesize remainMyHp = _remainMyHp;
//@synthesize currentEnemyHp = _currentEnemyHp;
//@synthesize currnetMyHp = _currnetMyHp;
//@synthesize baseEnemyScore = _baseEnemyScore;
//@synthesize baseMyScore = _baseMyScore;
//@synthesize myScore = _myScore;
//@synthesize enemyScore = _enemyScore;
//@synthesize enemuUserId = _enemyUserId;
//@synthesize myUserId = _myUserId;

@synthesize remainEnemyHp;
@synthesize remainMyHp;
@synthesize currentEnemyHp;
@synthesize currnetMyHp;
@synthesize baseEnemyScore;
@synthesize baseMyScore;
@synthesize myScore;
@synthesize enemyScore;
@synthesize enemyUserId;
@synthesize myUserId;
@synthesize isGameEnd;
@synthesize isEnemyDissconnected;
@synthesize combo, count, enemyCombo, enemyCount, point, enemyPoint;

@synthesize winCount, loseCount, drawCount, gameResult;


- (id) init
{
    if (self = [super init] ) {
        apiConnection = nil;
//        [self scheduleUpdate];

    }
    return self;
}

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ScoreAddUpLayer *layer = [ScoreAddUpLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void) onEnter
{
    [super onEnter];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite * backImage = [CCSprite spriteWithFile:@"common_bg.png"];
    backImage.position = CGPointMake(winSize.width/2, winSize.height/2);
    [self addChild:backImage z:0];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:ACTION_SCORE_ADD_UP forKey:ACTION_TYPE];
    [userDefaults synchronize];
    
    isMyScoreAniEnd = NO;
    isEnemyScoreAniEnd = NO;
    

    if (isGameEnd) {
        
        if (baseMyScore > baseEnemyScore) {
            [self setGameResult:1];
        } else if(baseMyScore == baseEnemyScore) {
            [self setGameResult:0];
        } else {
            [self setGameResult:2];
        }
    } 

    if (isEnemyDissconnected) {
        NSLog(@"Game EnemyDisconnected");
        [self setGameResult:1];
        [self setImagesForBG];
    }

}

- (void) setImagesForBG
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite * backImage = [CCSprite spriteWithFile:@"common_bg.png"];
    backImage.position = CGPointMake(winSize.width/2, winSize.height/2);
    [self addChild:backImage z:0];
    
    //    [self createAttackAnimation];
    
    //    _baseMyScore = _myScore;
    //    _baseEnemyScore = _enemyScore;
    NSLog(@"MyScore : %d", myScore);
    NSLog(@"EnemyScore : %d", enemyScore);
    
    myScoreLabel = [CCLabelTTF labelWithString:@"" fontName:@"AmericanTypewriter-Bold" fontSize:50];
    myScoreLabel.position =  ccp(9, 235);
    myScoreLabel.color = ccc3(31, 138, 232);
    myScoreLabel.anchorPoint = ccp(0.0, 1.0);
    myScoreLabel.dimensions = CGSizeMake(100, 0);
    [self addChild:myScoreLabel];
    
    enemyScoreLabel = [CCLabelTTF labelWithString:@"" fontName:@"AmericanTypewriter-Bold" fontSize:50];
    enemyScoreLabel.position =  ccp(311, 235);
    enemyScoreLabel.anchorPoint = ccp(1.0, 1.0);
    enemyScoreLabel.color = ccc3(252, 44, 37);
    enemyScoreLabel.dimensions = CGSizeMake(100, 0);
    [self addChild:enemyScoreLabel];
    
    attackAnimation = [AttackAnimation spriteWithFile:@"attack-ani-0.png"];
    attackAnimation.attackAnimation = [CCAnimation animation];
    for (int i = 0; i <= 31; i++) {
        [attackAnimation.attackAnimation addSpriteFrameWithFilename:[NSString stringWithFormat:@"attack-ani-%d.png", i]];
    }
    
    attackAnimation.attackAnimation.delayPerUnit = 0.05;
    
    attackAnimation.attackAnimation.loops = -1;
    
    attackAnimation.attackAnimate = [CCAnimate actionWithAnimation:attackAnimation.attackAnimation];
    
    attackAnimation.position = ccp(winSize.width/2, 81);
    
    [self addChild:attackAnimation];
    
    CCSprite * myHpBarProgressBorder = [CCSprite spriteWithFile: @"main_game_guage_bg_me.png"];
    [myHpBarProgressBorder setPosition:ccp(81, 440.5)];
    [self addChild: myHpBarProgressBorder z:1];
    
    CCSprite * myCharacterImage = [CCSprite spriteWithFile: @"main_game_guage_cha_me.png"];
    [myCharacterImage setPosition:ccp(27, 451)];
    [self addChild: myCharacterImage z:2];
    
    
    CCLabelTTF *myUserIdLabel = [CCLabelTTF labelWithString:myUserId fontName:@"AmericanTypewriter-Bold" fontSize:10];
    myUserIdLabel.position =  ccp(47.5, 432.2);
    myUserIdLabel.color = ccc3(0, 0, 0);
    myUserIdLabel.anchorPoint = ccp(0.0, 1.0);
    [self addChild:myUserIdLabel];
    
    CCSprite *myAttackLabelImage = [CCSprite spriteWithFile: @"result_title_me.png"];
    [myAttackLabelImage setPosition:ccp(37, 363)];
    myAttackLabelImage.anchorPoint = ccp(0.5, 0.5);
    [self addChild: myAttackLabelImage z:1];
    
    CCLabelTTF *myAttackScoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", count*attackBaseScore] fontName:@"AmericanTypewriter-Bold" fontSize:50];
    myAttackScoreLabel.position =  ccp(9.0, 355);
    myAttackScoreLabel.color = ccc3(31, 138, 232);
    myAttackScoreLabel.anchorPoint = ccp(0.0, 1.0);
    myAttackScoreLabel.dimensions = CGSizeMake(100, 0);
    [self addChild:myAttackScoreLabel];
    
    CCLabelTTF *myAttacComboMultiplyLabel;
    if (combo == 0) {
      myAttacComboMultiplyLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", @"+"] fontName:@"AmericanTypewriter-Bold" fontSize:40];  
    } else {
        myAttacComboMultiplyLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", @"x"] fontName:@"AmericanTypewriter-Bold" fontSize:40];
    }
    myAttacComboMultiplyLabel.position =  ccp(11.0, 303);
    myAttacComboMultiplyLabel.color = ccc3(0, 217, 255);
    myAttacComboMultiplyLabel.anchorPoint = ccp(0.0, 1.0);
    myAttacComboMultiplyLabel.dimensions = CGSizeMake(100, 0);
    [self addChild:myAttacComboMultiplyLabel];

    CCLabelTTF *myAttacComboLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", combo] fontName:@"AmericanTypewriter-Bold" fontSize:44];
    myAttacComboLabel.position =  ccp(41, 307);
    myAttacComboLabel.color =ccc3(0, 217, 255);
    myAttacComboLabel.anchorPoint = ccp(0.0, 1.0);
    myAttacComboLabel.dimensions = CGSizeMake(100, 0);
    [self addChild:myAttacComboLabel];
    
    
    CCSprite *myAttackLineImage = [CCSprite spriteWithFile: @"result_title_me_bar.png"];
    [myAttackLineImage setPosition:ccp(42, 239)];
    [self addChild: myAttackLineImage z:1];
    
    
    CCSprite *enemyAttackLabelImage = [CCSprite spriteWithFile: @"result_title_enemy.png"];
    [enemyAttackLabelImage setPosition:ccp(283, 363)];
    enemyAttackLabelImage.anchorPoint = ccp(1.0, 1.0);
    [self addChild: enemyAttackLabelImage z:1];
    

    
    CCLabelTTF *enemyAttackScoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", enemyCount*attackBaseScore] fontName:@"AmericanTypewriter-Bold" fontSize:50];
    enemyAttackScoreLabel.position =  ccp(311, 355);
    enemyAttackScoreLabel.color = ccc3(252, 44, 37);
    enemyAttackScoreLabel.anchorPoint = ccp(1.0, 1.0);
    enemyAttackScoreLabel.dimensions = CGSizeMake(100, 0);
    [self addChild:enemyAttackScoreLabel];
    
    
    CCLabelTTF *enemyAttacComboMultiplyLabel;
    if (enemyCombo == 0) {
        enemyAttacComboMultiplyLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", @"+"] fontName:@"AmericanTypewriter-Bold" fontSize:40];
    } else {
        enemyAttacComboMultiplyLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", @"x"] fontName:@"AmericanTypewriter-Bold" fontSize:40];
    }
    enemyAttacComboMultiplyLabel.position =  ccp(253, 303);
    enemyAttacComboMultiplyLabel.color = ccc3(255, 90, 175);
    enemyAttacComboMultiplyLabel.anchorPoint = ccp(0.0, 1.0);
    enemyAttacComboMultiplyLabel.dimensions = CGSizeMake(100, 0);
    [self addChild:enemyAttacComboMultiplyLabel];
    
    CCLabelTTF *enemyAttacComboLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", enemyCombo] fontName:@"AmericanTypewriter-Bold" fontSize:44];
    enemyAttacComboLabel.position =  ccp(311, 307);
    enemyAttacComboLabel.color = ccc3(255, 90, 175);
    enemyAttacComboLabel.anchorPoint = ccp(1.0, 1.0);
    enemyAttacComboLabel.dimensions = CGSizeMake(100, 0);
    [self addChild:enemyAttacComboLabel];
    
    
    CCSprite *enemyAttackLineImage = [CCSprite spriteWithFile: @"result_title_enemy_bar.png"];
    [enemyAttackLineImage setPosition:ccp(282, 239)];
    [self addChild: enemyAttackLineImage z:1];
    
    
    CCSprite * enemyHpBarProgressBorder = [CCSprite spriteWithFile: @"main_game_guage_bg_enemy.png"];
    [enemyHpBarProgressBorder setPosition:ccp(241.5, 440.5)];
    [self addChild: enemyHpBarProgressBorder z:1];
    
    CCSprite * enemyCharacterImage = [CCSprite spriteWithFile: @"main_game_guage_cha_enemy.png"];
    [enemyCharacterImage setPosition:ccp(293, 451)];
    [self addChild: enemyCharacterImage z:2];
    
    CCLabelTTF *enemyUserIdLabel = [CCLabelTTF labelWithString:enemyUserId fontName:@"AmericanTypewriter-Bold" fontSize:10];
    enemyUserIdLabel.position =  ccp(272.5, 432.2);
    enemyUserIdLabel.color = ccc3(0, 0, 0);
    enemyUserIdLabel.anchorPoint = ccp(1.0, 1.0);
    [self addChild:enemyUserIdLabel];
}

- (void) onEnterTransitionDidFinish
{
 
    [super onEnterTransitionDidFinish];
    if (!isEnemyDissconnected) {
        apiConnection = [APIConnection sharedAPIConnection];
        apiConnection.delegate = self;
        [apiConnection setActionType:ADD_UP_SCORE];
        
        [apiConnection sendMessage:[NSString stringWithFormat:@"{\"score\":{\"combo\":%d, \"count\":%d}}",combo, count]];
        
        //    apiConnection = [APIConnection sharedAPIConnection];
        //    apiConnection.delegate = self;
        //    [apiConnection setActionType:APPLY_GAME];
        //    [apiConnection sendMessage:@"{\"ready\":\"\"}"];
        
        
    } else {

//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            NSNumber* tempWinCount = [userDefaults valueForKey:@"WinCount"];
//            tempWinCount = [[NSNumber alloc] initWithInt:[tempWinCount intValue] + 1];
//            [userDefaults setObject:tempWinCount forKey:@"WinCount"];
            GameResultLayer* gameResultLayer = [GameResultLayer node];
//            [gameResultLayer setWinCount:[tempWinCount intValue]];
//            [gameResultLayer setLoseCount:loseCount];
//            [gameResultLayer setDrawCount:drawCount];
            [gameResultLayer setGameResult:1];
            [gameResultLayer setIsForceGameEnd:YES];
            
            CCScene *gameResultScene = [CCScene node];
            [gameResultScene addChild:gameResultLayer];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:gameResultScene withColor:ccWHITE]];

    }
}

- (void) onExit
{

    [super onExit];
    [self removeAllChildrenWithCleanup:YES];
}

- (void) decreaseProgressBarFinished:(id)sender
{
    
}

- (void) decreaseProgressBarFinished2:(id)sender
{
    
}

- (void) decreaseProgressBarFinished3:(id)sender
{
    
}

- (void) restartGame
{

    BOOL isWaitRestartGame = NO;
    while (!isWaitRestartGame) {
        if (isEnemyScoreAniEnd == YES && isMyScoreAniEnd == YES) {
            isWaitRestartGame = YES;

            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            
            NSNumber * currentGameCount = [userDefaults objectForKey:@"CurrentGameCount"];
            if ([currentGameCount intValue]== gameCount || [self isGameEnd] == YES) {
                [userDefaults setInteger:0 forKey:@"ClickedTileCount"];
               
                //ゲーム終了
                // 結果登録
            } else {
//                [self setEnemyScore:0];
//                [self setMyScore:0];
//                [self setBaseEnemyScore:0];
//                [self setBaseMyScore:0];
                GameLayer* gameLayer = [GameLayer node];
                [gameLayer setCurrentMyHp:remainMyHp];
                [gameLayer setCurrentEnemyHp:remainEnemyHp];
                CCScene *gameScene = [CCScene node];
                [gameScene addChild:gameLayer];
                [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:gameScene withColor:ccWHITE]];
            }
        }
    }

}

- (void)updateMyScore:(ccTime) dt{
    myScore += 1;
    float incScorePerSec = (baseMyScore - myScore)/1;
    if( baseMyScore > myScore )
        myScore = fmin( myScore + incScorePerSec*dt, baseMyScore);
    else
        myScore = fmax( myScore + incScorePerSec*dt, baseMyScore);
    
    if (baseMyScore == myScore) {
        
        [myScoreLabel setString:[NSString stringWithFormat:@"%d",baseMyScore]];
        
        isMyScoreAniEnd = YES;

        if (isEnemyScoreAniEnd == YES && isMyScoreAniEnd == YES) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AttackEndAnimation" object:self];
            //        [self unschedule:@selector(uptateAttackAnimation:)];
        }
        // タイマーを止める
        [self unschedule:@selector(updateMyScore:)];
        
        [self transGameResult];

        return;
    }
    [myScoreLabel setString:[NSString stringWithFormat:@"%d",myScore]];
}


- (void)updateEnemyScore:(ccTime) dt{
    enemyScore += 1;
    
    float incScorePerSec = (baseEnemyScore - enemyScore)/1;
    if( baseEnemyScore > enemyScore )
        enemyScore = fmin( enemyScore + incScorePerSec*dt, baseEnemyScore);
    else
        enemyScore = fmax( enemyScore + incScorePerSec*dt, baseEnemyScore);
    
    if (baseEnemyScore == enemyScore) {
        
        [enemyScoreLabel setString:[NSString stringWithFormat:@"%d",baseEnemyScore]]; // -0.0と表示されてしまうため0の時は特別に。
        
        isEnemyScoreAniEnd = YES;

        if (isEnemyScoreAniEnd == YES && isMyScoreAniEnd == YES) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AttactEndAnimation" object:self];
            //        [self unschedule:@selector(uptateAttackAnimation:)];
        }
        // タイマーを止める
        [self unschedule:@selector(updateEnemyScore:)];
        
        [self transGameResult];
        
        return;
    }
    [enemyScoreLabel setString:[NSString stringWithFormat:@"%d",enemyScore]];
}

- (void) setPlayerHP
{
    
    CCProgressTimer *myHpBarProgressFrom=[CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:@"main_game_guage_me.png"]];
    myHpBarProgressFrom.type=kCCProgressTimerTypeBar;
    //        myHpBarProgressFrom.midpoint = ccp(0,_currentMyHp);
    myHpBarProgressFrom.midpoint = ccp(0,0);
    myHpBarProgressFrom.position=ccp(98, 445);
    myHpBarProgressFrom.anchorPoint = ccp(0.50, 0.50);
    myHpBarProgressFrom.percentage=100;
    [myHpBarProgressFrom setBarChangeRate:(ccp(1,0))];
    [self addChild:myHpBarProgressFrom z:3];
    //[lifeBar runAction:[CCProgressFromTo actionWithDuration:gameLimitedSecond from:100.0 to:0.0]];
    
    CCProgressTo *myHpBarProgressTo = [CCProgressTo actionWithDuration:GAME_DISPLAY_ACTION_IN_DURATION percent:100];
    [myHpBarProgressFrom runAction:myHpBarProgressTo];
    //    [self addChild:lifeBar z:1];
    //[lifeBar runAction:[CCProgressFromTo actionWithDuration:gameLimitedSecond from:100.0 to:0.0]];
    CCCallFunc *cbDecrFinished = [CCCallFunc actionWithTarget:self selector:@selector(decreaseProgressBarFinished2:)];
    CCProgressFromTo *myHpBarProgressToZero = [CCProgressFromTo actionWithDuration:GAME_DISPLAY_ACTION_IN_DURATION from:100 to:remainMyHp];
    CCSequence *asequence = [CCSequence actions:myHpBarProgressToZero, cbDecrFinished, nil];
    
    [myHpBarProgressFrom runAction:asequence];
    
    

    
    CCProgressTimer *enemyHpProgressFrom=[CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:@"main_game_guage_enemy.png"]];
    enemyHpProgressFrom.type=kCCProgressTimerTypeBar;
    //        enemyHpProgressFrom.midpoint = ccp(1,_currentEnemyHp);
    enemyHpProgressFrom.midpoint = ccp(1,0);
    
    enemyHpProgressFrom.position=ccp(225, 445);
    enemyHpProgressFrom.anchorPoint = ccp(0.50, 0.50);
    enemyHpProgressFrom.percentage=100;
    [enemyHpProgressFrom setBarChangeRate:(ccp(1,0))];
    [self addChild:enemyHpProgressFrom z:3];
    
    //[lifeBar runAction:[CCProgressFromTo actionWithDuration:gameLimitedSecond from:100.0 to:0.0]];
    
    CCProgressTo *enemyHpBarProgressTo = [CCProgressTo actionWithDuration:GAME_DISPLAY_ACTION_IN_DURATION percent:100];
    [enemyHpProgressFrom runAction:enemyHpBarProgressTo];
    
    //    [self addChild:lifeBar z:1];
    //[lifeBar runAction:[CCProgressFromTo actionWithDuration:gameLimitedSecond from:100.0 to:0.0]];
    CCCallFunc *cbDecrFinished2 = [CCCallFunc actionWithTarget:self selector:@selector(decreaseProgressBarFinished3:)];
    CCProgressFromTo *enemyHpBarProgressToZero2 = [CCProgressFromTo actionWithDuration:GAME_DISPLAY_ACTION_IN_DURATION from:100 to:remainEnemyHp];
    CCSequence *asequence2 = [CCSequence actions:enemyHpBarProgressToZero2, cbDecrFinished2, nil];
    
    [enemyHpProgressFrom runAction:asequence2];
}

- (void) createAttackAnimation
{

    


}

- (void) uptateAttackAnimation:(ccTime) dt
{
    


//    [attackAnimationImage runAction:attackAnimate];

}

- (void) receivedErrorFromAction:(NSString *)message
{
    
}

- (void) receivedMessageFromAddUpScore:(NSDictionary *)messageDic
{


    
    BOOL result = NO;
    if (messageDic != nil) {
        NSDictionary *enemyHpDic = [messageDic valueForKey:@"enemy"];
        if (enemyHpDic != nil) {
            result = YES;

            
            NSDictionary *myHpDic = [messageDic valueForKey:@"score"];
            NSDictionary *enemyHpDic = [messageDic valueForKey:@"enemy"];
            
            // TODO
            NSNumber *tempRemainMyHp = [myHpDic valueForKey:@"hp"];
            NSNumber *tempRemainEnemyHp = [enemyHpDic valueForKey:@"hp"];
            signed int remainingMyHp = [tempRemainMyHp intValue];
            signed int remainingEnemyHp = [tempRemainEnemyHp intValue];
            
            NSNumber *tempPoint = [myHpDic valueForKey:@"point"];
            NSNumber *tempEnemyPoint = [enemyHpDic valueForKey:@"point"];
            
            NSNumber *tempMyCombo = [myHpDic valueForKey:@"combo"];            
            NSNumber *tempMyCount = [myHpDic valueForKey:@"attack"];
            
            NSNumber *tempEnemyCombo = [enemyHpDic valueForKey:@"combo"];
            NSNumber *tempEnemyCount = [enemyHpDic valueForKey:@"attack"];
            point = [tempPoint intValue];
            combo = [tempMyCombo intValue];
            count = [tempMyCount intValue];
            enemyPoint = [tempEnemyPoint intValue];
            enemyCombo = [tempEnemyCombo intValue];
            enemyCount = [tempEnemyCount intValue];
            //        remainingEnemyHp = 60;
            //        remainingMyHp = 83;
            NSLog(@"RemaingMyHp :%d", remainingMyHp);
            NSLog(@"remainingEnemyHp :%d", remainingEnemyHp);
            
            
            [self setMyUserId:myUserId];
            [self setEnemyUserId:enemyUserId];
            //        scoreLayer.currnetMyHp = _currentMyHp;
            //        scoreLayer.currentEnemyHp = _currentEnemyHp;
            //        scoreLayer.remainEnemyHp = remainingEnemyHp;
            [self setMyScore:0];
            [self setEnemyScore:0];

            [self setRemainMyHp:(float)remainingMyHp];
            [self setRemainEnemyHp:(float)remainingEnemyHp];
//            [self setBaseMyScore:myScoreIntValue];
            if (combo == 0) {
                [self setBaseMyScore:combo+(count*attackBaseScore)];
            } else {
                [self setBaseMyScore:combo*(count*attackBaseScore)];
            }
            
            if (enemyCombo == 0) {
                [self setBaseEnemyScore:enemyCombo+(enemyCount*attackBaseScore)];
            } else {
                [self setBaseEnemyScore:enemyCombo*(enemyCount*attackBaseScore)];
            }
            GameLayer *gameLayer =   [GameLayer node];
            [gameLayer setCurrentEnemyHp:remainingEnemyHp];
            [gameLayer setCurrentMyHp:remainMyHp];
            
            [self setImagesForBG];
            [self setPlayerHP];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AttackStartAnimation" object:self];
            [self schedule:@selector(updateMyScore:) interval:0.01];
            [self schedule:@selector(updateEnemyScore:) interval:0.01];

            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSNumber * currentGameCount = [userDefaults objectForKey:@"CurrentGameCount"];
            if (([currentGameCount intValue] == gameCount) || remainingMyHp <= 0 || remainingEnemyHp <= 0) {
                isGameEnd = YES;
                [apiConnection setActionType:END_GAME];
            }

            [self runAction: [CCSequence actions:
                              [CCDelayTime actionWithDuration: 5],
                              [CCCallFunc actionWithTarget:self selector:@selector(restartGame)],
                              nil]];
            

            
        } else {
            result = NO;
        }
        NSLog(@"result : %d", result);
    }
    
    
    if (result) {
        
        
        
        
    }
}

- (void) receivedMessageFromGameEnd:(NSDictionary *)messageDic
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    if (messageDic != nil) {
        NSDictionary *recordDic = [messageDic valueForKey:@"record"];
        NSNumber *tempWinCount = [recordDic objectForKey:@"win"];
        NSNumber *tempLoseCount = [recordDic objectForKey:@"lose"];
        NSNumber *tempDrawCount = [recordDic objectForKey:@"draw"];


        [userDefaults setObject:tempWinCount forKey:@"WinCount"];
        [userDefaults setObject:tempLoseCount forKey:@"LoseCount"];
        [userDefaults setObject:tempDrawCount forKey:@"DrawCount"];
        [userDefaults synchronize];
        
        [self setWinCount:[tempWinCount intValue]];
        [self setLoseCount:[tempLoseCount intValue]];
        [self setDrawCount:[tempDrawCount intValue]];

    }
    
//    if (messageDic != nil) {
//        NSDictionary *recordDic = [messageDic valueForKey:@"record"];
//
//        NSNumber *winTempCount = [recordDic objectForKey:@"win"];
//        NSNumber *loseTempCount = [recordDic objectForKey:@"lose"];
//        NSNumber *drawTempCount = [recordDic objectForKey:@"draw"];
//        
//        [self setWinCount:[winTempCount intValue]];
//        [self setLoseCount:[loseTempCount intValue]];
//        [self setDrawCount:[drawTempCount intValue]];
//        
//        CCScene *scoreScene = [CCScene node];
//        [scoreScene addChild:scoreLayer];
//        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:scoreScene withColor:ccWHITE]];
//        
//        
//    }
}

- (void) transGameResult
{
    if (isGameEnd == YES && isEnemyScoreAniEnd == YES && isMyScoreAniEnd == YES) {
        GameResultLayer* gameResultLayer = [GameResultLayer node];
        [gameResultLayer setWinCount:winCount];
        [gameResultLayer setLoseCount:loseCount];
        [gameResultLayer setDrawCount:drawCount];
        if (remainMyHp > remainEnemyHp) {
            [gameResultLayer setGameResult:1];
        } else if(remainMyHp == remainEnemyHp) {
            [gameResultLayer setGameResult:0];
        } else {
            [gameResultLayer setGameResult:2];
        }
        CCScene *gameResultScene = [CCScene node];
        [gameResultScene addChild:gameResultLayer];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:gameResultScene withColor:ccWHITE]];
    }
}
@end
