//
//  FindPlayerLayer.m
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/07.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "FindPlayerLayer.h"
#import "GameLayer.h"


@implementation FindPlayerLayer

- (id) init
{
    if (self = [super init] ) {
        apiConnection = nil;
        
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

- (void) onEnter
{
    [super onEnter];
    isFindEnmey = NO;
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"相手を探しています" fontName:@"Marker Felt" fontSize:24];
    label.position =  ccp(size.width/2 ,380);
    [self addChild:label];
    

    
    // Start Animation
}

- (void) onEnterTransitionDidFinish
{

        apiConnection = [APIConnection sharedAPIConnection];
        apiConnection.delegate = self;
        [apiConnection setActionType:APPLY_GAME];
        [apiConnection sendMessage:@"{\"ready\":\"\"}"];

}


- (void) receivedErrorFromAction:(NSString *)message
{
    if ([message isEqualToString:ERROR_ALREADY_FIGHTING]) {
        // TODO すでに敵
    } else if([message isEqualToString:ERROR_NO_LOGIN]) {
        // TODO ログインされてない状態
    }
    
}

- (void) receivedMessageFromApplyGame:(NSDictionary *)messageDic
{
    BOOL result = NO;
    if (messageDic != nil) {
        result = [messageDic valueForKey:@"ready"];
        NSLog(@"result : %d", result);
    }
    
    if (result) {
        
        // 敵のID
        NSString* enemyId = [messageDic valueForKey:@"enemy"];
        // TODO Stop Animation
        if (enemyId != nil) {
            isFindEnmey = YES;
            // GameLayerを表示します
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameLayer scene] withColor:ccWHITE]];
        }
        if (!isFindEnmey) {
            apiConnection = [APIConnection sharedAPIConnection];
            apiConnection.delegate = self;
            [apiConnection setActionType:APPLY_GAME];
            [apiConnection sendMessage:@"{\"ready\":\"\"}"];

        }
  }
//    [apiConnection closeToServer];
}

@end
