//
//  FindPlayerLayer.h
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/07.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//




#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "APIConnection.h"

#define waitTimeForFindPlayer 10

@interface FindPlayerLayer : CCLayer <APIConnectionDelegate> {
     APIConnection *apiConnection;
    BOOL isFindEnmey;
    float currentWaitTime;
}

+(CCScene *) scene;

@end
