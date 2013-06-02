//
//  Tile.m
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/02.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Tile.h"
#import "GameLayer.h"

@interface Tile()


// 画像を自己と同じサイズに加工して返します
-(UIImage*) shapingImageNamed:(NSString*)imageNamed;
@end


@implementation Tile

@synthesize Num = _num;
@synthesize Now = _now;
@synthesize Answer = _answer;
@synthesize IsTouchHold = _IsTouchHold;
@synthesize animate, animation;
@synthesize NumLabel;
@synthesize origPositionX, origPositionY;
@synthesize actionList;
@synthesize boneFishAnimation, bonFishAnimate, normalFishAnimate, normalFishAnimation, isBone;
//@synthesize animation1, animation2, animation3;


-(id)init
{
    if (self = [super init]) {
        _num = 0;
        
                _numLabel = nil;
//        animationImage1 = nil;
//        animationImage2 = nil;
//        animationImage3 = nil;;
//        _imgBlinkFrame = nil;

    }
    return self;
}

-(id) initWithTexture:(CCTexture2D*)texture rect:(CGRect)rect
{
    if( (self=[super initWithTexture:texture rect:rect]))
    {
        _num = 0;
        _numLabel = nil;
//        animationImage1 = nil;
//        animationImage2 = nil;
//        animationImage3 = nil;;
//        _imgBlinkFrame = nil;
    }
    return self;
}

//- (void)addToLayer:(CCLayer *)layer
//{
//    [layer addChild:self];
//    // animation code for your big enemy
//}
//- (void)removeFromLayer:(CCLayer *)layer
//{
//    //[layer remove:self];
//    // animation code
//}

- (void) createAnimation
{
    
//    _imgBlinkFrame = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"BlinkFrame.png"].CGImage key:nil];
//    _imgBlinkFrame.position = CGPointMake(self.contentSize.width / 2, self.contentSize.height / 2);
//    _imgBlinkFrame.opacity = 127;
//    [self addChild:_imgBlinkFrame z:1];
//    _imgBlinkFrame.visible = NO;
    
//    CCSpriteFrameCache *cache = [CCSpriteFrameCache sharedSpriteFrameCache];
//    
//    animation1 =[CCSpriteFrame ]
//    animation2 = [cache spriteFrameByName:[NSString stringWithFormat:@"fish_02.png"]];
//    animation3 = [cache spriteFrameByName:[NSString stringWithFormat:@"fish_03.png"]];
    
//    CCTexture2D* texture1 = [[CCTextureCache sharedTextureCache] addCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage forKey:nil];
//    
//    CCTexture2D* texture2 = [[CCTextureCache sharedTextureCache] addCGImage:[self shapingImageNamed:@"fish_02.png"].CGImage forKey:nil];
//    
//    CCTexture2D* texture3 = [[CCTextureCache sharedTextureCache] addCGImage:[self shapingImageNamed:@"fish_03.png"].CGImage forKey:nil];
//    animationImage1 = [CCSprite spriteWithTexture:texture1 rect:CGRectMake(0.0f, 0.0f, texture1.contentSize.width, texture1.contentSize.height)];
//    animationImage2 = [CCSprite spriteWithTexture:texture2 rect:CGRectMake(0.0f, 0.0f, texture2.contentSize.width, texture2.contentSize.height)];
//    
//    animationImage2 = [CCSprite spriteWithTexture:texture3 rect:CGRectMake(0.0f, 0.0f, texture3.contentSize.width, texture3.contentSize.height)];
//    animationImage1 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage key:nil];
//    animationImage2 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_02.png"].CGImage key:nil];
//    animationImage3 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_03.png"].CGImage key:nil];
//    animationImage1.position =  CGPointMake(self.contentSize.width / 2, self.contentSize.height / 2);
//    animationImage2.position =  CGPointMake(self.contentSize.width / 2, self.contentSize.height / 2);
//    animationImage3.position =  CGPointMake(self.contentSize.width / 2, self.contentSize.height / 2);
//    NSLog(@"Self Position x : %f, y : %f", self.position.x, self.position.y);
//    NSLog(@"Animation Position x : %f, y : %f", animationImage1.position.x, animationImage1.position.y);
//    [self addChild:animationImage1 z:3];
//    [self addChild:animationImage2 z:3];
//    [self addChild:animationImage3 z:3];

//    animationImage1.visible = NO;
//    animationImage2.visible = NO;
//    animationImage3.visible = NO;
    
//    //画像データを配列に登録
//    CCSpriteFrame* frame1 = [CCSpriteFrame frameWithTexture:animationImage1.texture rect:CGRectMake(0,0,self.contentSize.width,self.contentSize.height)];
//    CCSpriteFrame* frame2 = [CCSpriteFrame frameWithTexture:animationImage2.texture rect:CGRectMake(0,0,self.contentSize.width,self.contentSize.height)];
//    CCSpriteFrame* frame3 = [CCSpriteFrame frameWithTexture:animationImage3.texture rect:CGRectMake(0,0,self.contentSize.width,self.contentSize.height)];
//    
//    NSArray* animFrames = [NSArray arrayWithObjects: frame1, frame2,frame3,nil];
//    
//    //アニメをつくる
//    
//    CCAnimation *animation = [CCAnimation animationWithFrames:animFrames delay:1.05f];
//    id repeat = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]];
//    [sp999 runAction:repeat];

}

