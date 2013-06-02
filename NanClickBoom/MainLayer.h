//
//  MainLayer.h
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/06.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MainLayer : CCLayer {
    int winCount;
    int loseCount;
    int drawCount;
    int point;
}

@property(nonatomic, readwrite) int winCount;
@property(nonatomic, readwrite) int loseCount;
@property(nonatomic, readwrite) int drawCount;
@property(nonatomic, readwrite) int point;

+(CCScene *) scene;

@end
