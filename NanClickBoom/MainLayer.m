//
//  MainLayer.m
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/06.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "MainLayer.h"
#import "GameLayer.h"
#import "FindPlayerLayer.h"
#import "AccountManager.h"

@implementation MainLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainLayer *layer = [MainLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void) onEnter
{
    [super onEnter];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:ACTION_MAIN forKey:ACTION_TYPE];
    [userDefaults synchronize];
    
    NSNumber *tempWinCount = [userDefaults valueForKey:@"WinCount"];
    NSNumber *tempLoseCount =[userDefaults valueForKey:@"LoseCount"];
    NSNumber *tempDrawCount =[userDefaults valueForKey:@"DrawCount"];
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
//    if (screenBounds.size.height == 568) {
//        CCSprite * backImage = [CCSprite spriteWithFile:@"common_bg-568h@2x.png"];
//        backImage.position = CGPointMake(size.width/2, size.height/2);
//        [self addChild:backImage z:0];
//
//    } else {
        CCSprite * backImage = [CCSprite spriteWithFile:@"common_bg.png"];
        backImage.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:backImage z:0];
//    }
    CCSprite *characterImage =[CCSprite spriteWithFile:@"main_first_my_cha.png"];
    characterImage.position = ccp(39, 441);
    [self addChild:characterImage];
    
    NSMutableArray *accountArray = [AccountManager allAccount];
    NSString *loginId = nil;
    NSString *uuid = nil;
    for (NSDictionary *accountDic in accountArray) {
        loginId = [accountDic objectForKey:@"acct"];
        uuid = [AccountManager getUUIDByAccountId:[accountDic objectForKey:@"acct"]];
    }

    CCLabelTTF *characterLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@ちゃん", loginId]  fontName:@"AmericanTypewriter-Bold" fontSize:15];
    characterLabel.position = ccp(17.5, 420.0);
    characterLabel.color = ccc3(0,0,0);
    characterLabel.anchorPoint = ccp(0.0, 1.0);
    characterLabel.dimensions = CGSizeMake(96, 100);
    [self addChild:characterLabel];
    
    CCSprite *winLabelImage = [CCSprite spriteWithFile:@"result_me_title_win.png"];
    winLabelImage.position = ccp(293, 459);
    [self addChild:winLabelImage];
    
    CCLabelTTF *winCountlabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", tempWinCount.intValue] fontName:@"AmericanTypewriter-Bold" fontSize:60];
    winCountlabel.position =  ccp(317 ,450);
    winCountlabel.color = ccc3(31, 138, 232);
    winCountlabel.anchorPoint = ccp(1.0, 1.0);
    winCountlabel.dimensions = CGSizeMake(100, 0);
    [self addChild:winCountlabel z:1];
    
    
    CCSprite *loseLabelImage = [CCSprite spriteWithFile:@"result_me_title_lose.png"];
    loseLabelImage.position = ccp(290, 377);
    [self addChild:loseLabelImage];
    
    CCLabelTTF *loseCountlabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", tempLoseCount.intValue] fontName:@"AmericanTypewriter-Bold" fontSize:60];
    loseCountlabel.position =  ccp(317 ,370);
    loseCountlabel.color = ccc3(252, 44, 37);
    loseCountlabel.anchorPoint = ccp(1.0, 1.0);
    loseCountlabel.dimensions = CGSizeMake(100, 0);
    [self addChild:loseCountlabel];
    
    
    CCSprite *drawLabelImage = [CCSprite spriteWithFile:@"result_me_draw.png"];
    drawLabelImage.position = ccp(286, 290);
    [self addChild:drawLabelImage];
    
    CCLabelTTF *drawCountlabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", tempDrawCount.intValue] fontName:@"AmericanTypewriter-Bold" fontSize:60];
    drawCountlabel.position =  ccp(317 ,280);
    drawCountlabel.color = ccc3(99, 66, 161);
    drawCountlabel.anchorPoint = ccp(1.0, 1.0);
    drawCountlabel.dimensions = CGSizeMake(100, 0);
    [self addChild:drawCountlabel];
    
    
    CCSprite * startDevideBar = [CCSprite spriteWithFile:@"signup_devide_bar.png"];
    startDevideBar.position = CGPointMake(size.width/2, 200);
    [self addChild:startDevideBar z:2];
    
    //    CCLabelTTF *loselabel = [CCLabelTTF labelWithString:@"Lose" fontName:@"AmericanTypewriter-Bold" fontSize:24];
    //    loselabel.position =  ccp(250 ,300);
    //    loselabel.color = ccc3(0, 0, 0);
    //    [self addChild:loselabel z:1];
    

    
    
//    [CCMenuItemFont setFontName:@"Helvetica-BoldOblique"];
//    [CCMenuItemFont setFontSize:26];
//    CCMenuItemFont *onePlayerItem = [CCMenuItemFont itemWithString:@"Single" block:^(id sender){
//        
//        // GameLayerを表示します
//        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameLayer scene] withColor:ccWHITE]];
//    }];
//    onePlayerItem.color = ccc3(255, 255, 255);

    
//    CCMenuItemFont *multiPlayerItem = [CCMenuItemFont itemWithString:@"Multi" block:^(id sender){
//        
//        // GameLayerを表示します
//        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[FindPlayerLayer scene] withColor:ccWHITE]];
//    }];
//    multiPlayerItem.color = ccc3(255, 255, 255);
    
    CCMenuItemImage *multiPlayItem = [CCMenuItemImage itemWithNormalImage:@"result_bt_finduser.png" selectedImage:@"result_bt_finduser.png" block:^(id sender){
        
        // GameLayerを表示します
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[FindPlayerLayer scene] withColor:ccWHITE]];
    }];
    CCMenu *menu = [CCMenu menuWithItems:multiPlayItem,nil];
    [menu alignItemsVerticallyWithPadding:20];
    menu.position = CGPointMake(size.width/2, 174);
    [self addChild: menu z:5];
    
    
    
    CCSprite *bottomImage =[CCSprite spriteWithFile:@"main_first_my_bottom_cha.png"];
    bottomImage.position = ccp(160, 80);
    [self addChild:bottomImage z:4];
    
}

- (void) onExit
{
    [super onExit];
}

@end
