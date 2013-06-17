//
//  GameLayer.m
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/02.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "MainLayer.h"
#import "ModalAlert.h"
#import "AccountManager.h"



@implementation GameLayer

@synthesize CurrentNumLabel = _cu;
@synthesize currentEnemyHp = _currentEnemyHp;
@synthesize currentMyHp = _currentMyHp;
@synthesize myUserId;
@synthesize enemyUserId;
@synthesize attackPointLabel;

enum {
	kTagTileMap = 1,
	kTagSpriteBatchNode = 1,
	kTagNode = 2,
	kTagAnimation1 = 1,
	kTagSpriteLeft,
	kTagSpriteRight,
};

enum {
	kTagSprite1,
	kTagSprite2,
	kTagSprite3,
	kTagSprite4,
	kTagSprite5,
	kTagSprite6,
	kTagSprite7,
	kTagSprite8,
};

//@synthesize CurrentNum = _currentNum;
//static int currentNumber = 1;


+(CCScene*) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


- (id) init
{
    if (self = [super init]) {
        //_tileCount = 16;
        _tileList = nil;
        _currentMyHp = 100;
        _currentEnemyHp = 100;
        currentTimeForGameStart = waitTimeForGameStart;
        gameRestartWaitTime = waitTimeForGamePlayReStart;
        
    }
    return self;
}

