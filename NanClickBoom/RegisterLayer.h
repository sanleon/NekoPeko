//
//  RegisterLayer.h
//  NanClickBoom
//
//  Created by A12889 on 13/03/11.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "APIConnection.h"

@interface RegisterLayer : CCLayer <UITextFieldDelegate, APIConnectionDelegate> {
    UITextField * someField;
        APIConnection *apiConnection;
        NSDictionary *receiveMessageDic;
}

+(CCScene *) scene;

@end
