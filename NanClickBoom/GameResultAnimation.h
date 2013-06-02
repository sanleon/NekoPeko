//
//  GameResultAnimation.h
//  NekoPeko
//
//  Created by Jo Sungbum on 13/06/02.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameResultAnimation : CCSprite {
    CCAnimation *grAnimation;
    CCAnimate *grAnimate;
}

@property(nonatomic, retain) CCAnimation * grAnimation;
@property(nonatomic, retain) CCAnimate * grAnimate;


@end
