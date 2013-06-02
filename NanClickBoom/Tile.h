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

#define GAME_PLAY_END                @"GAME_PLAY_END"

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
    
    CCAnimation* normalFishAnimation;
    
    CCAnimate* normalFishAnimate;
    
    CCSprite *boneFishImage;
    
    CCAnimation* boneFishAnimation;
    CCAnimate* bonFishAnimate;
    
//    CCSprite* _imgBlinkFrame;
    


    int _num;
    
    int _now;
    int _answer;
    BOOL _isTouchBegin;
    
    BOOL isBone;
    
    CGPoint _touchLocation;
    float origPositionX;
    float origPositionY;
    NSMutableArray *actionList;
    
    
}

@property (nonatomic, retain) NSMutableArray *actionList;
@property (nonatomic, readonly) BOOL IsTouchHold;
@property (nonatomic, readwrite) int Answer;
@property (nonatomic, readwrite) int Num;
@property (nonatomic, readwrite) int Now;
@property (nonatomic, readwrite) float	origPositionX;
@property (nonatomic, readwrite) float	origPositionY;
@property (nonatomic, readwrite) BOOL isBone;
@property (nonatomic, retain) CCAnimate *animate;
@property (nonatomic, retain) CCAnimation *animation;
@property (nonatomic, retain) CCAnimate *normalFishAnimate;
@property (nonatomic, retain) CCAnimation *normalFishAnimation;
@property (nonatomic, retain) CCAnimate *bonFishAnimate;
@property (nonatomic, retain) CCAnimation *boneFishAnimation;
@property (nonatomic, retain) CCLabelTTF *NumLabel;
@property (nonatomic, retain) CCSprite *boneFishImage;

- (void) createAnimation;
- (void) setClickNumLabel;
- (void) setTileAction;
- (void) shuffleAction;
- (void) addOriginMoveAction;
- (void) addSchedule;

//- (void)addToLayer:(CCLayer *)layer;
//- (void)removeFromLayer:(CCLayer *)layer;

@end
