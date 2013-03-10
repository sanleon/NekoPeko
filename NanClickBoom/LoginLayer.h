//
//  LoginLayer.h
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/02.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "APIConnection.h"


@interface LoginLayer : CCLayer<UITextFieldDelegate, APIConnectionDelegate>
{
    UITextField * someField;
    NSDictionary *receiveMessageDic;
    APIConnection *apiConnection;

}

+(CCScene *) scene;

-(void) sendMessageByAPI;

@end