// 画像を自己と同じサイズに加工して返します
-(UIImage*) shapingImageNamed:(NSString*)imageNamed
{
	UIImage* resultImage = [UIImage imageNamed:imageNamed];
	
	UIGraphicsBeginImageContext(CGSizeMake(self.contentSize.width, self.contentSize.height));
	[resultImage drawInRect:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)];
	resultImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return resultImage;
}

- (void)setClickNumLabel
{
    if (_numLabel == nil) {
        _numLabel = [CCLabelTTF labelWithString:@"99" fontName:@"Arial-BoldMT" fontSize:26];
        _numLabel.position = CGPointMake(self.contentSize.width / 2, self.contentSize.height / 2);
        _numLabel.color = ccc3(255, 0, 0);
        
        [self addChild:_numLabel z:2];
        _numLabel.visible = YES;
        
        _numLabel.scale = MIN((self.contentSize.width * 0.8) / _numLabel.contentSize.width, (self.contentSize.height * 0.8) / _numLabel.contentSize.height);
        
        if (_numLabel.scale > 1.0) {
            _numLabel.scale = 1.0;
        }
    }
    
    [_numLabel setString:[NSString stringWithFormat:@"%d", _num + 1]];
    NSLog(@"setClickNumLabel:%d", _num+1);
    _numLabel.visible = YES;
}

- (void) onEnter
{
    [super onEnter];
    
    
    actionList = [[NSMutableArray alloc]init];

    
    [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self priority:-9 swallowsTouches:YES];
    // 通知センタのオブザーバ登録
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotifyFromNotificationCenter:) name:nil object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotifyFromNotificationCenter:) name:[NSString stringWithFormat:@"CountNum-%d", _num] object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotifyFromNotificationCenter:) name:[NSString stringWithFormat:@"AnimationTileNum-%d", _num] object:nil];


    

//    [self setClickNumLabel];
    
//    [self schedule: @selector(minusRotateTile) interval:0.3f];
    
//    [self schedule: @selector(rotateTile) interval:0.5f];
//    [self schedule: @selector(moveTile) interval:0.3f];

    
//    id minusRotate = [CCRotateBy actionWithDuration:0.3 angle:-15];
//
//    id plusRotate = [CCRotateBy actionWithDuration:0.3 angle:30];
//
//    id roop = [CCRepeatForever actionWithAction:plusRotate];
//    id minusloop = [CCRepeatForever actionWithAction:minusRotate];
//    
//    id plusloop = [CCRepeatForever actionWithAction:plusRotate];
//    CCSequence *asequence = [CCSequence actions:minusRotate, plusRotate,nil];
//
//    [self runAction:minusloop];
//    [self stopAction:minusloop];
//    [self runAction:roop];
//    [self stopAction:roop];
//    
    
//    [self createAnimation];
}

