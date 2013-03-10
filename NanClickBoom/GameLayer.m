//
//  GameLayer.m
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/02.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "MainLayer.h"



@implementation GameLayer

@synthesize CurrentNumLabel = _cu;
@synthesize currentEnemyScore = _currentEnemyScore;
@synthesize currentMyScore = _currentMyScore;

enum {
	kTagTileMap = 1,
	kTagSpriteBatchNode = 1,
	kTagNode = 2,
	kTagAnimation1 = 1,
	kTagSpriteLeft,
	kTagSpriteRight,
};

enum {
	kTagSprite1,
	kTagSprite2,
	kTagSprite3,
	kTagSprite4,
	kTagSprite5,
	kTagSprite6,
	kTagSprite7,
	kTagSprite8,
};

//@synthesize CurrentNum = _currentNum;
//static int currentNumber = 1;


+(CCScene*) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


- (id) init
{
    if (self = [super init]) {
        //_tileCount = 16;
        _tileList = nil;
        _currentMyScore = 0;
        _currentEnemyScore = 0;
        
    }
    return self;
}

- (void) onEnter
{
    [super onEnter];
    _currentGameCount = 1;
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite * backImage = [CCSprite spriteWithFile:@"main.png"];
    backImage.position = CGPointMake(winSize.width/2, winSize.height/2);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotifyFromNotificationCenter:) name:nil object:nil];
    
    
//    CCTexture2D* texture = [[CCTextureCache sharedTextureCache] addCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage forKey:nil];


    
//    CCTexture2D* tex = [[[CCTexture2D alloc] initWithCGImage:[UIImage imageNamed:@"fish_01.png"].CGImage resolutionType:kCCResolutioniPhone] autorelease];
    
    int sideTileCount = (int)sqrt((double)tileCount);
    
    // TODO iPhone4, iPhone4S, iPhone5の対応が必要
    tileBackgroundWidth = 560;
    tileBackgroundHeight = 520;
    tileHeight = (int)tileBackgroundHeight / sideTileCount;
    tileWidth = (int)tileBackgroundWidth / sideTileCount;
    CGSize tilBackGroundSize = CGSizeMake(tileBackgroundWidth, tileBackgroundHeight);
    
    _tileList = [[CCArray alloc] initWithCapacity:tileCount];
