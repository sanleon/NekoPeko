//
//  IntroLayer.m
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/02.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "LoginLayer.h"
#import "RegisterLayer.h"
#import "MainLayer.h"
#import "AccountManager.h"

#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

@synthesize isLogging, isLogined;

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id) init
{
    if (self = [super init] ) {
        receiveMessageDic = nil;
        apiConnection = nil;
        isLogging = NO;
        isLogined = NO;
        
    }
    return self;
}

// 
-(void) onEnter
{
	[super onEnter];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:ACTION_INTRO forKey:ACTION_TYPE];
    [userDefaults synchronize];
    
    apiConnection = [APIConnection sharedAPIConnection];
    apiConnection.delegate = self;
	// ask director for the window size
	CGSize size = [[CCDirector sharedDirector] winSize];
	CCSprite *background;

    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) {
        background = [CCSprite spriteWithFile:@"Default-568h@2x.png"];
        background.rotation = 360;

    } else {
        background = [CCSprite spriteWithFile:@"Default.png"];
        background.rotation = 360;
    }
//	if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
//		background = [CCSprite spriteWithFile:@"Default.png"];
//		background.rotation = 360;
//	} else {
//		background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
//	}
	background.position = ccp(size.width/2, size.height/2);

	// add the label as a child to this Layer
	[self addChild: background];
	
	// In one second transition to the new scene
	[self scheduleOnce:@selector(makeTransition:) delay:1];
}

- (void) onExit
{
    [super onExit];
    isLogined = NO;
    isLogging = NO;
}

-(void) makeTransition:(ccTime)dt
{   
    NSLog(@"IntroLayer MakeTransaction");
//    if ([apiConnection isConnecting]) {
    if (apiConnection == nil) {
        apiConnection = [APIConnection sharedAPIConnection];

    }
        if (![apiConnection isConnected]) {
            apiConnection.delegate = self;
            [apiConnection setActionType:CONNECT_TO_SERVER];
            [apiConnection connecToServer];
            
//        }
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        // TODO
//        NSString *loginId = [userDefaults objectForKey:@"NumClickUserID"];
//        NSString *uuid = [userDefaults objectForKey:@"NumClickUUID"];
//        
//        if (loginId != nil && uuid != nil && isLogined == NO) {
//            
//            [apiConnection setActionType:LOGIN_TO_SERVER];
//            // TODO 保存！
//            [apiConnection sendMessage:[NSString stringWithFormat:@"{\"login\":{\"id\":\"%@\", \"uid\":\"%@\"}}", loginId, uuid]];
//        }
//        else {
//
//            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[RegisterLayer scene] withColor:ccWHITE]];
//        }
        }
}


- (void) receivedErrorFromAction:(NSString *)message
{
    if ([message isEqualToString:ERROR_ALREADY_LOGIN]) {
        // TODO すでに敵
        NSLog(@"Already Login");
        isLogined = YES;
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainLayer scene] withColor:ccWHITE]];
        
    } else if([message isEqualToString:ERROR_USED_ID]) {
        // TODO ログインされてない状態
        NSLog(@"Already Used ID");
    } else {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        // TODO
        [userDefaults setObject:nil forKey:@"NumClickUserID"];
        [userDefaults setObject:nil forKey:@"NumClickUUID"];
        [userDefaults synchronize];
        [AccountManager deleteAllAccount];
        NSLog(@"Error Message : %@", message);
        // TODO
        // GameLayerを表示します
           [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[RegisterLayer scene] withColor:ccWHITE]]; 
    }
    
//    [someField setHidden:NO];


}

- (void) receivedMessageFromLoginToServer:(NSDictionary *)messageDic
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    receiveMessageDic = messageDic;
    BOOL result = NO;
    BOOL openResult = NO;
    if (receiveMessageDic != nil) {
        
        NSNumber *loginResult = [receiveMessageDic valueForKey:@"login"];
        if ([loginResult intValue] == 1) {
            result = YES;
            [apiConnection setIsLogined:YES];
        } else {
            result = NO;
            
            [apiConnection setIsLogined:NO];
        }
        
        
        [userDefaults setObject:nil forKey:@"CurrentGameCount"];
        NSLog(@"Login result : %d", result);
    }
    
    if (result) {
        NSDictionary *recordDic = [receiveMessageDic valueForKey:@"record"];
        NSNumber *winCount = [recordDic valueForKey:@"win"];
        NSNumber *loseCount = [recordDic valueForKey:@"lose"];
        NSNumber *drawCount = [recordDic valueForKey:@"draw"];
        [userDefaults setObject:winCount forKey:@"WinCount"];
        [userDefaults setObject:loseCount forKey:@"LoseCount"];
        [userDefaults setObject:drawCount forKey:@"DrawCount"];
        [userDefaults synchronize];
        isLogined = YES;
        // GameLayerを表示します
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainLayer scene] withColor:ccWHITE]];
    } else {
        [self sendReLogin];
    }
//    else {
//        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[RegisterLayer scene] withColor:ccWHITE]];
//    }

    
}

- (void) receivedMessageFromConnectToServer:(NSDictionary*) messageDic
{
    if (messageDic != nil) {
        //NSLog(@"IntroLayer ReceivedMessageFromConnectToServer %@", messageDic);
        NSNumber *openResult = [messageDic objectForKey:@"open"] ;
        if ([openResult intValue] == 1) {
            [apiConnection setIsConnected:YES];
        }
        NSMutableArray *accountArray = [AccountManager allAccount];
        NSString *loginId = nil;
        NSString *uuid = nil;
        for (NSDictionary *accountDic in accountArray) {
            loginId = [accountDic objectForKey:@"acct"];
            uuid = [AccountManager getUUIDByAccountId:[accountDic objectForKey:@"acct"]];
        }
        
        if (loginId != nil && uuid != nil) {
            [self sendReLogin];
        } else {
            
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[RegisterLayer scene] withColor:ccWHITE]];
        }
        
    }


}


- (void)sendReLogin
{
    NSMutableArray *accountArray = [AccountManager allAccount];
    NSString *loginId = nil;
    NSString *uuid = nil;
    for (NSDictionary *accountDic in accountArray) {
        loginId = [accountDic objectForKey:@"acct"];
        uuid = [AccountManager getUUIDByAccountId:[accountDic objectForKey:@"acct"]];
    }
    
    
    [apiConnection setActionType:LOGIN_TO_SERVER];
    // TODO 保存！
    [apiConnection sendMessage:[NSString stringWithFormat:@"{\"login\":{\"id\":\"%@\", \"uid\":\"%@\"}}", loginId,uuid]];
    
    
}

- (void) receivedMessageFromApplyGame:(NSDictionary *)messageDic
{
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainLayer scene] withColor:ccWHITE]];
}

- (void) sendMessageByAPI
{

 

}


@end