- (void)startGamePlay:(NSInteger)plusSize
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:ACTION_GAME forKey:ACTION_TYPE];
    NSMutableArray *accountArray = [AccountManager allAccount];
    NSString *uuid = nil;
    for (NSDictionary *accountDic in accountArray) {
        myUserId = [accountDic objectForKey:@"acct"];
        uuid = [AccountManager getUUIDByAccountId:[accountDic objectForKey:@"acct"]];
    }
    enemyUserId = [userDefaults objectForKey:@"NumClickEnemyID"];
    
    
    clickedTileCount = 0;
    // TODO
    _currentGamePlayCount= 0;
    
    CCLabelTTF *comboCountLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"x%d", _currentGamePlayCount] fontName:@"Helvetica-Bold" fontSize:24];
    // TODO
    comboCountLabel.position =  ccp(255, 381.5+plusSize);
    comboCountLabel.color = ccc3(255, 255, 255);
    [self addChild:comboCountLabel z:2 tag:902];


    CGSize winSize = [[CCDirector sharedDirector] winSize];
    //    CCSprite * backImage = [CCSprite spriteWithFile:@"common_bg.png"];
    //    backImage.position = CGPointMake(winSize.width/2, winSize.height/2);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotifyFromNotificationCenter:) name:nil object:nil];
    //    if ((myUserId != nil && ![myUserId isEqualToString:@""]) && (enemyUserId != nil && ![enemyUserId isEqualToString:@""])) {
    // 
    //        CCLabelTTF *myUserIdLabel = [CCLabelTTF labelWithString:myUserId fontName:@"Marker Felt" fontSize:24];
    //        myUserIdLabel.position =  ccp(0, winSize.height - 20.5f);
    //        myUserIdLabel.color = ccc3(255, 255, 255);
    //        [self addChild:myUserIdLabel];
    //    }
    //    if (enemyUserId != nil && ![enemyUserId isEqualToString:@""]) {
    //        CCLabelTTF *enemyUserIdLabel = [CCLabelTTF labelWithString:enemyUserId fontName:@"Marker Felt" fontSize:24];
    //        enemyUserIdLabel.position =  ccp(winSize.width-enemyUserIdLabel.contentSize.width, winSize.height - 20.5f);
    //        enemyUserIdLabel.color = ccc3(255, 255, 255);
    //        [self addChild:enemyUserIdLabel];
    //    }
    // TODO
    [self setPlayerHP:plusSize];
    
    //    CCTexture2D* texture = [[CCTextureCache sharedTextureCache] addCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage forKey:nil];
    
    
    
    //    CCTexture2D* tex = [[[CCTexture2D alloc] initWithCGImage:[UIImage imageNamed:@"fish_01.png"].CGImage resolutionType:kCCResolutioniPhone] autorelease];
    
    int sideTileCount = (int)sqrt((double)tileCount);
    
    // TODO iPhone4, iPhone4S, iPhone5の対応が必要
    tileBackgroundWidth = 580;
    tileBackgroundHeight = 556;
    tileHeight = (int)tileBackgroundHeight / sideTileCount;
    tileWidth = (int)tileBackgroundWidth / sideTileCount;
    CGSize tilBackGroundSize = CGSizeMake(tileBackgroundWidth, tileBackgroundHeight);
    
    _tileList = [[CCArray alloc] initWithCapacity:tileCount];
    //    Tile* tile = [Tile spriteWithFile:@"Frame.png" rect:CGRectMake(200, 200 , 40, 40)];
    //
    //
    //            [self addChild:tile z:1];
    _currentNum = 0;
    //        [self addChild:backImage z:0];
    for (int i = 0; i < tileCount; i++) {
        //        Tile* tile = [Tile spriteWithFile:@"" rect:CGRectMake(tileSize.width * (i % sideTileCount), tileSize.height * (i / sideTileCount), tileSize.width, tileSize.height)];
        //       NSLog(@"size : %d", (i % sideTileCount));
        //        Tile* tile = [Tile spriteWithFile:@"Frame.png" rect:CGRectMake(tileHeight * (i % sideTileCount), tileWidth * (i / sideTileCount), tileWidth, tileHeight)];
        
        //                Tile* tile = [Tile spriteWithFile:@"fish_01.png" rect:CGRectMake(0, 0, tileWidth, tileHeight)];
        // TODO
        Tile* tile = [Tile spriteWithCGImage:[self shapingImageNamed:[NSString stringWithFormat:@"main_game_sakana_no%d_1.png",i+1]].CGImage key:[NSString stringWithFormat:@"main_game_sakana_no%d_1",i+1]];
        //[tile addToLayer:self];
        [_tileList addObject:tile];
        tile.Num = i;
        
        
        // Normal Eni
        if ((i % 2) == 1) {
            CCSprite *normalFishImage1 = [CCSprite spriteWithCGImage:[self shapingImageNamed:[NSString stringWithFormat:@"main_game_sakana_no%d_1.png",i+1]].CGImage key:[NSString stringWithFormat:@"main_game_sakana_no%d_1",i+1]];
            CCSprite *normalFishImage2 = [CCSprite spriteWithCGImage:[self shapingImageNamed:[NSString stringWithFormat:@"main_game_sakana_no%d_2.png",i+1]].CGImage key:[NSString stringWithFormat:@"main_game_sakana_no%d_2",i+1]];
            
            
            //
            CCSpriteFrame* normalFishFrame1 = [CCSpriteFrame frameWithTexture:normalFishImage1.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
            CCSpriteFrame* normalFishFrame2 = [CCSpriteFrame frameWithTexture:normalFishImage2.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
            
            tile.normalFishAnimation = [CCAnimation animation];
            
            [tile.normalFishAnimation addSpriteFrame:normalFishFrame1];
            
            [tile.normalFishAnimation addSpriteFrame:normalFishFrame2];
            
            tile.normalFishAnimation.delayPerUnit = 0.5;
            
            tile.normalFishAnimation.loops = -1;
            
            
            tile.normalFishAnimate   = [CCAnimate actionWithAnimation:tile.normalFishAnimation];
        } else{
            CCSprite *normalFishImage1 = [CCSprite spriteWithCGImage:[self shapingImageNamed:[NSString stringWithFormat:@"main_game_sakana_no%d_2.png",i+1]].CGImage key:[NSString stringWithFormat:@"main_game_sakana_no%d_2",i+1]];
            CCSprite *normalFishImage2 = [CCSprite spriteWithCGImage:[self shapingImageNamed:[NSString stringWithFormat:@"main_game_sakana_no%d_1.png",i+1]].CGImage key:[NSString stringWithFormat:@"main_game_sakana_no%d_1",i+1]];
            
            
            //
            CCSpriteFrame* normalFishFrame1 = [CCSpriteFrame frameWithTexture:normalFishImage1.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
            CCSpriteFrame* normalFishFrame2 = [CCSpriteFrame frameWithTexture:normalFishImage2.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
            
            tile.normalFishAnimation = [CCAnimation animation];
            
            [tile.normalFishAnimation addSpriteFrame:normalFishFrame1];
            
            [tile.normalFishAnimation addSpriteFrame:normalFishFrame2];
            
            tile.normalFishAnimation.delayPerUnit = 0.5;
            
            tile.normalFishAnimation.loops = -1;
            
            
            tile.normalFishAnimate   = [CCAnimate actionWithAnimation:tile.normalFishAnimation];

        } 
       

        
        
        // Error Ani
        
        
        
        tile.animation = [CCAnimation animation];
        
        
        
        CCSprite *frameImage1 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"main_game_sakana_error.png"].CGImage key:[NSString stringWithFormat:@"main_game_sakana_error"]];
        CCSprite *frameImage2 = [CCSprite spriteWithCGImage:[self shapingImageNamed:[NSString stringWithFormat:@"main_game_sakana_no%d_1.png",i+1]].CGImage key:[NSString stringWithFormat:@"main_game_sakana_no%d_1",i+1]];
//        CCSprite *frameImage3 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_03.png"].CGImage key:nil];
//        CCSprite *frameImage4 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage key:nil];
        //
        CCSpriteFrame* frame1 = [CCSpriteFrame frameWithTexture:frameImage1.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
        CCSpriteFrame* frame2 = [CCSpriteFrame frameWithTexture:frameImage2.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
//        CCSpriteFrame* frame3 = [CCSpriteFrame frameWithTexture:frameImage3.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
//        CCSpriteFrame* frame4 = [CCSpriteFrame frameWithTexture:frameImage4.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
        
        [tile.animation addSpriteFrame:frame1];
        
        [tile.animation addSpriteFrame:frame2];
        //
//        [tile.animation addSpriteFrame:frame3];
//        
//        [tile.animation addSpriteFrame:frame4];
        
        tile.animation.delayPerUnit = 0.8;
        
        tile.animation.loops = 1;
        
        
        tile.animate   = [CCAnimate actionWithAnimation:tile.animation];
        
        
        // Bone Fish Ani
        
        tile.boneFishAnimation = [CCAnimation animation];
        CCSprite *boneFishFrameImage1 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"main_game_sakana_bone.png"].CGImage key:@"main_game_sakana_bone"];
        CCSprite *boneFishFrameImage2 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"main_game_sakana_bone.png"].CGImage key:@"main_game_sakana_bone"];
        CCSpriteFrame* boneFishframe1 = [CCSpriteFrame frameWithTexture:boneFishFrameImage1.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
        CCSpriteFrame* boneFishframe2 = [CCSpriteFrame frameWithTexture:boneFishFrameImage2.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
        //        CCSpriteFrame* frame3 = [CCSpriteFrame frameWithTexture:frameImage3.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
        //        CCSpriteFrame* frame4 = [CCSpriteFrame frameWithTexture:frameImage4.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
        
        [tile.boneFishAnimation addSpriteFrame:boneFishframe1];
        [tile.boneFishAnimation addSpriteFrame:boneFishframe2];

        //
        //        [tile.animation addSpriteFrame:frame3];
        //
        //        [tile.animation addSpriteFrame:frame4];
        
        tile.boneFishAnimation.delayPerUnit = 1;
        
        tile.boneFishAnimation.loops = -1;
        
        
        tile.bonFishAnimate   = [CCAnimate actionWithAnimation:tile.boneFishAnimation];
        
        [self addChild:tile z:1 tag:i];
        
        
//        [tile runAction:tile.normalFishAnimate ];
        
        // Normal Ani
        
        // 画像の
        
        //        CCSprite* tile = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage key:nil];
        //        CCAnimation *animation = [CCAnimation animation];
        //        [_tileList addObject:tile];
        //        //tile.Num = i;
        //        
        //        [self addChild:tile z:1];
        //        CCSprite *frameImage1 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage key:nil];
        //        CCSprite *frameImage2 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_02.png"].CGImage key:nil];
        //        CCSprite *frameImage3 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_03.png"].CGImage key:nil];
        //        //
        //        CCSpriteFrame* frame1 = [CCSpriteFrame frameWithTexture:frameImage1.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
        //        CCSpriteFrame* frame2 = [CCSpriteFrame frameWithTexture:frameImage2.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
        //        CCSpriteFrame* frame3 = [CCSpriteFrame frameWithTexture:frameImage3.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
        
        
        
        //        if (texture)
        //        {
        //            // Get the size of the new texture:
        //            CGSize size = [texture contentSize];
        //            Tile* tile = [Tile spriteWithFile:@"fish_01.png"];
        //
        ////            Tile* tile = [Tile spriteWithCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage key:nil];
        //            tile.Num = i;
        //            [_tileList addObject:tile];
        //        CCSprite* tile = [CCSprite spriteWithFile:@"fish_01.png"];
        
        //            Tile* tile = [Tile spriteWithCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage key:nil];
        
        
        
        //[tile createAnimation];
        
        //            [sprite1 setTexture:texture];
        // use the size of the new texture:
        //            [sprite1 setTextureRect:CGRectMake(0.0f, 0.0f, size.width,size.height)];
        //        }
        //        Tile* tile = [Tile spriteWithFile:@"fish_01.png" rect:CGRectMake(0, 0, 60, 60)];
        
        
    }
    [self shuffle];
    [self setTiles];
    
    
    //    CCSprite * progressBorder = [CCSprite spriteWithFile: @ "progressbarborder.png"];
    //	[progressBorder setPosition:ccp(winSize.width/2 + 0.5 - 45, winSize.height - 20.5f)];
    //	[self addChild: progressBorder z:1];
    //    
    //    CCProgressTimer *lifeBar=[CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:@"progressbar.png"]];
    //    lifeBar.type=kCCProgressTimerTypeBar;
    //    lifeBar.midpoint = ccp(0,0);
    //    lifeBar.position=ccp(winSize.width/2 + 0.5 - 45, winSize.height - 20.5f);
    //    lifeBar.percentage=100;
    //    [lifeBar setBarChangeRate:(ccp(1,0))];
    //    [self addChild:lifeBar z:1];
    //    //[lifeBar runAction:[CCProgressFromTo actionWithDuration:gameLimitedSecond from:100.0 to:0.0]];
    //    
    //    CCProgressTo *progressTo = [CCProgressTo actionWithDuration:gameLimitedSecond percent:100];
    //	[lifeBar runAction:progressTo];
    ////    [self addChild:lifeBar z:1];
    //    //[lifeBar runAction:[CCProgressFromTo actionWithDuration:gameLimitedSecond from:100.0 to:0.0]];
    //    CCCallFunc *cbDecrFinished = [CCCallFunc actionWithTarget:self selector:@selector(decreaseProgressBarFinished:)];
    //	CCProgressFromTo *progressToZero = [CCProgressFromTo actionWithDuration:gameLimitedSecond from:100.0 to:0.0];
    //	CCSequence *asequence = [CCSequence actions:progressToZero, cbDecrFinished, nil];
    //    
    //	[lifeBar runAction:asequence];
    
    
    //	CCProgressTimer* progressBar = [CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:@"progressbar.png"]];
    //	progressBar.type = kCCProgressTimerTypeBar;
    //    
    //	
    //	[progressBar setAnchorPoint: ccp(0,0)];
    //
    //    CCProgressTo *progressTo = [CCProgressTo actionWithDuration:10 percent:100];
    //	[progressBar runAction:progressTo];
    //    
    
    _timerLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%.f",gameLimitedSecond] fontName:@"Helvetica-Bold" fontSize:50];
    _timerLabel.position = CGPointMake(winSize.width/2, 44);
    _timerLabel.color = ccc3(0, 0, 0);
    _timer = gameLimitedSecond;
    [self addChild:_timerLabel];
    
    CCLabelTTF* timeSecLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@",@"Sec"] fontName:@"Helvetica-Bold" fontSize:20];
    timeSecLabel.position = CGPointMake(winSize.width/2, 15);
    timeSecLabel.color = ccc3(0, 0, 0);
    [self addChild:timeSecLabel];
    
    [self schedule:@selector(updateTimer) interval:1];
}

- (void) onEnter
{
    [super onEnter];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSString* actionType = [userDefaults objectForKey:ACTION_TYPE];
//    if ([actionType isEqualToString:ACTION_BACKGROUND]) {
//        [userDefaults setObject:ACTION_MAIN forKey:ACTION_TYPE];
//        [ModalAlert Tell:@"前回、異常終了の為、メイン画面に戻ります。" onLayer:self okBlock:^{
//            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainLayer scene] withColor:ccWHITE]];
//        }];
//        // gameOverの呼び出し
//        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainLayer scene] withColor:ccWHITE]];
//        return;
//    }
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) {
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite * backImage = [CCSprite spriteWithFile:@"common_bg-568h@2x.png"];
        backImage.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:backImage z:0];
        [self setUpMainImage:88];
        
        [userDefaults setObject:ACTION_GAME forKey:ACTION_TYPE];
        [userDefaults synchronize];
        
        NSNumber *tempCurrentGameCount = [userDefaults objectForKey:@"CurrentGameCount"];
        _currentGameCount =[tempCurrentGameCount intValue];
        
        _currentGameCount =  _currentGameCount + 1;
        
        
        currentTimeForGameStart = waitTimeForGameStart;
        gameRestartWaitTime = waitTimeForGamePlayReStart;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        waitTimeLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%.f",currentTimeForGameStart] fontName:@"Helvetica-Bold" fontSize:50];
        waitTimeLabel.position = CGPointMake(winSize.width/2, winSize.height/2);
        waitTimeLabel.color = ccc3(0, 0, 0);
        [self addChild:waitTimeLabel z:6];
        
        
        currentRoundLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Round %d!",_currentGameCount] fontName:@"Helvetica-Bold" fontSize:50];
        // TODO
        currentRoundLabel.position = CGPointMake(winSize.width/2,290+88);
        currentRoundLabel.color = ccc3(0, 0, 0);
        [self addChild:currentRoundLabel z:6];
        [self schedule:@selector(updateWaitTimeForGameStart) interval:1];
        
    } else {
        CGSize wsize = [[CCDirector sharedDirector] winSize];
        CCSprite * backImage = [CCSprite spriteWithFile:@"common_bg.png"];
        backImage.position = CGPointMake(wsize.width/2, wsize.height/2);
        [self addChild:backImage z:0];
        
        [self setUpMainImage:0];
        
        [userDefaults setObject:ACTION_GAME forKey:ACTION_TYPE];
        [userDefaults synchronize];
        
        NSNumber *tempCurrentGameCount = [userDefaults objectForKey:@"CurrentGameCount"];
        _currentGameCount =[tempCurrentGameCount intValue];
        
        _currentGameCount =  _currentGameCount + 1;
        
        
        currentTimeForGameStart = waitTimeForGameStart;
        gameRestartWaitTime = waitTimeForGamePlayReStart;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        waitTimeLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%.f",currentTimeForGameStart] fontName:@"Helvetica-Bold" fontSize:50];
        waitTimeLabel.position = CGPointMake(winSize.width/2, winSize.height/2);
        waitTimeLabel.color = ccc3(0, 0, 0);
        [self addChild:waitTimeLabel z:6];
        
        
        currentRoundLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Round %d!",_currentGameCount] fontName:@"Helvetica-Bold" fontSize:50];
        // TODO
        currentRoundLabel.position = CGPointMake(winSize.width/2,290);
        currentRoundLabel.color = ccc3(0, 0, 0);
        [self addChild:currentRoundLabel z:6];
        [self schedule:@selector(updateWaitTimeForGameStart) interval:1];
    }
    

    
