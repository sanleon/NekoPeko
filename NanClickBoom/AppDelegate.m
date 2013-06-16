//
//  AppDelegate.m
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/02.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "IntroLayer.h"
#import "MainLayer.h"
#import "GameResultLayer.h"
#import "ScoreAddUpLayer.h"
#import "RegisterLayer.h"
#import "AccountManager.h"

@implementation AppController

BOOL isConnecting;

@synthesize window=window_, navController=navController_, director=director_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [AccountManager deleteAllAccount];
            NSLog(@"%@",@"didFinishLaunchingWithOptions");
    apiConnection = [APIConnection sharedAPIConnection];
    [apiConnection setActionType:CONNECT_TO_SERVER];
    isConnecting = YES;
    [apiConnection connecToServer];
    
	// Create the main window
	window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];


	// Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
	CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
								   pixelFormat:kEAGLColorFormatRGB565	//kEAGLColorFormatRGBA8
								   depthFormat:0	//GL_DEPTH_COMPONENT24_OES
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];

	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];

	director_.wantsFullScreenLayout = YES;

	// Display FSP and SPF
	[director_ setDisplayStats:NO];

	// set FPS at 60
	[director_ setAnimationInterval:1.0/60];

	// attach the openglView to the director
	[director_ setView:glView];

	// for rotation and other messages
	[director_ setDelegate:self];

	// 2D projection
	[director_ setProjection:kCCDirectorProjection2D];
//	[director setProjection:kCCDirectorProjection3D];

	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director_ enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");

	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

	// If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
	// On iPad HD  : "-ipadhd", "-ipad",  "-hd"
	// On iPad     : "-ipad", "-hd"
	// On iPhone HD: "-hd"
	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"

	// Assume that PVR images have premultiplied alpha
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];

//	// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
	[director_ pushScene: [IntroLayer scene]]; 

	
	// Create a Navigation Controller with the Director
	navController_ = [[UINavigationController alloc] initWithRootViewController:director_];
	navController_.navigationBarHidden = YES;
	
	// set the Navigation Controller as the root view controller
//	[window_ addSubview:navController_.view];	// Generates flicker.
	[window_ setRootViewController:navController_];
	
	// make main window visible
	[window_ makeKeyAndVisible];

	
	return YES;
}

// Supported orientations: Landscape. Customize it for your own needs
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}


// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
        NSLog(@"%@",@"applicationWillResignActive");
	if( [navController_ visibleViewController] == director_ )
		[director_ pause];
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"%@",@"applicationDidBecomeActive");
    if( [navController_ visibleViewController] == director_ ) {
        NSLog(@"%@",@"resume");

        [director_ resume];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString* actionType = [userDefaults objectForKey:ACTION_TYPE];
        
        if ([actionType isEqualToString:ACTION_BACKGROUND]) {
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[IntroLayer scene] withColor:ccWHITE]];
        }
    }
//    if (!isConnecting) {
//        apiConnection = [APIConnection sharedAPIConnection];
//        [apiConnection setActionType:CONNECT_TO_SERVER];
//        [apiConnection connecToServer];
////        [self sendReLogin];
//
//        
////        [director_ pushScene: [IntroLayer scene]];
//        
//
//    }
//    isConnecting = NO;
//
}

-(void) applicationDidEnterBackground:(UIApplication*)application
{
    NSLog(@"%@",@"applicationDidEnterBackground");
//    [apiConnection closeToServer];
//    IntroLayer *introLayer = [IntroLayer node];
//    [introLayer setIsLogined:NO];
    [apiConnection setIsLogined:NO];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:ACTION_BACKGROUND forKey:ACTION_TYPE];
    [apiConnection closeToServer];
    [apiConnection setIsConnected:NO];
	if( [navController_ visibleViewController] == director_ )
		[director_ stopAnimation];
    
//    [self applicationWillTerminate:application];
}

-(void) applicationWillEnterForeground:(UIApplication*)application
{

    NSLog(@"%@",@"applicationWillEnterForeground");
	if( [navController_ visibleViewController] == director_ )
		[director_ startAnimation];
    
//    [director_ pushScene: [IntroLayer scene]];
}

// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application
{
//    IntroLayer *introLayer = [IntroLayer node];
//    [introLayer setIsLogined:NO];
//    apiConnection = [APIConnection sharedAPIConnection];
//    [apiConnection closeToServer];
    
	CC_DIRECTOR_END();
}

// purge memory
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[CCDirector sharedDirector] purgeCachedData];
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void) receivedErrorFromAction:(NSString *)message
{

        NSLog(@"Error Message : %@", message);
//    apiConnection = [APIConnection sharedAPIConnection];
//    [apiConnection setActionType:CONNECT_TO_SERVER];
//    [apiConnection connecToServer];
        // TODO
        // GameLayerを表示します
        
    
}

- (void) receivedMessageFromLoginToServer:(NSDictionary *)messageDic
{

    BOOL result = NO;
    if (messageDic != nil) {
        result = [messageDic valueForKey:@"login"];
        NSLog(@"result : %d", result);
    }
    
    if (result) {


        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *actionType = [userDefaults valueForKey:ACTION_TYPE];
        if ([actionType isEqualToString:ACTION_MAIN]) {
            if( [navController_ visibleViewController] == director_ )
                [director_ resume];
        } else if ([actionType isEqualToString:ACTION_GAME] || [actionType isEqualToString:ACTION_SCORE_ADD_UP]) {
            if( [navController_ visibleViewController] == director_ )
                [director_ resume];
            GameResultLayer *gameResultLayer = [GameResultLayer node];
            [gameResultLayer setGameResult:2];
            [gameResultLayer setIsForceGameEnd:YES];
            CCScene *gameResultScene = [CCScene node];
            [gameResultScene addChild:gameResultLayer];
            [director_ pushScene: gameResultScene];


//            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:gameResultScene withColor:ccWHITE]];
            
        } else if ([actionType isEqualToString:ACTION_INTRO]) {
            if( [navController_ visibleViewController] == director_ )
                [director_ resume];
        } else if ([actionType isEqualToString:ACTION_REGISTER]) {
            if( [navController_ visibleViewController] == director_ )
                [director_ resume];
        } else if ([actionType isEqualToString:ACTION_FIND_PLAYER]) {
            if( [navController_ visibleViewController] == director_ ) {
                [director_ resume];
            }
        }else {
            if( [navController_ visibleViewController] == director_ )
                [director_ resume];
        }

        // GameLayerを表示します
        //        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainLayer scene] withColor:ccWHITE]];
        //        [someField setHidden:YES];
    }
    //    [apiConnection closeToServer];
    
}

- (void) receivedMessageFromConnectToServer:(NSDictionary *)messageDic
{
    // TODO
    BOOL opend = [messageDic valueForKey:@"open"];
    if (opend) {
        [apiConnection setIsConnected:YES];
        [self sendReLogin];
    }
    // and add the scene to the stack. The director will run it when it automatically when the view is displayed.
//	[director_ pushScene: [IntroLayer scene]];
}

- (void)sendReLogin
{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    
//    NSString *loginedUserId = [userDefaults objectForKey:@"NumClickUserID"];
//    NSString *loginedUUID =     [userDefaults objectForKey:@"NumClickUUID"];
    NSMutableArray *accountArray = [AccountManager allAccount];
    NSString *loginId = nil;
    NSString *uuid = nil;
    for (NSDictionary *accountDic in accountArray) {
        loginId = [accountDic objectForKey:@"acct"];
        uuid = [AccountManager getUUIDByAccountId:[accountDic objectForKey:@"acct"]];
    }
        apiConnection.delegate = self;
    
    [apiConnection setActionType:LOGIN_TO_SERVER];
    // TODO 保存！
    [apiConnection sendMessage:[NSString stringWithFormat:@"{\"login\":{\"id\":\"%@\", \"uid\":\"%@\"}}", loginId,uuid]];
    
    
    [apiConnection sendMessage:@"{\"record\":\"\"}"];

}


- (void) dealloc
{
    [apiConnection closeToServer];
	[window_ release];
	[navController_ release];

	[super dealloc];
}
@end

