//
//  AnimationTile.m
//  NanClickBoom
//
//  Created by Jo Sungbum on 13/03/04.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "AnimationTile.h"


@implementation AnimationTile

//- (void)addToLayer:(CCLayer *)layer {
//    [layer addChild:self];
////    CCAnimation *anim = [CCAnimation animation];
////    CCSprite *frameImage1 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_01.png"].CGImage key:nil];
////    CCSprite *frameImage2 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_02.png"].CGImage key:nil];
////    CCSprite *frameImage3 = [CCSprite spriteWithCGImage:[self shapingImageNamed:@"fish_03.png"].CGImage key:nil];
////    //
////    CCSpriteFrame* frame1 = [CCSpriteFrame frameWithTexture:frameImage1.texture rect:CGRectMake(0,0,super.contentSize.width,super.contentSize.height)];
////    CCSpriteFrame* frame2 = [CCSpriteFrame frameWithTexture:frameImage2.texture rect:CGRectMake(0,0,super.contentSize.width,super.contentSize.height)];
////    CCSpriteFrame* frame3 = [CCSpriteFrame frameWithTexture:frameImage3.texture rect:CGRectMake(0,0,super.contentSize.width,super.contentSize.height)];
////    
////    [anim addSpriteFrame:frame1];
////    
////    [anim addSpriteFrame:frame2];
////    //
////    [anim addSpriteFrame:frame3];
////    
////    anim.delayPerUnit = 0.5;
////    
////    anim.loops = -1;
////    
////    
////    CCAnimate *anite  = [CCAnimate actionWithAnimation:anim];
////    [self runAction:anite];
//    // animation code for your big enemy
//}
//- (void)removeFromLayer:(CCLayer *)layer {
//    [layer removeChild:self];
//    // animation code
//}
//
//// 画像を自己と同じサイズに加工して返します
//-(UIImage*) shapingImageNamed:(NSString*)imageNamed
//{
//	UIImage* resultImage = [UIImage imageNamed:imageNamed];
//	
//	UIGraphicsBeginImageContext(CGSizeMake(super.contentSize.width, super.contentSize.height));
//	[resultImage drawInRect:CGRectMake(0, 0, super.contentSize.width, super.contentSize.height)];
//	resultImage = UIGraphicsGetImageFromCurrentImageContext();
//	UIGraphicsEndImageContext();
//	
//	return resultImage;
//}

@end