//    [self startGamePlay];
//    // create and initialize a Label
//    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game画面" fontName:@"Marker Felt" fontSize:24];
//    CGSize size = [[CCDirector sharedDirector] winSize];
//    label.position =  ccp(size.width/2 ,380);
//    
//    [self addChild: label];
    
}

- (void) onExit
{
    [super onExit];
    [self removeAllChildrenWithCleanup:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) setUpMainImage:(NSInteger)plusSize
{

    
    CCSprite * comboImage = [CCSprite spriteWithFile:@"main_game_playground_combo1.png"];
    comboImage.position = ccp(164, 369+plusSize);
    [self addChild:comboImage z:1 tag:901];
    
    CCSprite * gameMainImage = [CCSprite spriteWithFile:@"main_game_playground.png"];
    gameMainImage.position = CGPointMake(160, 221+plusSize);
    [self addChild:gameMainImage z:1];
    

}

- (void) onEnterTransitionDidFinish
{
    
    apiConnection = [APIConnection sharedAPIConnection];
    apiConnection.delegate = self;
    
}

- (void)updateWaitTimeForGameStart
{
    currentTimeForGameStart -= 1;
    if (0 == currentTimeForGameStart) {
        [self unschedule:@selector(updateWaitTimeForGameStart)];
        [waitTimeLabel setString:[NSString stringWithFormat:@"%.f",0.0]];
        [waitTimeLabel setVisible:NO];
        [currentRoundLabel setVisible:NO];
        [self removeChild:currentRoundLabel cleanup:YES];

        [self removeChild:waitTimeLabel cleanup:YES];
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        if (screenBounds.size.height == 568) {
            [self startGamePlay:88];
        } else {
            [self startGamePlay:0];
        }
        return;
    }
    [waitTimeLabel setString:[NSString stringWithFormat:@"%.f",currentTimeForGameStart]];
}

- (void)updateTimer{
    _timer -= 1;
    
    if (0 == _timer) {
        
        [_timerLabel setString:[NSString stringWithFormat:@"0.0"]]; // -0.0と表示されてしまうため0の時は特別に。
        // タイマーを止める
        [self unschedule:@selector(updateTimer)];
        // gameOverの呼び出し
        [self gameOver];
        return;
    }
    [_timerLabel setString:[NSString stringWithFormat:@"%.f",_timer]];
}


- (void) setTiles
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CGSize tileSize = ((Tile*)[_tileList objectAtIndex:0]).contentSize;
    
    int sideTileCount = (int)sqrt((double)tileCount);
    
    float startX = 15;
    
    float startY = 120;
    
    float blankX = (winSize.width - tileSize.width * sideTileCount) / 2;
    
    float blankY = (winSize.height - tileSize.height * sideTileCount) / 2;
    
    for (int i = 0; i < _tileList.count; i++) {
//        Tile *tile = [_tileList objectAtIndex:i];
//        tile.Now = i;

        Tile *tile = [_tileList objectAtIndex:i];
        [tile setIsBone:NO];
        [tile stopAction:tile.bonFishAnimate];
        [tile runAction:tile.normalFishAnimate];
//        [tile setClickNumLabel];
        [tile.NumLabel setVisible:YES];
        tile.position = CGPointMake(startX + tileSize.width / 2 + tileSize.width * (i % sideTileCount), winSize.height -startY - tileSize.height / 2 - tileSize.height * (i / sideTileCount));
        [tile setOrigPositionX:tile.position.x];
        [tile setOrigPositionY:tile.position.y];
        tile.actionList = [[[NSMutableArray alloc] init] autorelease];
        [tile setTileAction];
        [tile shuffleAction];
        [tile addOriginMoveAction];

        [tile addSchedule];
//        [tile scheduleUpdate];
        

        
//        [tile createAnimation];
//        CCAnimation *animation= [CCAnimation animation];
//        [animation addSpriteFrameWithFilename:@"fish_01.png"];
//        
//        [animation addSpriteFrameWithFilename:@"fish_02.png"];
//        
//        [animation addSpriteFrameWithFilename:@"fish_03.png"];
//        
//        
//        animation.delayPerUnit = 0.5;
//        
//        animation.loops = -1;
        //tile.animate = [CCAnimate actionWithAnimation:tile.animation];
        //CCAnimation *walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:0.1f ];
//        CCAnimate *animate  = [CCAnimate actionWithAnimation:animation];
//        tile.animate = [[CCRepeatForever actionWithAction:animate] retain];

        
//        CCSprite *tile = [_tileList objectAtIndex:i];
////        tile.Now = i;
//        
//        tile.position = CGPointMake(startX + tileSize.width / 2 + tileSize.width * (i % sideTileCount), winSize.height -startY - tileSize.height / 2 - tileSize.height * (i / sideTileCount));
//        //[tile createAnimation];
//        CCAnimation *animation= [CCAnimation animation];
//        [animation addSpriteFrameWithFilename:@"fish_01.png"];
//        
//        [animation addSpriteFrameWithFilename:@"fish_02.png"];
//        
//        [animation addSpriteFrameWithFilename:@"fish_03.png"];
//        
//        
//        animation.delayPerUnit = 0.5;
//        
//        animation.loops = -1;
//        //tile.animate = [CCAnimate actionWithAnimation:tile.animation];
//        //CCAnimation *walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:0.1f ];
//        CCAnimate *animate  = [CCAnimate actionWithAnimation:animation];
//        [tile runAction:animate];
////        tile.animate = [[CCRepeatForever actionWithAction:animate] retain];
//        [tile setTag:i];
//        [self addChild:tile z:1];
//        [CCCallFunc actionWithTarget:self selector:@selector(stopAni:)];

    }
}

