//
//  AppDelegate.h
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/02.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "APIConnection.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate, APIConnectionDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
        APIConnection *apiConnection;
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
