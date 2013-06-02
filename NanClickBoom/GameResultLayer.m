//
//  GameResultLayer.m
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/16.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameResultLayer.h"
#import "MainLayer.h"
#import "ModalAlert.h"
#import "IntroLayer.h"


@implementation GameResultLayer

@synthesize loseCount, winCount, drawCount, gameResult, isForceGameEnd;

- (id) init
{
    if (self = [super init]) {
        //_tileCount = 16;
        winCount = 0;
        loseCount = 0;
        drawCount = 0;
        gameResult = -1;
        apiConnection = nil;
        
    }
    return self;
}

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameResultLayer *layer = [GameResultLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void)setGameResultImage
{
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    //    CCLabelTTF *label = [CCLabelTTF labelWithString:@"ゲーム終了" fontName:@"AmericanTypewriter-Bold" fontSize:24];
    //    label.position =  ccp(size.width/2 ,380);
    //    label.color = ccc3(0, 0, 0);
    //    [self addChild:label z:1];
    
    CCLabelTTF *winCountlabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", winCount] fontName:@"AmericanTypewriter-Bold" fontSize:60];
    winCountlabel.position =  ccp(18 ,355);
    winCountlabel.color = ccc3(31, 138, 232);
    winCountlabel.anchorPoint = ccp(0.0, 1.0);
    winCountlabel.dimensions = CGSizeMake(100, 0);
    [self addChild:winCountlabel z:1];
    
    
    CCSprite *winLabelImage = [CCSprite spriteWithFile:@"result_me_title_win.png"];
    winLabelImage.position = ccp(37, 356);
    [self addChild:winLabelImage];
    
    //    CCLabelTTF *winlabel = [CCLabelTTF labelWithString:@"Win" fontName:@"AmericanTypewriter-Bold" fontSize:24];
    //    winlabel.position =  ccp(100 ,300);
    //    winlabel.color = ccc3(0, 0, 0);
    //
    //    [self addChild:winlabel z:1];
    
    
    CCLabelTTF *loseCountlabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", loseCount] fontName:@"AmericanTypewriter-Bold" fontSize:60];
    loseCountlabel.position =  ccp(311 ,355);
    loseCountlabel.color = ccc3(252, 44, 37);
    loseCountlabel.anchorPoint = ccp(1.0, 1.0);
    loseCountlabel.dimensions = CGSizeMake(100, 0);
    [self addChild:loseCountlabel];
    
    //    CCLabelTTF *loselabel = [CCLabelTTF labelWithString:@"Lose" fontName:@"AmericanTypewriter-Bold" fontSize:24];
    //    loselabel.position =  ccp(250 ,300);
    //    loselabel.color = ccc3(0, 0, 0);
    //    [self addChild:loselabel z:1];
    
    CCSprite *loseLabelImage = [CCSprite spriteWithFile:@"result_me_title_lose.png"];
    loseLabelImage.position = ccp(289, 356);
    [self addChild:loseLabelImage];
    
    
    CCSprite *resultImage;
    if (gameResult == 1) {
        resultImage = [CCSprite spriteWithFile:@"result_me_bigtitle_win.png"];
    } else if(gameResult == 2) {
        resultImage = [CCSprite spriteWithFile:@"result_me_bigtitle_lose.png"];
    } else {
        // TODO draw
    }
    resultImage.position = ccp(160, 409);
    [self addChild:resultImage z:1];
    
    
    
    CCSprite *borderImage = [CCSprite spriteWithFile:@"result_border.png"];
    borderImage.position = ccp(160, 255);
    [self addChild:borderImage];
    

}

- (void) onEnter
{
    [super onEnter];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:ACTION_GAME_RESULT forKey:ACTION_TYPE];
    [userDefaults synchronize];
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite * backImage = [CCSprite spriteWithFile:@"common_bg.png"];
    backImage.position = CGPointMake(size.width/2, size.height/2);
    [self addChild:backImage z:0];
    
    if (isForceGameEnd) {
        apiConnection = [APIConnection sharedAPIConnection];
        apiConnection.delegate = self;
        [apiConnection setActionType:GET_RECORD];
        [apiConnection sendMessage:@"{\"record\":\"\"}"];
        isForceGameEnd = NO;

    } else {
        [self setGameResultImage];
    }
    
    CCMenuItemImage *item = [CCMenuItemImage itemWithNormalImage:@"signup_btn_ok.png" selectedImage:@"signup_btn_ok.png" block:^(id sender){
        [self performSelectorOnMainThread:@selector(moveMainPage) withObject:nil waitUntilDone:YES];
        
        
//        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainLayer scene] withColor:ccWHITE]];
        //                [someField setHidden:YES];
        
    }];
    
    CCMenu *menu = [CCMenu menuWithItems:item, nil];
    menu.position = CGPointMake(size.width/2, 227);
    
    // add the label as a child to this Layer
    //    [self addChild: label];
    [self addChild: menu z:2];
//    if (gameResult == 1) {
//        [ModalAlert Tell:@"相手が接続を終了しました。勝利です。" onLayer:self okBlock:^{
//        }];
//    } else if(gameResult == 2) {
//        [ModalAlert Tell:@"接続を終了した為、敗北です。" onLayer:self okBlock:^{
//        }];
//        
//    }

    
    
    // TODO Animation;

}

- (void) onExit
{
    [super onExit];
    [self removeAllChildrenWithCleanup:YES];
}

- (void) receivedMessageFromRecord:(NSDictionary *)messageDic
{
    if (messageDic) {
        if (gameResult == 1) {
           
                NSDictionary *recordDic = [messageDic valueForKey:@"record"];
                NSNumber *tempWinCount = [recordDic objectForKey:@"win"];
                NSNumber *tempLoseCount = [recordDic objectForKey:@"lose"];
                NSNumber *tempDrawCount = [recordDic objectForKey:@"draw"];
                [self setWinCount:[tempWinCount intValue]];
                [self setLoseCount:[tempLoseCount intValue]];
                [self setDrawCount:[tempDrawCount intValue]];
                [self setGameResultImage];

        } else if(gameResult == 2) {
            
                NSDictionary *recordDic = [messageDic valueForKey:@"record"];
                NSNumber *tempWinCount = [recordDic objectForKey:@"win"];
                NSNumber *tempLoseCount = [recordDic objectForKey:@"lose"];
                NSNumber *tempDrawCount = [recordDic objectForKey:@"draw"];
                [self setWinCount:[tempWinCount intValue]];
                [self setLoseCount:[tempLoseCount intValue]];
                [self setDrawCount:[tempDrawCount intValue]];
                [self setGameResultImage];

        }
         

    }

    
}

- (void) receivedErrorFromAction:(NSString *)message
{
    
}

- (void) receivedMessageFromLoginToServer:(NSDictionary *)messageDic
{
    BOOL result;
    if (messageDic != nil) {
        result = [messageDic valueForKey:@"login"];
        NSLog(@"receivedMessageFromLoginToServer result : %d", result);
    }
}

- (void) moveMainPage
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainLayer scene] withColor:ccWHITE]];
//    [[CCDirector sharedDirector] pushScene:[MainLayer scene]];

}

@end
