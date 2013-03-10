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
static int tileCount = 16;
static int gameCount = 3;
static float gameLimitedSecond = 30.0;

@interface GameLayer : CCLayer <APIConnectionDelegate> {
    //int _tileCount;
    int _currentNum;
    CCArray* _tileList;
    float _timer;
    int _currentGameCount;
    
    int tileHeight;
    
    int tileWidth;
    
    int tileBackgroundHeight;
    
    int tileBackgroundWidth;
    
    int clickedTileCount;
    
    float currentSecond;
    
    int _currentMyScore;
    
    int _currentEnemyScore;
    
    CCLabelTTF * _currentNumLabel;
    CCLabelTTF *_timerLabel;
    APIConnection *apiConnection;
    
}

@property(nonatomic, retain) CCLabelTTF *CurrentNumLabel;

@property(nonatomic, readwrite) int currentMyScore;

@property(nonatomic, readwrite) int currentEnemyScore;
//@property(nonatomic, readwrite) int CurrentNum;
+(CCScene *) scene;
@end
