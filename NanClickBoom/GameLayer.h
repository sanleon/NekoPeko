//
//  GameLayer.h
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/02.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Tile.h"
#import "AnimationTile.h"
#import "APIConnection.h"
#import "ScoreAddUpLayer.h"
#define tileCount 16

#define gamePalyCount 9999
#define gameLimitedSecond 20.0
#define waitTimeForGameStart 3
#define waitTimeForGamePlayReStart 2
#define attackBaseScore 10


@interface GameLayer : CCLayer <APIConnectionDelegate> {
    //int _tileCount;
    int _currentNum;
    CCArray* _tileList;
    float _timer;
    float gameRestartWaitTime;
    int _currentGamePlayCount;
    int _currentGameCount;
    
    int tileHeight;
    
    int tileWidth;
    
    int tileBackgroundHeight;
    
    int tileBackgroundWidth;
    
    int clickedTileCount;
    
    float currentSecond;
    
    float _currentMyHp;
    
    float _currentEnemyHp;
    
    float currentTimeForGameStart;
    
    
    NSString * myUserId;
    NSString * enemyUserId;
    
    CCLabelTTF * _currentNumLabel;
    CCLabelTTF *gameEndLabel;
    CCLabelTTF *scoreAddUpLabel;
    CCLabelTTF *_timerLabel;
    CCLabelTTF *waitTimeLabel;
    CCLabelTTF *currentRoundLabel;
    CCLabelTTF *attackPointLabel;
    APIConnection *apiConnection;
    
    ScoreAddUpLayer* scoreLayer;
    
}

@property(nonatomic, retain) CCLabelTTF *CurrentNumLabel;

@property(nonatomic, retain) CCLabelTTF *attackPointLabel;

@property(nonatomic, readwrite) float currentMyHp;

@property(nonatomic, readwrite) float currentEnemyHp;

@property(nonatomic, retain) NSString* myUserId;

@property(nonatomic, retain) NSString* enemyUserId;


//@property(nonatomic, readwrite) int CurrentNum;
+(CCScene *) scene;
@end