//- (void) removeTiles
//{
//    for (int i = 0; i < _tileList.count; i++) {
//        //Tile *tile = [_tileList objectAtIndex:i];
//        [self removeChildByTag:i cleanup:YES];
////        [self removeChild:tile cleanup:YES];
//        [_tileList removeAllObjects];
//    }
//}

- (void)plusCountCombo:(NSInteger)plusSize
{
    [self removeChildByTag:901 cleanup:YES];
    CCSprite * comboImage = [CCSprite spriteWithFile:[NSString stringWithFormat:@"main_game_playground_combo%d.png", _currentGamePlayCount]];
    comboImage.position = ccp(164, 369+plusSize);
    [self addChild:comboImage z:0 tag:901];
    
    [self removeChildByTag:902 cleanup:YES];
    CCLabelTTF *comboCountLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"x%d", _currentGamePlayCount] fontName:@"Helvetica-Bold" fontSize:24];
    comboCountLabel.position =  ccp(255, 381.5+plusSize);
    comboCountLabel.color = ccc3(255, 255, 255);
    [self addChild:comboCountLabel z:2 tag:902];
}

- (void) NotifyFromNotificationCenter:(NSNotification *)notification
{
    if ([notification.name isEqual:NUM_CLICK]) {

            Tile *tempTile = [notification object];
            if (tempTile.Num == _currentNum) {
                clickedTileCount += 1;
                NSLog(@"clickedTileCount : %d", clickedTileCount);
                _currentNum = _currentNum + 1;
                //attackPointLabel = (CCLabelTTF)[self getChildByTag:3001];
                attackPointLabel.string = [NSString stringWithFormat:@"%d",clickedTileCount * attackBaseScore];
                
                if (_currentNum == tileCount) {
                    [tempTile stopAllActions];
                    [tempTile unscheduleAllSelectors];
                    [self unschedule:@selector(updateTimer)];
                    [[NSNotificationCenter defaultCenter] postNotificationName:GAME_END object:self];


                } else {

                     [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"CountNum-%d", tempTile.Num] object:self];

//                    CCSprite *boneFish = [CCSprite spriteWithCGImage:[self shapingImageNamed:[NSString stringWithFormat:@"main_game_sakana_bone.png"]].CGImage key:nil];
//                    boneFish.position = ccp(tempTile.position.x, tempTile.position.y);
//                    [self addChild:boneFish z:3 tag:800+tempTile.Num];
                }

            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"AnimationTileNum-%d", tempTile.Num] object:self];
            }


    } else if([notification.name isEqual: GAME_PLAY_END]) {
        _currentNum = 0;
        _currentGamePlayCount = _currentGamePlayCount + 1;
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        // TODO
        if (screenBounds.size.height == 568) {
        
            [self plusCountCombo:88];
        } else {
            [self plusCountCombo:0];
            
        }
        
        //[self removeTiles];
        if (gamePalyCount >= _currentGamePlayCount) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:GAME_RESTART object:self];
            
            
        } else {
            
        }


    } else if([notification.name isEqualToString:GAME_RESTART]) {
//        [self schedule:@selector(waitTimeForGameRestartEnd) interval:1];
        
        [self shuffle];
        [self setTiles];
        [self schedule:@selector(updateTimer)  interval:1];

    }
    if (tileCount == _currentNum) {
        [[NSNotificationCenter defaultCenter] postNotificationName:GAME_PLAY_END object:self];
        [self unscheduleUpdate];
    }
}

