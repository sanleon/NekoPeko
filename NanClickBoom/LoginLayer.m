//
//  LoginLayer.m
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/02.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "LoginLayer.h"
#import "GameLayer.h"
#import "MainLayer.h"
#import "APIConnection.h"

@implementation LoginLayer


+(CCScene*) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	LoginLayer *layer = [LoginLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id) init
{
    if (self = [super init] ) {
        receiveMessageDic = nil;
        apiConnection = nil;

    }
    return self;
}

- (void) onEnter
{
    [super onEnter];
    apiConnection = [APIConnection sharedAPIConnection];
    apiConnection.delegate = self;

    // create and initialize a Label
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Login画面" fontName:@"Marker Felt" fontSize:24];
    someField = [[UITextField alloc] initWithFrame:CGRectMake(0, 200, 150, 30)];
    [someField setPlaceholder:@"ログインIDを入力してください"];
    someField.delegate = self;
    [someField setBackgroundColor:[UIColor whiteColor]];
    
    
    // TODO 位置修正
    // Set any attributes to your field
//    CCLabelTTF * someLabel = [CCLabelTTF labelWithString:@"Login" dimensions:CGSizeMake(100, 30) hAlignment:UITextAlignmentLeft fontName:@"Marker Felt" fontSize:12];

    // ask director for the window size
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    [[[CCDirector sharedDirector] view] addSubview:someField];
    // position the label on the center of the screen
    // TODO 位置選定が必要
    label.position =  ccp(size.width/2 ,380);
    

    
//     [socket send:[NSString stringWithFormat:@"{\"login\":{\"id\":\"%@\"}}", loginId]];  
    [CCMenuItemFont setFontName:@"Helvetica-BoldOblique"];
    [CCMenuItemFont setFontSize:30];

    CCMenuItemFont *item = [CCMenuItemFont itemWithString:@"Login" block:^(id sender){
        receiveMessageDic = nil;
        [self performSelectorOnMainThread:@selector(sendMessageByAPI) withObject:nil waitUntilDone:YES];


//        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainLayer scene] withColor:ccWHITE]];
//                [someField setHidden:YES];

    }];
    
    CCMenu *menu = [CCMenu menuWithItems:item, nil];
    menu.position = CGPointMake(size.width/2, 20);
    
    // add the label as a child to this Layer
    [self addChild: label];
    [self addChild: menu];
    CCSprite* animationimage = [CCSprite spriteWithFile:@"fish_01.png"];

    //        // 画像の配置場所の設定
            animationimage.position = CGPointMake(200, self.contentSize.height / 2);
            [self addChild:animationimage z:4];
    CCAnimation* animation = [CCAnimation animation];
    [animation addSpriteFrameWithFilename:@"fish_01.png"];
    
    [animation addSpriteFrameWithFilename:@"fish_02.png"];
    
    [animation addSpriteFrameWithFilename:@"fish_03.png"];
    //        CCSprite *frameImage1 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage key:nil];
    //        CCSprite *frameImage2 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_02.png"].CGImage key:nil];
    //        CCSprite *frameImage3 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_03.png"].CGImage key:nil];
    //
    //        CCSpriteFrame* frame1 = [CCSpriteFrame frameWithTexture:frameImage1.texture rect:CGRectMake(0,0,self.contentSize.width,self.contentSize.height)];
    //        CCSpriteFrame* frame2 = [CCSpriteFrame frameWithTexture:frameImage2.texture rect:CGRectMake(0,0,self.contentSize.width,self.contentSize.height)];
    //        CCSpriteFrame* frame3 = [CCSpriteFrame frameWithTexture:frameImage3.texture rect:CGRectMake(0,0,self.contentSize.width,self.contentSize.height)];
    //
    //        [animation addSpriteFrame:frame1];
    //
    //        [animation addSpriteFrame:frame2];
    //
    //        [animation addSpriteFrame:frame3];
    
    animation.delayPerUnit = 0.5;
    
    animation.loops = -1;
    
    CCAnimate * animate = [CCAnimate actionWithAnimation:animation];
    
    [animationimage runAction:animate];
}

- (void) onExit
{
    receiveMessageDic = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction) makeKeyboardGoAway{
    [someField resignFirstResponder];
}

- (void) receivedMessageWithDic:(NSDictionary *)messageDic
{

    
}

- (void) receivedErrorFromAction:(NSString *)message
{
    if ([message isEqualToString:ERROR_ALREADY_LOGIN]) {
        // TODO すでに敵
        NSLog(@"Already Login");
    } else if([message isEqualToString:ERROR_USED_ID]) {
        // TODO ログインされてない状態
        NSLog(@"Already Used ID");
    } else {
        NSLog(@"Error Message : %@", message);
        // TODO
        // GameLayerを表示します

    }

    [someField setHidden:NO];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    // TODO
    [userDefaults setObject:nil forKey:@"NumClickUserID"];
    [userDefaults synchronize];
}

- (void) receivedMessageFromLoginToServer:(NSDictionary *)messageDic
{
    receiveMessageDic = messageDic;
    BOOL result = NO;
    if (receiveMessageDic != nil) {
        result = [receiveMessageDic valueForKey:@"login"];
        NSLog(@"result : %d", result);
    }
    
    if (result) {
        // GameLayerを表示します
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainLayer scene] withColor:ccWHITE]];
        [someField setHidden:YES];
    }
    
}

- (void) sendMessageByAPI
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    // TODO 
    [userDefaults setObject:someField.text forKey:@"NumClickUserID"];
    [userDefaults synchronize];
    [apiConnection setActionType:LOGIN_TO_SERVER];
    // TODO 保存！
    [apiConnection sendMessage:[NSString stringWithFormat:@"{\"login\":{\"id\":\"%@\", \"uid\":\"%@\"}}", someField.text, [self getUUID]]];
}

- (NSString*) getUUID {
    CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString *uuidString = (NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return [uuidString autorelease];
}


@end
