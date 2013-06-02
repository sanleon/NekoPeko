//
//  GameResultAnimation.m
//  NekoPeko
//
//  Created by Jo Sungbum on 13/06/02.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameResultAnimation.h"


@implementation GameResultAnimation

@synthesize grAnimate, grAnimation;


- (void) onEnter
{
    [super onEnter];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotifyFromNotificationCenter2:) name:@"GameResultStartAnimation" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotifyFromNotificationCenter2:) name:@"GameResultEndAnimation" object:nil];
}

- (void) onExit
{
    // スーパークラスのonExitをコールします
	[super onExit];
    
	
	// 通知センタのオブザーバ登録を解除します
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) NotifyFromNotificationCenter2:(NSNotification*)notification
{
    if ([notification.name isEqualToString:@"GameResultStartAnimation"]) {
        [self runAction:grAnimate];
    } else if ([notification.name isEqualToString:@"GameResultEndAnimation"]) {
        [self stopAction:grAnimate];
    }
}

@end
