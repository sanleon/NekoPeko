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
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    [CCMenuItemFont setFontName:@"Helvetica-BoldOblique"];
    [CCMenuItemFont setFontSize:26];
    CCMenuItemFont *onePlayerItem = [CCMenuItemFont itemWithString:@"Single" block:^(id sender){
        
        // GameLayerを表示します
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameLayer scene] withColor:ccWHITE]];
    }];
    
    CCMenuItemFont *multiPlayerItem = [CCMenuItemFont itemWithString:@"Multi" block:^(id sender){
        
        // GameLayerを表示します
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[FindPlayerLayer scene] withColor:ccWHITE]];
    }];
    
    CCMenu *menu = [CCMenu menuWithItems:onePlayerItem, multiPlayerItem,nil];
    [menu alignItemsVerticallyWithPadding:20];
    menu.position = CGPointMake(size.width/2, 100);
    [self addChild: menu];
    
}

- (void) onExit
{
    [super onExit];
}

@end
