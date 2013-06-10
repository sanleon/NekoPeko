//
//  RegisterLayer.m
//  NanClickBoom
//
//  Created by A12889 on 13/03/11.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "RegisterLayer.h"
#import "MainLayer.h"
#import "ModalAlert.h"
#import "AccountManager.h"


@implementation RegisterLayer

+(CCScene*) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	RegisterLayer *layer = [RegisterLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void) onEnter
{
    [super onEnter];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:ACTION_REGISTER forKey:ACTION_TYPE];
    [userDefaults synchronize];
    apiConnection = [APIConnection sharedAPIConnection];
    apiConnection.delegate = self;
    
    someField = [[UITextField alloc] initWithFrame:CGRectMake(30, 58, 260, 28)];
    someField.delegate = self;
    someField.alpha = 0.0;
    
    [someField setPlaceholder:@"ログインIDを入力してください"];
    
    [someField setBackgroundColor:[UIColor whiteColor]];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite * backImage = [CCSprite spriteWithFile:@"common_bg.png"];
    backImage.position = CGPointMake(winSize.width/2, winSize.height/2);
    [self addChild:backImage z:0];
    
    CCSprite * inputForm = [CCSprite spriteWithFile:@"signup_input_form.png"];
    inputForm.position = ccp(winSize.width/2, 421);
    [self addChild:inputForm z:1];
    
    NSLog(@"winSize.height/2 %f", winSize.height/2);
    NSLog(@"winSize.width/2 %f", winSize.width/2);
    CCSprite * startDevideBar = [CCSprite spriteWithFile:@"signup_devide_bar.png"];
    startDevideBar.position = CGPointMake(winSize.width/2, 358);
    [self addChild:startDevideBar z:2];
    
    CCSprite * selectCat = [CCSprite spriteWithFile:@"signup_select_cat.png"];
    selectCat.position = CGPointMake(winSize.width/2, 264);
    [self addChild:selectCat z:2];
    
    CCSprite * endDevideBar = [CCSprite spriteWithFile:@"signup_devide_bar.png"];
    endDevideBar.position = CGPointMake(winSize.width/2, 163);
    [self addChild:endDevideBar z:2];
    
    CCSprite * bottomAni = [CCSprite spriteWithFile:@"signup_bottom_ani.png"];
    bottomAni.position = CGPointMake(winSize.width/2, 67);
    [self addChild:bottomAni z:2];
    
    
    
    
    // create and initialize a Label
//    CCLabelTTF *label = [CCLabelTTF labelWithString:@"登録画面" fontName:@"Marker Felt" fontSize:24];

    
    CCMenuItemImage *item = [CCMenuItemImage itemWithNormalImage:@"signup_btn_ok.png" selectedImage:@"signup_btn_ok.png" block:^(id sender){
        receiveMessageDic = nil;
        [self performSelectorOnMainThread:@selector(sendMessageByAPI) withObject:nil waitUntilDone:YES];
        
        
        //        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainLayer scene] withColor:ccWHITE]];
        //                [someField setHidden:YES];
        
    }];
    
    CCMenu *menu = [CCMenu menuWithItems:item, nil];
    menu.position = CGPointMake(winSize.width/2, 127);
    
    // add the label as a child to this Layer
    //    [self addChild: label];
    [self addChild: menu z:5];

    
    
    // TODO 位置修正
    // Set any attributes to your field
    //    CCLabelTTF * someLabel = [CCLabelTTF labelWithString:@"Login" dimensions:CGSizeMake(100, 30) hAlignment:UITextAlignmentLeft fontName:@"Marker Felt" fontSize:12];
    
    //        CCTextField * tf = [CCTextField textFieldWithFieldSize:CGSizeMake(200, 20) fontName:@"Marker Felt" andFontSize:12];
    // ask director for the window size
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    [[[CCDirector sharedDirector] view] addSubview:someField];
    // position the label on the center of the screen
    // TODO 位置選定が必要
//    label.position =  ccp(size.width/2 ,380);
    
    
    
    //     [socket send:[NSString stringWithFormat:@"{\"login\":{\"id\":\"%@\"}}", loginId]];
//    [CCMenuItemFont setFontName:@"Helvetica-BoldOblique"];
//    [CCMenuItemFont setFontSize:30];
//    
//    CCMenuItemFont *item = [CCMenuItemFont itemWithString:@"Login" block:^(id sender){
//        receiveMessageDic = nil;
//        [self performSelectorOnMainThread:@selector(sendMessageByAPI) withObject:nil waitUntilDone:YES];
//        
//        
//        //        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainLayer scene] withColor:ccWHITE]];
//        //                [someField setHidden:YES];
//        
//    }];
    
