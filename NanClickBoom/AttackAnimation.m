//
//  AttackAnimation.m
//  NekoPeko
//
//  Created by A12889 on 13/03/19.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "AttackAnimation.h"


@implementation AttackAnimation
@synthesize attackAnimate, attackAnimation;


- (void) onEnter
{
    [super onEnter];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotifyFromNotificationCenter2:) name:@"AttackStartAnimation" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotifyFromNotificationCenter2:) name:@"AttackEndAnimation" object:nil];
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
    if ([notification.name isEqualToString:@"AttackStartAnimation"]) {
        [self runAction:attackAnimate];
    } else if ([notification.name isEqualToString:@"AttackEndAnimation"]) {
        [self stopAction:attackAnimate];
    }
}
@end