- (void) setTileAction
{
    id plusRotate = [CCRotateTo actionWithDuration:0.3 angle:5];
    id plusloop = [CCRepeat actionWithAction:plusRotate times:1];
    [actionList addObject:plusloop];
    id minusRotate = [CCRotateTo actionWithDuration:0.3 angle:-14];
    id minusloop = [CCRepeat actionWithAction:minusRotate times:1];
    [actionList addObject:minusloop];
    id plusRotate2 = [CCRotateTo actionWithDuration:0.3 angle:10];
    id plusloop2 = [CCRepeat actionWithAction:plusRotate2 times:1];
    [actionList addObject:plusloop2];
    id minusRotate2 = [CCRotateTo actionWithDuration:0.3 angle:-5];
    id minusloop2 = [CCRepeat actionWithAction:minusRotate2 times:1];
    [actionList addObject:minusloop2];



    id moveUp = [CCMoveTo actionWithDuration:0.5 position:ccp(self.origPositionX, self.origPositionY+1)];
    id moveUploop = [CCRepeat actionWithAction:moveUp times:1];
    [actionList addObject:moveUploop];
    id moveDown = [CCMoveTo actionWithDuration:0.5 position:ccp(self.origPositionX, self.origPositionY-1)];
    id moveDownloop = [CCRepeat actionWithAction:moveDown times:1];
    [actionList addObject:moveDownloop];
    id moveRight = [CCMoveTo actionWithDuration:0.5 position:ccp(self.origPositionX-1,  self.origPositionY)];
    id moveRightloop = [CCRepeat actionWithAction:moveRight times:1];
    [actionList addObject:moveRightloop];
    id moveleft = [CCMoveTo actionWithDuration:0.5 position:ccp(self.origPositionX+1, self.origPositionY)];
    id moveleftloop = [CCRepeat actionWithAction:moveleft times:1];
    [actionList addObject:moveleftloop];

    
}

- (void) addOriginMoveAction
{
    
    
    id originalRotate = [CCRotateTo actionWithDuration:0.3 angle:0];
    id originalloop = [CCRepeat actionWithAction:originalRotate times:1];
    
    
//    id moveOriginal = [CCMoveTo actionWithDuration:0.3 position:ccp(self.origPositionX, self.origPositionY)];
//    id moveOriginalloop = [CCRepeat actionWithAction:moveOriginal times:1];
    
    [actionList addObject:originalloop];
//    [actionList addObject:moveOriginalloop];
}

- (void) rotateTile
{
//    id plusRotate = [CCRotateTo actionWithDuration:0.3 angle:15];
//    id plusloop = [CCRepeat actionWithAction:plusRotate times:1];
//    
//    id minusRotate = [CCRotateTo actionWithDuration:0.3 angle:-15];
//    id minusloop = [CCRepeat actionWithAction:minusRotate times:1];
//    
//    id plusRotate2 = [CCRotateTo actionWithDuration:0.3 angle:15];
//    id plusloop2 = [CCRepeat actionWithAction:plusRotate2 times:1];
//    
//    id minusRotate2 = [CCRotateTo actionWithDuration:0.3 angle:-15];
//    id minusloop2 = [CCRepeat actionWithAction:minusRotate2 times:1];
//    
//    id moveUp = [CCMoveTo actionWithDuration:0.3 position:ccp(self.origPositionX, self.origPositionY+10)];
//    id moveUploop = [CCRepeat actionWithAction:moveUp times:1];
//    id moveDown = [CCMoveTo actionWithDuration:0.3 position:ccp(self.origPositionX, self.origPositionY-10)];
//    id moveDownloop = [CCRepeat actionWithAction:moveDown times:1];
//    id moveRight = [CCMoveTo actionWithDuration:0.3 position:ccp(self.origPositionX-10,  self.origPositionY)];
//    id moveRightloop = [CCRepeat actionWithAction:moveRight times:1];
//    id moveleft = [CCMoveTo actionWithDuration:0.3 position:ccp(self.origPositionX+10, self.origPositionY)];
//    id moveleftloop = [CCRepeat actionWithAction:moveleft times:1];
//    id moveOriginal = [CCMoveTo actionWithDuration:0.3 position:ccp(self.origPositionX, self.origPositionY)];

    CCSequence *asequence = [CCSequence actionWithArray:actionList];

        [self runAction:asequence];

}

