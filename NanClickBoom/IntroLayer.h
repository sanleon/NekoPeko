//
//  IntroLayer.h
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/02.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "APIConnection.h"

// HelloWorldLayer
@interface IntroLayer : CCLayer <APIConnectionDelegate>
{
    APIConnection *apiConnection;
    NSDictionary *receiveMessageDic;
    BOOL isLogined;
    BOOL isLogging;
}


@property(nonatomic, readwrite) BOOL isLogined;
@property(nonatomic, readwrite) BOOL isLogging;
// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;



@end
