//
//  AttackAnimation.h
//  NekoPeko
//
//  Created by A12889 on 13/03/19.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface AttackAnimation : CCSprite {
    
    CCAnimation *attackAnimation;
    CCAnimate *attackAnimate;
}

@property(nonatomic, retain) CCAnimation * attackAnimation;
@property(nonatomic, retain) CCAnimate * attackAnimate;


@end