//- (void) moveTile
//{
//    id moveUp = [CCMoveTo actionWithDuration:0.3 position:ccp(self.origPositionX, self.origPositionY+15)];
//    id moveUploop = [CCRepeat actionWithAction:moveUp times:1];
//    id moveDown = [CCMoveTo actionWithDuration:0.3 position:ccp(self.origPositionX, self.origPositionY-15)];
//    id moveDownloop = [CCRepeat actionWithAction:moveDown times:1];
//    id moveRight = [CCMoveTo actionWithDuration:0.3 position:ccp(self.origPositionX-15,  self.origPositionY)];
//    id moveRightloop = [CCRepeat actionWithAction:moveRight times:1];
//    id moveleft = [CCMoveTo actionWithDuration:0.3 position:ccp(self.origPositionX+15, self.origPositionY)];
//    id moveleftloop = [CCRepeat actionWithAction:moveleft times:1];
//    id moveOriginal = [CCMoveTo actionWithDuration:0.3 position:ccp(self.origPositionX, self.origPositionY)];
//    CCSequence *asequenceMoveTile = [CCSequence actions:moveUploop, moveRightloop,moveleftloop,moveDownloop ,moveOriginal,nil];
//    
//    [self runAction:asequenceMoveTile];
//    
//}

- (void)shuffleAction
{
    for (uint i = 0; i < actionList.count; ++i)
    {
        // Select a random element between i and end of array to swap with.
        int nElements = actionList.count - i;
        int n = arc4random_uniform(nElements) + i;
        [actionList exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

- (void) minusRotateTile
{
    id minusRotate = [CCRotateBy actionWithDuration:0.3 angle:-15];
    id minusloop = [CCRepeat actionWithAction:minusRotate times:1];
    if (![self isRunning]) {
        [self stopAction:minusloop];
        [self runAction:minusloop];
    }
}

- (void) onExit
{
    // スーパークラスのonExitをコールします
	[super onExit];
	
	// CCTouchDispatcherの登録を解除します
	[[CCDirector sharedDirector].touchDispatcher removeDelegate:self];
	
	// 通知センタのオブザーバ登録を解除します
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

// タッチ開始
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	BOOL bResult = NO;


	// 長押しフラグを初期化します
//	_isTouchHold = NO;
	
	if ([self containsTouchLocation:touch]) {
		// 自タイルをタッチされている場合、タッチ座標をcocos2d座標に変換し記録します
		CGPoint touchLocation = [touch locationInView: [touch view]];
		_touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
		
		// 長押し判定のスケジュールを立てます
//		_deltaTime = 0.0;
//		[self schedule:@selector(scheduleEventTouchHold:)];
		
		// タッチ開始フラグを立てます
		_isTouchBegin = YES;
		bResult = YES;
	}
	
	return bResult;
}

// ボタンタッチ中移動通知
-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
//	// タッチ中の座標をcocos2d座標に変換します
//	CGPoint touchLocation = [touch locationInView: [touch view]];
//	CGPoint currentTouchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
//	
//	// タッチ開始位置から上下左右方向に一定値以上動いた場合、移動扱いとします
//	CGPoint difference = ccpSub(_touchLocation, currentTouchLocation);
//	float factor = 20;
//	if ((abs(difference.x) > factor) || (abs(difference.y) > factor)) {
//		// 移動座標をuserInfoに設定し、移動通知を発行します
//		NSDictionary* dic = [NSDictionary dictionaryWithObject:touch forKey:TILE_MSG_NOTIFY_TOUCH_MOVE];
//		[[NSNotificationCenter defaultCenter] postNotificationName:TILE_MSG_NOTIFY_TOUCH_MOVE object:self userInfo:dic];
//		
//		// 基準点を現在のタッチ中座標に変えます
//		_touchLocation = currentTouchLocation;
//	}
}

// ボタンのタッチ終了通知
-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	// 長押しスケジュールを停止します
	[self unschedule:@selector(scheduleEventTouchHold:)];
	
	if (_isTouchBegin == YES) {
		if ([self containsTouchLocation:touch]) {
//			if (_isTouchHold == NO) {
				// タップ通知を発行します

			
		}
	}
    if (tileCount-1 >= _num) {
         [[NSNotificationCenter defaultCenter] postNotificationName:NUM_CLICK object:self];

    } else {


    }


    
	
	// タッチ終了通知を発行します
	    
//    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"ClickNow-%d", _now] object:self];
	
	// タッチフラグを初期化します

	_isTouchBegin = NO;
}

- (BOOL)containsTouchLocation:(UITouch *)touch
{
    CGPoint touchLocation = [touch locationInView:[touch view]];
    CGPoint location = [[CCDirector sharedDirector] convertToGL:touchLocation];
    
    CGRect boundingBox = self.boundingBox;
    
    CCNode* parent = self.parent;
    while (parent != nil) {
        if ([parent isKindOfClass:[CCLayer class]]) {
            break;
        } else {
            parent = parent.parent;
        }
    }
    
    if (parent != nil) {
        boundingBox.origin = ccpAdd(boundingBox.origin, parent.position);
    }
    
    return CGRectContainsPoint(boundingBox, location);
}

// 通知センタからの通知イベント
-(void) NotifyFromNotificationCenter:(NSNotification*)notification
{
    if ([notification.name isEqualToString:[NSString stringWithFormat:@"CountNum-%d", _num]]) {
        [self stopAllActions];
        [self unschedule:@selector(rotateTile)];
        [self setIsBone:YES];
        [self runAction:bonFishAnimate];
//        _imgBlinkFrame.opacity = 255;
//        _imgBlinkFrame.visible = YES;
//        id fadeOut = [CCFadeTo actionWithDuration:0.3 opacity:0];
//        id fadeIn = [CCFadeTo actionWithDuration:0.8 opacity:255];
//        id seq = [CCSequence actions:fadeOut, fadeIn, nil];
//        id rep = [CCRepeatForever actionWithAction:seq];
//        [_imgBlinkFrame runAction:rep];
        
//        CCSprite* image = [CCSprite spriteWithFile:@"fish_01.png"];
//        image.position = CGPointMake(self.contentSize.width /2 , self.contentSize.height/2);
//        [self addChild:image];
//        
//        CCAnimation *anim= [CCAnimation animation];
//        
//        [anim addSpriteFrameWithFilename:@"fish_01.png"];
//        
//        [anim addSpriteFrameWithFilename:@"fish_02.png"];
//        
//        anim.delayPerUnit = 0.5;
//        
//        anim.loops = -1;
//        
//        CCAnimate* ant = [CCAnimate actionWithAnimation:anim];
//        [self runAction:ant];
        
//                CCSprite* animationimage = [CCSprite spriteWithFile:@"fish_01.png"];
//                // 画像の配置場所の設定
//                animationimage.position = CGPointMake(self.contentSize.width / 2, self.contentSize.height / 2);
//        
//        CCSprite* animationimage2 = [CCSprite spriteWithFile:@"fish_02.png"];
//        // 画像の配置場所の設定
//        animationimage2.position = CGPointMake(self.contentSize.width / 2, self.contentSize.height / 2);
//        
//        CCSprite* animationimage3 = [CCSprite spriteWithFile:@"fish_03.png"];
//        // 画像の配置場所の設定
//        animationimage3.position = CGPointMake(self.contentSize.width / 2, self.contentSize.height / 2);
//        
//                animation= [CCAnimation animation];
//                [animation addSpriteFrameWithTexture:animationimage.texture rect:CGRectMake(0, 0, 80, 80)];
//
//        [animation addSpriteFrameWithTexture:animationimage2.texture rect:CGRectMake(0, 0, 80, 80)];
//
//        [animation addSpriteFrameWithTexture:animationimage3.texture rect:CGRectMake(0, 0, 80, 80)];
//
////                [animation addSpriteFrameWithFilename:@"fish_02.png"];
////        
////                [animation addSpriteFrameWithFilename:@"fish_03.png"];
//        
//                animation.delayPerUnit = 0.5;
//        
//                animation.loops = 1;
//                animate = [CCAnimate actionWithAnimation:animation];
//                //CCAnimation *walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:0.1f ];
//        //        CCAnimate *animate  = [CCAnimate actionWithAnimation:animation];
//        [self addChild:animationimage];
//               [self runAction:animate];
        // small capacity. Testing resizing.
		// Don't use capacity=1 in your real game. It is expensive to resize the capacity

//		CCSprite *sprite1 = [CCSprite spriteWithTexture:batch.texture rect:CGRectMake(85*0, 121*1, 85, 121)];
//		CCSprite *sprite2 = [CCSprite spriteWithTexture:batch.texture rect:CGRectMake(85*1, 121*1, 85, 121)];
//		CCSprite *sprite3 = [CCSprite spriteWithTexture:batch.texture rect:CGRectMake(85*2, 121*1, 85, 121)];
//		CCSprite *sprite4 = [CCSprite spriteWithTexture:batch.texture rect:CGRectMake(85*3, 121*1, 85, 121)];
//        
//		CCSprite *sprite5 = [CCSprite spriteWithTexture:batch.texture rect:CGRectMake(85*0, 121*1, 85, 121)];
//		CCSprite *sprite6 = [CCSprite spriteWithTexture:batch.texture rect:CGRectMake(85*1, 121*1, 85, 121)];
//		CCSprite *sprite7 = [CCSprite spriteWithTexture:batch.texture rect:CGRectMake(85*2, 121*1, 85, 121)];
//		CCSprite *sprite8 = [CCSprite spriteWithTexture:batch.texture rect:CGRectMake(85*3, 121*1, 85, 121)];
//        
//        
//		CGSize s = [[CCDirector sharedDirector] winSize];
//		sprite1.position = ccp( (s.width/5)*1, (s.height/3)*1);
//		sprite2.position = ccp( (s.width/5)*2, (s.height/3)*1);
//		sprite3.position = ccp( (s.width/5)*3, (s.height/3)*1);
//		sprite4.position = ccp( (s.width/5)*4, (s.height/3)*1);
//		sprite5.position = ccp( (s.width/5)*1, (s.height/3)*2);
//		sprite6.position = ccp( (s.width/5)*2, (s.height/3)*2);
//		sprite7.position = ccp( (s.width/5)*3, (s.height/3)*2);
//		sprite8.position = ccp( (s.width/5)*4, (s.height/3)*2);
//        
//		id action = [CCFadeIn actionWithDuration:2];
//		id action_back = [action reverse];
//		id fade = [CCRepeatForever actionWithAction: [CCSequence actions: action, action_back, nil]];
//        
//		id tintred = [CCTintBy actionWithDuration:2 red:0 green:-255 blue:-255];
//		id tintred_back = [tintred reverse];
//		id red = [CCRepeatForever actionWithAction: [CCSequence actions: tintred, tintred_back, nil]];
//        
//		id tintgreen = [CCTintBy actionWithDuration:2 red:-255 green:0 blue:-255];
//		id tintgreen_back = [tintgreen reverse];
//		id green = [CCRepeatForever actionWithAction: [CCSequence actions: tintgreen, tintgreen_back, nil]];
//        
//		id tintblue = [CCTintBy actionWithDuration:2 red:-255 green:-255 blue:0];
//		id tintblue_back = [tintblue reverse];
//		id blue = [CCRepeatForever actionWithAction: [CCSequence actions: tintblue, tintblue_back, nil]];
//        
//        
//		[sprite5 runAction:red];
//		[sprite6 runAction:green];
//		[sprite7 runAction:blue];
//		[sprite8 runAction:fade];
//        
//		// late add: test dirtyColor and dirtyPosition
//		[batch addChild:sprite1 z:0 tag:kTagSprite1];
//		[batch addChild:sprite2 z:0 tag:kTagSprite2];
//		[batch addChild:sprite3 z:0 tag:kTagSprite3];
//		[batch addChild:sprite4 z:0 tag:kTagSprite4];
//		[batch addChild:sprite5 z:0 tag:kTagSprite5];
//		[batch addChild:sprite6 z:0 tag:kTagSprite6];
//		[batch addChild:sprite7 z:0 tag:kTagSprite7];
//		[batch addChild:sprite8 z:0 tag:kTagSprite8];
//        
//        
//		[self schedule:@selector(removeAndAddSprite:) interval:2];
        
    } else if ([notification.name isEqualToString:[NSString stringWithFormat:@"AnimationTileNum-%d", _num]]) {
        if (self.isBone == NO) {
            //        [self stopAction:normalFishAnimate];
            //        CCMoveTo *moveUp = [CCMoveTo actionWithDuration:0.3 position:ccp(self.position.x, self.position.y+3)];
            //        CCMoveTo *moveDown = [CCMoveTo actionWithDuration:0.3 position:ccp(self.position.x, self.position.y-3)];
            //        CCMoveTo *moveRight = [CCMoveTo actionWithDuration:0.3 position:ccp(self.position.x-3, self.position.y)];
            //        CCMoveTo *moveleft = [CCMoveTo actionWithDuration:0.3 position:ccp(self.position.x+3, self.position.y)];
            //        CCMoveTo *moveOriginal = [CCMoveTo actionWithDuration:0.3 position:ccp(self.position.x, self.position.y)];
            
            //        CCSequence* seq = [CCSequence actions:animate,moveUp,  moveRight, moveDown, moveleft,moveOriginal,nil];
            CCSequence* seq = [CCSequence actions:animate,nil];
            if([self isRunning]) {
                
                [self stopAction:seq];
                [self runAction:seq];
            } else {
                [self runAction:seq];
            }
        }

 
    }
	if ([notification.name isEqualToString: TILE_MSG_NOTIFY_TOUCH_END]) {
    }
    
//    if ([notification.name isEqualToString:[NSString stringWithFormat:@"ClickNow-%d", _num]]) {
//        CCLOG(@"touch");
//                [self unscheduleUpdate];
//
////        animationImage1.position = self.position;
////        animationImage2.position = self.position;
////        NSLog(@"Self Position x : %f, y : %f", self.position.x, self.position.y);
////         NSLog(@"Animation Position x : %f, y : %f", animationImage1.position.x, animationImage1.position.y);
//        self.visible = NO;
////        CCSprite* animationimage = [CCSprite spriteWithFile:@"fish_01.png"];
////        // 画像の配置場所の設定
////        animationimage.position = CGPointMake(self.contentSize.width / 2, self.contentSize.height / 2);
////        [self addChild:animationimage z:4];
//        //        CCSprite *frameImage1 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage key:nil];
//        //        CCSprite *frameImage2 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_02.png"].CGImage key:nil];
//        //        CCSprite *frameImage3 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_03.png"].CGImage key:nil];
//        //
//        //        CCSpriteFrame* frame1 = [CCSpriteFrame frameWithTexture:frameImage1.texture rect:CGRectMake(0,0,self.contentSize.width,self.contentSize.height)];
//        //        CCSpriteFrame* frame2 = [CCSpriteFrame frameWithTexture:frameImage2.texture rect:CGRectMake(0,0,self.contentSize.width,self.contentSize.height)];
//        //        CCSpriteFrame* frame3 = [CCSpriteFrame frameWithTexture:frameImage3.texture rect:CGRectMake(0,0,self.contentSize.width,self.contentSize.height)];
//        //
//        //        [animation addSpriteFrame:frame1];
//        //
//        //        [animation addSpriteFrame:frame2];
//        //        
//        //        [animation addSpriteFrame:frame3];
//
//
//        
//        //[self runAction:self.animate];
//
//        
////        CCAnimate * animate = [CCAnimate actionWithAnimation:animation];
//
//
//    }
}


- (void) addSchedule
{
    [self unscheduleAllSelectors];
    [self schedule: @selector(rotateTile) interval:0.5f];
}

-(void) update:(ccTime)delta {
    
}




@end


