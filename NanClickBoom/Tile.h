//
//  Tile.h
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/02.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define TILE_MSG_NOTIFY_TOUCH_END   @"TileMsgNotifyTouchEnd"

// タッチイベントメッセージ
#define TILE_MSG_NOTIFY_TAP				@"TileMsgNotifyTap"

#define GAME_RESTART                @"GameRestart"

#define GAME_END                    @"GameEnd"

#define GAME_ALL_END                @"GameAllEnd"

#define NUM_CLICK                   @"NumClick"

#define NUM_CLICK_SUCCESS           @"NumClickSuccess"

#define ANIMATION_START             @"AnimationStart"

@interface Tile : CCSprite <CCTargetedTouchDelegate> {
    CCLabelTTF *_numLabel;
//    CCSprite* animationImage1;
//    CCSprite* animationImage2;
//    CCSprite* animationImage3;
    CCAnimate * animate;
    CCAnimation *animation;
//    CCSprite* _imgBlinkFrame;
    


    int _num;
    
    int _now;
    int _answer;
    BOOL _isTouchBegin;
    
    CGPoint _touchLocation;
    
    
}


@property (nonatomic, readonly) BOOL IsTouchHold;
@property (nonatomic, readwrite) int Answer;
@property (nonatomic, readwrite) int Num;
@property (nonatomic, readwrite) int		Now;
@property (nonatomic, retain) CCAnimate *animate;
@property (nonatomic, retain) CCAnimation *animation;
@property (nonatomic, retain) CCLabelTTF *NumLabel;

- (void) createAnimation;
- (void) setClickNumLabel;

//- (void)addToLayer:(CCLayer *)layer;
//- (void)removeFromLayer:(CCLayer *)layer;

@end