//    Tile* tile = [Tile spriteWithFile:@"Frame.png" rect:CGRectMake(200, 200 , 40, 40)];
//
//
//            [self addChild:tile z:1];
    _currentNum = 0;
        [self addChild:backImage z:0];
    for (int i = 0; i < tileCount; i++) {
//        Tile* tile = [Tile spriteWithFile:@"" rect:CGRectMake(tileSize.width * (i % sideTileCount), tileSize.height * (i / sideTileCount), tileSize.width, tileSize.height)];
 //       NSLog(@"size : %d", (i % sideTileCount));
//        Tile* tile = [Tile spriteWithFile:@"Frame.png" rect:CGRectMake(tileHeight * (i % sideTileCount), tileWidth * (i / sideTileCount), tileWidth, tileHeight)];

//                Tile* tile = [Tile spriteWithFile:@"fish_01.png" rect:CGRectMake(0, 0, tileWidth, tileHeight)];
// TODO
        Tile* tile = [Tile spriteWithCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage key:nil];
        //[tile addToLayer:self];
        [_tileList addObject:tile];
        tile.Num = i;
        tile.animation = [CCAnimation animation];


        
        CCSprite *frameImage1 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage key:nil];
        CCSprite *frameImage2 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_02.png"].CGImage key:nil];
        CCSprite *frameImage3 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_03.png"].CGImage key:nil];
        CCSprite *frameImage4 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage key:nil];
        //
        CCSpriteFrame* frame1 = [CCSpriteFrame frameWithTexture:frameImage1.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
        CCSpriteFrame* frame2 = [CCSpriteFrame frameWithTexture:frameImage2.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
        CCSpriteFrame* frame3 = [CCSpriteFrame frameWithTexture:frameImage3.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
        CCSpriteFrame* frame4 = [CCSpriteFrame frameWithTexture:frameImage4.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
        
        [tile.animation addSpriteFrame:frame1];
        
        [tile.animation addSpriteFrame:frame2];
        //
        [tile.animation addSpriteFrame:frame3];
        
        [tile.animation addSpriteFrame:frame4];
        
        tile.animation.delayPerUnit = 0.5;
        
        tile.animation.loops = 1;
        
        
        tile.animate   = [CCAnimate actionWithAnimation:tile.animation];
        [self addChild:tile z:1 tag:i];
        
        // 画像の
        
//        CCSprite* tile = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage key:nil];
//        CCAnimation *animation = [CCAnimation animation];
//        [_tileList addObject:tile];
//        //tile.Num = i;
//        
//        [self addChild:tile z:1];
//        CCSprite *frameImage1 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage key:nil];
//        CCSprite *frameImage2 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_02.png"].CGImage key:nil];
//        CCSprite *frameImage3 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_03.png"].CGImage key:nil];
//        //
//        CCSpriteFrame* frame1 = [CCSpriteFrame frameWithTexture:frameImage1.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
//        CCSpriteFrame* frame2 = [CCSpriteFrame frameWithTexture:frameImage2.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
//        CCSpriteFrame* frame3 = [CCSpriteFrame frameWithTexture:frameImage3.texture rect:CGRectMake(0,0,tile.contentSize.width,tile.contentSize.height)];
        

        
//        if (texture)
//        {
//            // Get the size of the new texture:
//            CGSize size = [texture contentSize];
//            Tile* tile = [Tile spriteWithFile:@"fish_01.png"];
//
////            Tile* tile = [Tile spriteWithCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage key:nil];
//            tile.Num = i;
//            [_tileList addObject:tile];
//        CCSprite* tile = [CCSprite spriteWithFile:@"fish_01.png"];
        
        //            Tile* tile = [Tile spriteWithCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage key:nil];



        //[tile createAnimation];

//            [sprite1 setTexture:texture];
            // use the size of the new texture:
//            [sprite1 setTextureRect:CGRectMake(0.0f, 0.0f, size.width,size.height)];
//        }
//        Tile* tile = [Tile spriteWithFile:@"fish_01.png" rect:CGRectMake(0, 0, 60, 60)];

        
    }
    [self shuffle];
    [self setTiles];
    
    
    CCSprite * progressBorder = [CCSprite spriteWithFile: @ "progressbarborder.png"];
	[progressBorder setPosition:ccp(winSize.width/2 + 0.5 - 45, winSize.height - 20.5f)];
	[self addChild: progressBorder z:1];
    
    CCProgressTimer *lifeBar=[CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:@"progressbar.png"]];
    lifeBar.type=kCCProgressTimerTypeBar;
    lifeBar.midpoint = ccp(0,0);
    lifeBar.position=ccp(winSize.width/2 + 0.5 - 45, winSize.height - 20.5f);
    lifeBar.percentage=100;
    [lifeBar setBarChangeRate:(ccp(1,0))];
    [self addChild:lifeBar z:1];
    //[lifeBar runAction:[CCProgressFromTo actionWithDuration:gameLimitedSecond from:100.0 to:0.0]];
    
    CCProgressTo *progressTo = [CCProgressTo actionWithDuration:gameLimitedSecond percent:100];
	[lifeBar runAction:progressTo];
//    [self addChild:lifeBar z:1];
    //[lifeBar runAction:[CCProgressFromTo actionWithDuration:gameLimitedSecond from:100.0 to:0.0]];
    CCCallFunc *cbDecrFinished = [CCCallFunc actionWithTarget:self selector:@selector(decreaseProgressBarFinished:)];
	CCProgressFromTo *progressToZero = [CCProgressFromTo actionWithDuration:gameLimitedSecond from:100.0 to:0.0];
	CCSequence *asequence = [CCSequence actions:progressToZero, cbDecrFinished, nil];
    
	[lifeBar runAction:asequence];

    
//	CCProgressTimer* progressBar = [CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:@"progressbar.png"]];
//	progressBar.type = kCCProgressTimerTypeBar;
//    
//	
//	[progressBar setAnchorPoint: ccp(0,0)];
//
//    CCProgressTo *progressTo = [CCProgressTo actionWithDuration:10 percent:100];
//	[progressBar runAction:progressTo];
//    
    
    _timerLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%.01f",0.0f] fontName:@"Marker Felt" fontSize:64];
    _timerLabel.position = CGPointMake(winSize.width/2, winSize.height - winSize.height/6);
    _timer = gameLimitedSecond;
    [self addChild:_timerLabel];
    [self schedule:@selector(updateTimer) interval:1];
//    // create and initialize a Label
//    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game画面" fontName:@"Marker Felt" fontSize:24];
//    CGSize size = [[CCDirector sharedDirector] winSize];
//    label.position =  ccp(size.width/2 ,380);
//    
//    [self addChild: label];
    
}

- (void) onEnterTransitionDidFinish
{
    
    apiConnection = [APIConnection sharedAPIConnection];
    apiConnection.delegate = self;
    
}

- (void)updateTimer{
    _timer -= 1;
    
    if (0 == _timer) {
        
        [_timerLabel setString:[NSString stringWithFormat:@"0.0"]]; // -0.0と表示されてしまうため0の時は特別に。
        // タイマーを止める
        [self unschedule:@selector(updateTimer)];
        // gameOverの呼び出し
        [self gameOver];
        return;
    }
    [_timerLabel setString:[NSString stringWithFormat:@"%.01f",_timer]];
}

- (void) onExit
{
    [super onExit];
   	// 通知センタのオブザーバ登録を解除します
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) setTiles
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CGSize tileSize = ((Tile*)[_tileList objectAtIndex:0]).contentSize;
    
    int sideTileCount = (int)sqrt((double)tileCount);
    
    float startX = 20;
    
    float startY = 100;
    
    float blankX = (winSize.width - tileSize.width * sideTileCount) / 2;
    
    float blankY = (winSize.height - tileSize.height * sideTileCount) / 2;
    
    for (int i = 0; i < _tileList.count; i++) {
//        Tile *tile = [_tileList objectAtIndex:i];
//        tile.Now = i;

        Tile *tile = [_tileList objectAtIndex:i];
        
        [tile setClickNumLabel];
        [tile.NumLabel setVisible:YES];
        tile.position = CGPointMake(startX + tileSize.width / 2 + tileSize.width * (i % sideTileCount), winSize.height -startY - tileSize.height / 2 - tileSize.height * (i / sideTileCount));

        
//        [tile createAnimation];
//        CCAnimation *animation= [CCAnimation animation];
//        [animation addSpriteFrameWithFilename:@"fish_01.png"];
//        
//        [animation addSpriteFrameWithFilename:@"fish_02.png"];
//        
//        [animation addSpriteFrameWithFilename:@"fish_03.png"];
//        
//        
//        animation.delayPerUnit = 0.5;
//        
//        animation.loops = -1;
        //tile.animate = [CCAnimate actionWithAnimation:tile.animation];
        //CCAnimation *walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:0.1f ];
//        CCAnimate *animate  = [CCAnimate actionWithAnimation:animation];
//        tile.animate = [[CCRepeatForever actionWithAction:animate] retain];

        
//        CCSprite *tile = [_tileList objectAtIndex:i];
////        tile.Now = i;
//        
//        tile.position = CGPointMake(startX + tileSize.width / 2 + tileSize.width * (i % sideTileCount), winSize.height -startY - tileSize.height / 2 - tileSize.height * (i / sideTileCount));
//        //[tile createAnimation];
//        CCAnimation *animation= [CCAnimation animation];
//        [animation addSpriteFrameWithFilename:@"fish_01.png"];
//        
//        [animation addSpriteFrameWithFilename:@"fish_02.png"];
//        
//        [animation addSpriteFrameWithFilename:@"fish_03.png"];
//        
//        
//        animation.delayPerUnit = 0.5;
//        
//        animation.loops = -1;
//        //tile.animate = [CCAnimate actionWithAnimation:tile.animation];
//        //CCAnimation *walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:0.1f ];
//        CCAnimate *animate  = [CCAnimate actionWithAnimation:animation];
//        [tile runAction:animate];
////        tile.animate = [[CCRepeatForever actionWithAction:animate] retain];
//        [tile setTag:i];
//        [self addChild:tile z:1];
//        [CCCallFunc actionWithTarget:self selector:@selector(stopAni:)];

    }
}

