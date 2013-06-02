//
//  ScoreAddUpLayer.h
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/10.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "APIConnection.h"
#import "AttackAnimation.h"

#define GAME_DISPLAY_ACTION_IN_DURATION 1
#define ACTION_IN_DURATION 10


@interface ScoreAddUpLayer : CCLayer  <APIConnectionDelegate> {
    
    int myScore;
    int enemyScore;
    int baseMyScore;
    int baseEnemyScore;
    
    
    int point;
    int enemyPoint;

    float currnetMyHp;
    float currentEnemyHp;
    float remainMyHp;
    float remainEnemyHp;
    NSString *myUserId;
    NSString *enemyUserId;
    CCLabelTTF *myScoreLabel;
    CCLabelTTF *enemyScoreLabel;
    BOOL isMyScoreAniEnd;
    BOOL isEnemyScoreAniEnd;
    BOOL isGameEnd;
    
    int winCount;
    int loseCount;
    int drawCount;
    int gameResult;
    
    int count;
    int combo;
    int enemyCombo;
    int enemyCount;
    
    AttackAnimation *attackAnimation;
    
    APIConnection *apiConnection;

}

@property(nonatomic, readwrite) int myScore;
@property(nonatomic, readwrite) int enemyScore;
@property(nonatomic, readwrite) int baseMyScore;
@property(nonatomic, readwrite) int baseEnemyScore;
@property(nonatomic, readwrite) int point;
@property(nonatomic, readwrite) int enemyPoint;
@property(nonatomic, readwrite) float baseMyHp;
@property(nonatomic, readwrite) float baseEnemyHp;
@property(nonatomic, readwrite) float currnetMyHp;
@property(nonatomic, readwrite) float currentEnemyHp;
@property(nonatomic, readwrite) float remainMyHp;
@property(nonatomic, readwrite) float remainEnemyHp;
@property(nonatomic, retain) NSString *myUserId;
@property(nonatomic, retain) NSString *enemyUserId;
@property(nonatomic, readwrite) BOOL isGameEnd;
@property(nonatomic, readwrite) int winCount;
@property(nonatomic, readwrite) int loseCount;
@property(nonatomic, readwrite) int drawCount;
@property(nonatomic, readwrite) int count;
@property(nonatomic, readwrite) int combo;
@property(nonatomic, readwrite) int enemyCombo;
@property(nonatomic, readwrite) int enemyCount;
@property(nonatomic, readwrite) BOOL isEnemyDissconnected;


/*
 0 : draw
 1 : win
 2 : lose
 */
@property(nonatomic, readwrite) int gameResult;

+(CCScene *) scene;

@end