- (void)shuffle
{
    for (uint i = 0; i < _tileList.count; ++i)
    {
        // Select a random element between i and end of array to swap with.
        int nElements = _tileList.count - i;
        int n = arc4random_uniform(nElements) + i;
        [_tileList exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

// 画像を自己と同じサイズに加工して返します
-(UIImage*) shapingImageNamed:(NSString*)imageNamed
{
	UIImage* resultImage = [UIImage imageNamed:imageNamed];
	
	UIGraphicsBeginImageContext(CGSizeMake(tileWidth, tileHeight));
	[resultImage drawInRect:CGRectMake(0, 0, tileWidth, tileHeight)];
	resultImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return resultImage;
}

-(void) removeAndAddSprite:(ccTime) dt
{
	id batch = [self getChildByTag:kTagSpriteBatchNode];
	id sprite = [batch getChildByTag:kTagSprite5];
    
	[sprite retain];
    
	[batch removeChild:sprite cleanup:NO];
	[batch addChild:sprite z:0 tag:kTagSprite5];
    
	[sprite release];
}

- (void)gameOver {
    
    // TODO 重複を解決
    for (int i = 0; i < tileCount; i++) {
        Tile *tile = [_tileList objectAtIndex:i];
        [tile setVisible:NO];
    }
    gameEndLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"ゲーム%dラウンド終了！", _currentGameCount] fontName:@"Marker Felt" fontSize:30];
    CGSize size = [[CCDirector sharedDirector] winSize];
    // position the label on the center of the screen
    // TODO 位置選定が必要
    gameEndLabel.position =  ccp(size.width/2 ,size.height/2);
    gameEndLabel.color = ccc3(0, 0, 0);
    [self doAddUpScore];
//    [self addChild: gameEndLabel];
//   [self runAction: [CCSequence actions:
//            [CCDelayTime actionWithDuration: 1],
//            [CCCallFunc actionWithTarget:self selector:@selector(doAddUpScore)],
//            nil]];
}

- (void) doAddUpScore
{
    [self removeChild:gameEndLabel cleanup:YES];
    
    scoreAddUpLabel = [CCLabelTTF labelWithString:@"集計中！" fontName:@"Marker Felt" fontSize:30];
    CGSize size = [[CCDirector sharedDirector] winSize];
    // position the label on the center of the screen
    // TODO 位置選定が必要
    scoreAddUpLabel.position =  ccp(size.width/2 ,size.height/2);
    scoreAddUpLabel.color = ccc3(0, 0, 0);
    [self addChild: scoreAddUpLabel z:5];

    // 現在のクリックかうんと保存
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setInteger:clickedTileCount forKey:@"ClickedTileCount"];
    [userDefaults setInteger:_currentGameCount forKey:@"CurrentGameCount"];
    [userDefaults synchronize];

    
    [CCMenuItemFont setFontName:@"Helvetica-BoldOblique"];
    [CCMenuItemFont setFontSize:30];
    
    scoreLayer = [ScoreAddUpLayer node];
    [scoreLayer setCurrentEnemyHp:_currentEnemyHp];
    [scoreLayer setCurrnetMyHp:_currentMyHp];
    [scoreLayer setMyUserId:myUserId];
    [scoreLayer setEnemyUserId:enemyUserId];
    [scoreLayer setCombo:_currentGamePlayCount];
    [scoreLayer setCount:clickedTileCount];
    CCScene *scoreScene = [CCScene node];
    [scoreScene addChild:scoreLayer];

    NSLog(@"_currentMyHp :%f", _currentMyHp);
    NSLog(@"_currentEnemyHp :%f", _currentEnemyHp);
    NSLog(@"scoreLayer.currentMyHp :%f", scoreLayer.currnetMyHp);
    NSLog(@"scoreLayer.currentEnemyHp :%f", scoreLayer.currentEnemyHp);

    NSString* actionType = [userDefaults objectForKey:ACTION_TYPE];
    
    if ([actionType isEqualToString:ACTION_BACKGROUND]) {
        [userDefaults setObject:ACTION_MAIN forKey:ACTION_TYPE];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainLayer scene] withColor:ccWHITE]];
        
    } else {
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:scoreScene withColor:ccWHITE]];
    }
    
    //    CCMenuItemFont *item = [CCMenuItemFont itemWithString:@"Main画面へ" block:^(id sender){
    //
    //        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainLayer scene] withColor:ccWHITE]];
    //
    //    }];
    //    CCMenu *menu = [CCMenu menuWithItems:item, nil];
    //    menu.position = CGPointMake(size.width/2, 250);
    //    menu.color = ccc3(255,255,255);
    
    // add the label as a child to this Layer
    
    //    [self addChild: menu];


  
}

