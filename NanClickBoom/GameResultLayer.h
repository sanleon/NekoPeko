//
//  GameResultLayer.h
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/16.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "APIConnection.h"

@interface GameResultLayer : CCLayer <APIConnectionDelegate>{
    int winCount;
    int loseCount;
    int drawCount;
    int gameResult;
    BOOL isForceGameEnd;
    APIConnection *apiConnection;
}

@property(nonatomic, readwrite) int winCount;
@property(nonatomic, readwrite) int loseCount;
@property(nonatomic, readwrite) int drawCount;
@property(nonatomic, readwrite) BOOL isForceGameEnd;
/*
 0 : draw
 1 : win
 2 : lose
 */
@property(nonatomic, readwrite) int gameResult;
+(CCScene *) scene;
@end