- (void) removeTiles
{
    for (int i = 0; i < _tileList.count; i++) {
        //Tile *tile = [_tileList objectAtIndex:i];
        [self removeChildByTag:i cleanup:YES];
//        [self removeChild:tile cleanup:YES];
        [_tileList removeAllObjects];
    }
}

- (void) NotifyFromNotificationCenter:(NSNotification *)notification
{
    if ([notification.name isEqual:NUM_CLICK]) {

            Tile *tempTile = [notification object];
            if (tempTile.Num == _currentNum) {
                clickedTileCount += 1;
                _currentNum = _currentNum + 1;
                
                if (_currentNum == tileCount) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:GAME_END object:self];


                } else {
                     [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"CountNum-%d", tempTile.Num] object:self];  
                }

            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"AnimationTileNum-%d", tempTile.Num] object:self];
            }


    } else if([notification.name isEqual: GAME_END]) {
        _currentNum = 0;
                    _currentGameCount = _currentGameCount + 1;
        //[self removeTiles];
        if (gameCount >= _currentGameCount) {

             [[NSNotificationCenter defaultCenter] postNotificationName:GAME_RESTART object:self];
            
        } else {
            // TODO 重複を解決
            [self gameOver];
        }
       

    } else if([notification.name isEqualToString:GAME_RESTART]) {
    

    

        
        [self shuffle];
        [self setTiles];
        

    }
    if (tileCount == _currentNum) {
        [[NSNotificationCenter defaultCenter] postNotificationName:GAME_END object:self];
//        [self scheduleUpdate];
    }
}