- (void) decreaseProgressBarFinished:(id)sender {
    
//    [self gameOver];
    
}



//- (void) receivedMessageFromGameEnd:(NSDictionary *)messageDic
//{
//    if (messageDic != nil) {
//        NSDictionary *recordDic = [messageDic valueForKey:@"record"];
//
//        NSNumber *tempWinCount = [recordDic objectForKey:@"win"];
//        NSNumber *tempLoseCount = [recordDic objectForKey:@"lose"];
//        NSNumber *tempDrawCount = [recordDic objectForKey:@"draw"];
//
//        [scoreLayer setWinCount:[tempWinCount intValue]];
//        [scoreLayer setLoseCount:[tempLoseCount intValue]];
//        [scoreLayer setDrawCount:[tempDrawCount intValue]];
//
//        CCScene *scoreScene = [CCScene node];
//        [scoreScene addChild:scoreLayer];
//        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:scoreScene withColor:ccWHITE]];
//
//
//    }
//}

- (void) receivedErrorFromAction:(NSString *)message
{
    if ([message isEqualToString:ERROR_ALREADY_FIGHTING]) {
        // TODO すでに敵
    } else if([message isEqualToString:ERROR_NO_LOGIN]) {
        // TODO ログインされてない状態
    } else if([message isEqualToString:ERROR_ENEMY_DISCONNECTED]) {


        scoreLayer = [ScoreAddUpLayer node];
        [scoreLayer setCurrentEnemyHp:_currentEnemyHp];
        [scoreLayer setCurrnetMyHp:_currentMyHp];
        [scoreLayer setMyUserId:myUserId];
        [scoreLayer setEnemyUserId:enemyUserId];
        [scoreLayer setCombo:0];
        [scoreLayer setCount:0];
        [scoreLayer setIsEnemyDissconnected:YES];
        CCScene *scoreScene = [CCScene node];
        [scoreScene addChild:scoreLayer];

        NSLog(@"_currentMyHp :%f", _currentMyHp);
        NSLog(@"_currentEnemyHp :%f", _currentEnemyHp);
        NSLog(@"scoreLayer.currentMyHp :%f", scoreLayer.currnetMyHp);
        NSLog(@"scoreLayer.currentEnemyHp :%f", scoreLayer.currentEnemyHp);
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:scoreScene withColor:ccWHITE]];

        
    }
    
}