//    CCMenu *menu = [CCMenu menuWithItems:item, nil];
//    menu.position = CGPointMake(size.width/2, 20);
//    
//    // add the label as a child to this Layer
////    [self addChild: label];
//    [self addChild: menu];
//    CCSprite* animationimage = [CCSprite spriteWithFile:@"fish_01.png"];
//    
//    //        // 画像の配置場所の設定
//    animationimage.position = CGPointMake(200, self.contentSize.height / 2);
//    [self addChild:animationimage z:4];
//    CCAnimation* animation = [CCAnimation animation];
//    [animation addSpriteFrameWithFilename:@"fish_01.png"];
//    
//    [animation addSpriteFrameWithFilename:@"fish_02.png"];
//    
//    [animation addSpriteFrameWithFilename:@"fish_03.png"];
//    //        CCSprite *frameImage1 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage key:nil];
//    //        CCSprite *frameImage2 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_02.png"].CGImage key:nil];
//    //        CCSprite *frameImage3 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_03.png"].CGImage key:nil];
//    //
//    //        CCSpriteFrame* frame1 = [CCSpriteFrame frameWithTexture:frameImage1.texture rect:CGRectMake(0,0,self.contentSize.width,self.contentSize.height)];
//    //        CCSpriteFrame* frame2 = [CCSpriteFrame frameWithTexture:frameImage2.texture rect:CGRectMake(0,0,self.contentSize.width,self.contentSize.height)];
//    //        CCSpriteFrame* frame3 = [CCSpriteFrame frameWithTexture:frameImage3.texture rect:CGRectMake(0,0,self.contentSize.width,self.contentSize.height)];
//    //
//    //        [animation addSpriteFrame:frame1];
//    //
//    //        [animation addSpriteFrame:frame2];
//    //
//    //        [animation addSpriteFrame:frame3];
//    
//    animation.delayPerUnit = 0.5;
//    
//    animation.loops = -1;
//    
//    CCAnimate * animate = [CCAnimate actionWithAnimation:animation];
//    
//    [animationimage runAction:animate];
}

- (void) onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    someField.alpha = 1.0;
    
}

- (void) receivedErrorFromAction:(NSString *)message
{

    if ([message isEqualToString:ERROR_SEND_UID]) {
        NSLog(@"Error : %@", ERROR_SEND_UID);
    } else if([message isEqualToString:ERROR_SEND_YOUR_INFO]) {
        // TODO ログインされてない状態
        NSLog(@"Error : %@", ERROR_SEND_YOUR_INFO);
    } else if([message isEqualToString:ERROR_SEND_ANOTHER_ID]) {
        // TODO

        NSLog(@"Error : %@", ERROR_SEND_ANOTHER_ID);
    } else if([message isEqualToString:ERROR_SEND_YOUR_INFO]) {
        // TODO ログインされてない状態
        NSLog(@"Error : %@", ERROR_SEND_YOUR_INFO);
    } else if([message isEqualToString:ERROR_SEND_ANOTHER_NAME]){
        [someField setAlpha:0.0];
        [ModalAlert Tell:@"既に使っているIDです。もう一度入力してください。" onLayer:self okBlock:^{
            [someField setText:@""];
            [someField setAlpha:1.0];
        }];
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

- (void) receivedMessageFromRegisterToServer:(NSDictionary *)messageDic
{
    receiveMessageDic = messageDic;
    BOOL result = NO;
    if (receiveMessageDic != nil) {
        result = [receiveMessageDic valueForKey:@"login"];
        NSLog(@"result : %d", result);
    }
    
    if (result) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *accId = [userDefaults objectForKey:@"NumClickUserID"];
        NSString *uuid = [userDefaults objectForKey:@"NumClickUUID"];
        [AccountManager addAccount:uuid accountId:accId];


        [userDefaults setObject:0 forKey:@"WinCount"];
        [userDefaults setObject:0 forKey:@"LoseCount"];
        [userDefaults setObject:0 forKey:@"DrawCount"];

        // GameLayerを表示します
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainLayer scene] withColor:ccWHITE]];
        someField.alpha = 0.0;
        [someField setHidden:YES];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction) makeKeyboardGoAway{
    [someField resignFirstResponder];
}

- (void) sendMessageByAPI
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uuid = [self getUUID];
    
    
    // TODO
    [userDefaults setObject:someField.text forKey:@"NumClickUserID"];
    // TODO
    [userDefaults setObject:uuid forKey:@"NumClickUUID"];
    [userDefaults synchronize];

    [apiConnection setActionType:REGISTER_TO_SERVER];
    // TODO 保存！
    [apiConnection sendMessage:[NSString stringWithFormat:@"{\"create\":{\"id\":\"%@\", \"uid\":\"%@\",\"catId\":1}}", someField.text, uuid]];
}

- (NSString*) getUUID {
    CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString *uuidString = (NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return [uuidString autorelease];
}


@end
