//
//  FindPlayerLayer.m
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/07.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "FindPlayerLayer.h"
#import "GameLayer.h"
#import "ModalAlert.h"
#import "MainLayer.h"
#import "AccountManager.h"


@implementation FindPlayerLayer

- (id) init
{
    if (self = [super init] ) {
        apiConnection = nil;
        currentWaitTime = waitTimeForFindPlayer;
        
    }
    return self;
}

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	FindPlayerLayer *layer = [FindPlayerLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void)setFindPlayerImages:(NSInteger)plusSize
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"相手を探しています" fontName:@"Marker Felt" fontSize:24];
    label.position =  ccp(size.width/2 ,380+plusSize);
    label.color = ccc3(0, 0, 0);
    [self addChild:label];
    
    CCSprite* animationimage = [CCSprite spriteWithFile:@"00.png"];
    
    //        // 画像の配置場所の設定
    animationimage.position = CGPointMake(size.width/2, size.height / 2);
    [self addChild:animationimage z:4];
    CCAnimation* animation = [CCAnimation animation];
    [animation addSpriteFrameWithFilename:@"01.png"];
    [animation addSpriteFrameWithFilename:@"02.png"];
    [animation addSpriteFrameWithFilename:@"03.png"];
    [animation addSpriteFrameWithFilename:@"04.png"];
    [animation addSpriteFrameWithFilename:@"05.png"];
    
    //        CCSprite *frameImage1 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage key:nil];
    //        CCSprite *frameImage2 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_02.png"].CGImage key:nil];
    //        CCSprite *frameImage3 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_03.png"].CGImage key:nil];
    //
    //        CCSpriteFrame* frame1 = [CCSpriteFrame frameWithTexture:frameImage1.texture rect:CGRectMake(0,0,self.contentSize.width,self.contentSize.height)];
    //        CCSpriteFrame* frame2 = [CCSpriteFrame frameWithTexture:frameImage2.texture rect:CGRectMake(0,0,self.contentSize.width,self.contentSize.height)];
    //        CCSpriteFrame* frame3 = [CCSpriteFrame frameWithTexture:frameImage3.texture rect:CGRectMake(0,0,self.contentSize.width,self.contentSize.height)];
    //
    //        [animation addSpriteFrame:frame1];
    //
    //        [animation addSpriteFrame:frame2];
    //
    //        [animation addSpriteFrame:frame3];
    
    animation.delayPerUnit = 0.2;
    
    animation.loops = -1;
    
    CCAnimate * animate = [CCAnimate actionWithAnimation:animation];
    
    [animationimage runAction:animate];
}

- (void) onEnter
{
    [super onEnter];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:ACTION_FIND_PLAYER forKey:ACTION_TYPE];


//    [userDefaults setInteger:0 forKey:@"ClickedTileCount"];
    [userDefaults setInteger:0 forKey:@"CurrentGameCount"];
    [userDefaults synchronize];
    
    isFindEnmey = NO;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) {
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite * backImage = [CCSprite spriteWithFile:@"common_bg-568h@2x.png"];
        backImage.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:backImage z:0];
        [self setFindPlayerImages:88];
        
    } else {
        CGSize wsize = [[CCDirector sharedDirector] winSize];
        CCSprite * backImage = [CCSprite spriteWithFile:@"common_bg.png"];
        backImage.position = CGPointMake(wsize.width/2, wsize.height/2);
        [self addChild:backImage z:0];
        
        [self setFindPlayerImages:0];
    }

    
    // Start Animation
}



- (void) onEnterTransitionDidFinish
{

        apiConnection = [APIConnection sharedAPIConnection];
        apiConnection.delegate = self;
        [apiConnection setActionType:APPLY_GAME];
        [apiConnection sendMessage:@"{\"ready\":\"\"}"];
        [self schedule:@selector(updateWaitTimer) interval:1];

}


- (void) receivedErrorFromAction:(NSString *)message
{
    if ([message isEqualToString:ERROR_ALREADY_FIGHTING]) {
        // TODO すでに敵
    } else if([message isEqualToString:ERROR_NO_LOGIN]) {
        // TODO ログインされてない状態
        [self sendReLogin];
    }
    
}

- (void)sendReLogin
{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    
//    NSString *loginedUserId = [userDefaults objectForKey:@"NumClickUserID"];
//    NSString *loginedUUID =     [userDefaults objectForKey:@"NumClickUUID"];
    NSMutableArray *accountArray = [AccountManager allAccount];
    NSString *loginId = nil;
    NSString *uuid = nil;
    for (NSDictionary *accountDic in accountArray) {
        loginId = [accountDic objectForKey:@"acct"];
        uuid = [AccountManager getUUIDByAccountId:[accountDic objectForKey:@"acct"]];
    }
    
    
    [apiConnection setActionType:RELOGIN_TO_SERVER];
    // TODO 保存！
    [apiConnection sendMessage:[NSString stringWithFormat:@"{\"login\":{\"id\":\"%@\", \"uid\":\"%@\"}}", loginId,uuid]];
    
}

- (void) receivedMessageFromApplyGame:(NSDictionary *)messageDic
{
    BOOL result = NO;
    if (messageDic != nil) {
        result = [messageDic valueForKey:@"ready"];
        NSLog(@"result : %d", result);
    }
    
    if (result) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        // TODO
       // My ID
        NSString * myId = [userDefaults objectForKey:@"NumClickUserID"];
        // 敵のID
        NSDictionary* enemy = [messageDic valueForKey:@"enemy"];
        // TODO Stop Animation
        if (enemy != nil) {
            isFindEnmey = YES;
            // GameLayerを表示します
            NSString *enemyId = [enemy valueForKey:@"name"];
            [userDefaults setObject:enemyId forKey:@"NumClickEnemyID"];
            GameLayer* gameLayerD = [GameLayer node];
            CCScene *scene = [CCScene node];
            [scene addChild:gameLayerD];
            [gameLayerD setEnemyUserId:enemyId];
            [gameLayerD setMyUserId:myId];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:scene withColor:ccWHITE]];
        }
//        if (!isFindEnmey) {
//            apiConnection = [APIConnection sharedAPIConnection];
//            apiConnection.delegate = self;
//            [apiConnection setActionType:APPLY_GAME];
//            [apiConnection sendMessage:@"{\"ready\":\"\"}"];
//
//        }
  }
//    [apiConnection closeToServer];
}

- (void)updateWaitTimer{
    currentWaitTime -= 1;
    
    if (0 == currentWaitTime) {
        
        // タイマーを止める
        [self unschedule:@selector(updateWaitTimer)];
        
        [ModalAlert Tell:@"相手を探せませんでした。メイン画面に戻ります。" onLayer:self okBlock:^{
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainLayer scene] withColor:ccWHITE]];
        }];
        // gameOverの呼び出し
        return;
    }
}

@end