- (void) receivedMessageFromAddUpScore:(NSDictionary*)messageDic
{
    NSDictionary *enemyHpDic = [messageDic valueForKey:@"enemy"];
    if (enemyHpDic != nil) {
        
        
        NSDictionary *myHpDic = [messageDic valueForKey:@"score"];
        NSDictionary *enemyHpDic = [messageDic valueForKey:@"enemy"];
        
        // TODO
        NSNumber *tempRemainMyHp = [myHpDic valueForKey:@"hp"];
        NSNumber *tempRemainEnemyHp = [enemyHpDic valueForKey:@"hp"];
        signed int remainingMyHp = [tempRemainMyHp intValue];
        signed int remainingEnemyHp = [tempRemainEnemyHp intValue];
        
        NSNumber *tempMyScore = [myHpDic valueForKey:@"point"];
        NSNumber *tempEnemyScore = [enemyHpDic valueForKey:@"point"];
        
        NSNumber *tempEnemyCombo = [enemyHpDic valueForKey:@"combo"];
        int myScoreIntValue = [tempMyScore intValue];
        int enemyScoreIntValue = [tempEnemyScore intValue];
        int enemyCombo = [tempEnemyCombo intValue];
        //        remainingEnemyHp = 60;
        //        remainingMyHp = 83;
        NSLog(@"RemaingMyHp :%d", remainingMyHp);
        NSLog(@"remainingEnemyHp :%d", remainingEnemyHp);
                scoreLayer = [ScoreAddUpLayer node];
        
        [scoreLayer setMyUserId:myUserId];
        [scoreLayer setEnemyUserId:enemyUserId];

        [scoreLayer setCurrentEnemyHp:_currentEnemyHp];
        [scoreLayer setCurrnetMyHp:_currentMyHp];
        [scoreLayer setMyUserId:myUserId];
        [scoreLayer setEnemyUserId:enemyUserId];
        [scoreLayer setCombo:_currentGamePlayCount];
        [scoreLayer setCount:clickedTileCount];
        [scoreLayer setIsGameEnd:YES];
        CCScene *scoreScene = [CCScene node];
        [scoreScene addChild:scoreLayer];
        //        scoreLayer.currnetMyHp = _currentMyHp;
        //        scoreLayer.currentEnemyHp = _currentEnemyHp;
        //        scoreLayer.remainEnemyHp = remainingEnemyHp;
        
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:scoreScene withColor:ccWHITE]];
    }
}


- (void) setPlayerHP:(NSInteger)plusSize
{
//    CGSize winSize = [[CCDirector sharedDirector] winSize];
//    CCLabelTTF *label = [CCLabelTTF labelWithString:@"集計" fontName:@"Marker Felt" fontSize:24];
//    label.position =  ccp(winSize.width/2 ,380);
//    label.color = ccc3(255, 255, 255);
//    [self addChild:label];
    
    CCLabelTTF *attackLabel = [CCLabelTTF labelWithString:@"attack count" fontName:@"Marker Felt" fontSize:10];
    attackLabel.position =  ccp(29, 400.5+plusSize);
    attackLabel.color = ccc3(0, 0, 0);
    attackLabel.anchorPoint = ccp(0.5, 0.5);
    [self addChild:attackLabel];
    
    attackPointLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:24];
    attackPointLabel.position =  ccp(14, 396+plusSize);
    attackPointLabel.color = ccc3(0, 0, 0);
    attackPointLabel.anchorPoint = ccp(0.0, 1.0);
    attackPointLabel.dimensions = CGSizeMake(100, 0);
    [self addChild:attackPointLabel z:3 tag:3001];
    
    CCSprite * myHpBarProgressBorder = [CCSprite spriteWithFile: @"main_game_guage_bg_me.png"];
    [myHpBarProgressBorder setPosition:ccp(81, 440.5+plusSize)];
    [self addChild: myHpBarProgressBorder z:1];
    
    CCSprite * myCharacterImage = [CCSprite spriteWithFile: @"main_game_guage_cha_me.png"];
    [myCharacterImage setPosition:ccp(27, 451+plusSize)];
    [self addChild: myCharacterImage z:2];