- (void)shuffle
{
    for (uint i = 0; i < _tileList.count; ++i)
    {
        // Select a random element between i and end of array to swap with.
        int nElements = _tileList.count - i;
        int n = arc4random_uniform(nElements) + i;
        [_tileList exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

// 画像を自己と同じサイズに加工して返します
-(UIImage*) shapingImageNamed:(NSString*)imageNamed
{
	UIImage* resultImage = [UIImage imageNamed:imageNamed];
	
	UIGraphicsBeginImageContext(CGSizeMake(tileWidth, tileHeight));
	[resultImage drawInRect:CGRectMake(0, 0, tileWidth, tileHeight)];
	resultImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return resultImage;
}

-(void) removeAndAddSprite:(ccTime) dt
{
	id batch = [self getChildByTag:kTagSpriteBatchNode];
	id sprite = [batch getChildByTag:kTagSprite5];
    
	[sprite retain];
    
	[batch removeChild:sprite cleanup:NO];
	[batch addChild:sprite z:0 tag:kTagSprite5];
    
	[sprite release];
}

- (void)gameOver {
    // TODO 重複を解決
    for (int i = 0; i < tileCount; i++) {
        Tile *tile = [_tileList objectAtIndex:i];
        [tile setVisible:NO];
    }
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game End !" fontName:@"Marker Felt" fontSize:30];
    CGSize size = [[CCDirector sharedDirector] winSize];
    // position the label on the center of the screen
    // TODO 位置選定が必要
    label.position =  ccp(size.width/2 ,300);
    label.color = ccc3(255, 255, 255);
    
    [CCMenuItemFont setFontName:@"Helvetica-BoldOblique"];
    [CCMenuItemFont setFontSize:30];
    
    CCMenuItemFont *item = [CCMenuItemFont itemWithString:@"Main画面へ" block:^(id sender){
        
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainLayer scene] withColor:ccWHITE]];
        
    }];
    CCMenu *menu = [CCMenu menuWithItems:item, nil];
    menu.position = CGPointMake(size.width/2, 250);
    menu.color = ccc3(255,255,255);
    
    // add the label as a child to this Layer
    [self addChild: label];
    [self addChild: menu];
    
    [apiConnection sendMessage:[NSString stringWithFormat:@"{\"score\":%d}", clickedTileCount]];
}

- (void) decreaseProgressBarFinished:(id)sender {
    
//    [self gameOver];
    
}

- (void) receivedMessageFromAddUpScore:(NSDictionary *)messageDic
{
    
}

- (void) receivedErrorFromAction:(NSString *)message
{
    if ([message isEqualToString:ERROR_ALREADY_FIGHTING]) {
        // TODO すでに敵
    } else if([message isEqualToString:ERROR_NO_LOGIN]) {
        // TODO ログインされてない状態
    }
    
}

@end