//    if ((myUserId != nil && ![myUserId isEqualToString:@""]) && (enemyUserId != nil && ![enemyUserId isEqualToString:@""])) {

       
        CCLabelTTF *myUserIdLabel = [CCLabelTTF labelWithString:myUserId fontName:@"Marker Felt" fontSize:10];
        myUserIdLabel.position =  ccp(47.5, 432.2+plusSize);
        myUserIdLabel.color = ccc3(0, 0, 0);
        myUserIdLabel.anchorPoint = ccp(0.0, 1.0);
        [self addChild:myUserIdLabel];
    
        CCProgressTimer *myHpBarProgressFrom=[CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:@"main_game_guage_me.png"]];
        myHpBarProgressFrom.type=kCCProgressTimerTypeBar;
//        myHpBarProgressFrom.midpoint = ccp(0,_currentMyHp);
                myHpBarProgressFrom.midpoint = ccp(0,0);
        myHpBarProgressFrom.position=ccp(98, 445+plusSize);
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
        CCProgressFromTo *myHpBarProgressToZero = [CCProgressFromTo actionWithDuration:GAME_DISPLAY_ACTION_IN_DURATION from:100 to:_currentMyHp];
        CCSequence *asequence = [CCSequence actions:myHpBarProgressToZero, cbDecrFinished, nil];
        
        [myHpBarProgressFrom runAction:asequence];
//    }

    
//    if (enemyUserId != nil && ![enemyUserId isEqualToString:@""]) {

        
//        CCSprite * progressBorder2 = [CCSprite spriteWithFile: @ "progressbarborder.png"];
//        [progressBorder2 setPosition:ccp(260, 434)];
//        [self addChild: progressBorder2 z:1];
    
    CCLabelTTF *enemyUserIdLabel = [CCLabelTTF labelWithString:enemyUserId fontName:@"Marker Felt" fontSize:10];
    enemyUserIdLabel.position =  ccp(272.5, 432.2+plusSize);
    enemyUserIdLabel.color = ccc3(0, 0, 0);
    enemyUserIdLabel.anchorPoint = ccp(1.0, 1.0);
    [self addChild:enemyUserIdLabel];
//
//        CCLabelTTF *enemyUserIdLabel = [CCLabelTTF labelWithString:enemyUserId fontName:@"Marker Felt" fontSize:24];
//        enemyUserIdLabel.position =  ccp(260, 400);
//        enemyUserIdLabel.color = ccc3(255, 255, 255);
//        [self addChild:enemyUserIdLabel];
    
    CCSprite * enemyHpBarProgressBorder = [CCSprite spriteWithFile: @"main_game_guage_bg_enemy.png"];
    [enemyHpBarProgressBorder setPosition:ccp(241.5, 440.5+plusSize)];
    [self addChild: enemyHpBarProgressBorder z:1];
    
    CCSprite * enemyCharacterImage = [CCSprite spriteWithFile: @"main_game_guage_cha_enemy.png"];
    [enemyCharacterImage setPosition:ccp(293, 451+plusSize)];
    [self addChild: enemyCharacterImage z:2];

    
        CCProgressTimer *enemyHpProgressFrom=[CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:@"main_game_guage_enemy.png"]];
        enemyHpProgressFrom.type=kCCProgressTimerTypeBar;
//        enemyHpProgressFrom.midpoint = ccp(1,_currentEnemyHp);
        enemyHpProgressFrom.midpoint = ccp(1,0);

        enemyHpProgressFrom.position=ccp(225, 445+plusSize);
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
        CCProgressFromTo *enemyHpBarProgressToZero2 = [CCProgressFromTo actionWithDuration:GAME_DISPLAY_ACTION_IN_DURATION from:100 to:_currentEnemyHp];
        CCSequence *asequence2 = [CCSequence actions:enemyHpBarProgressToZero2, cbDecrFinished2, nil];
        
        [enemyHpProgressFrom runAction:asequence2];
//    }
}

- (void) decreaseProgressBarFinished2:(id)sender
{
    
}

- (void) decreaseProgressBarFinished3:(id)sender
{
    
}

- (void)waitTimeForGameRestartEnd{

    gameRestartWaitTime -= 1;
    
    if (0 == gameRestartWaitTime) {
//        
//        [_timerLabel setString:[NSString stringWithFormat:@"0.0"]]; // -0.0と表示されてしまうため0の時は特別に。
        // タイマーを止める
        [self unschedule:@selector(waitTimeForGameRestartEnd)];
        // gameOverの呼び出し
//        [self gameOver];
        


        gameRestartWaitTime = waitTimeForGamePlayReStart;
        
        return;
    }
//    [_timerLabel setString:[NSString stringWithFormat:@"%.f",_timer]];
}

- (void) receivedMessageFromLoginToServer:(NSDictionary *)messageDic
{
    BOOL result = NO;
    if (messageDic != nil) {
        result = [messageDic valueForKey:@"login"];
        NSLog(@"result : %d", result);
    }
    

}

- (void) receivedMessageFromApplyGame:(NSDictionary *)messageDic
{
    
}

@end
