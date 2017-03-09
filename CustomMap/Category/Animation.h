//
//  Animation.h
//  CustomMap
//
//  Created by 小王 on 2017/2/7.
//  Copyright © 2017年 小王. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const AnimationTypeOfFade                      =      @"Fade";
static NSString * const AnimationTypeOfPush                      =      @"Push";
static NSString * const AnimationTypeOfReveal                    =      @"Reveal";
static NSString * const AnimationTypeOfMoveIn                    =      @"MoveIn";
static NSString * const AnimationTypeOfCube                      =      @"Cube";
static NSString * const AnimationTypeOfSuckEffect                =      @"SuckEffect";
static NSString * const AnimationTypeOfOglFlip                   =      @"OglFlip";
static NSString * const AnimationTypeOfRippleEffect              =      @"RippleEffect";
static NSString * const AnimationTypeOfPageCurl                  =      @"PageCurl";
static NSString * const AnimationTypeOfPageUnCurl                =      @"PageUnCurl";
static NSString * const AnimationTypeOfCameraIrisHollowOpen      =      @"CameraIrisHollowOpen";
static NSString * const AnimationTypeOfCameraIrisHollowClose     =      @"CameraIrisHollowClose";
static NSString * const AnimationTypeOfCurlDown                  =      @"CurlDown";
static NSString * const AnimationTypeOfCurlUp                    =      @"CurlUp";
static NSString * const AnimationTypeOfFlipFromLeft              =      @"FlipFromLeft";

@interface Animation : NSObject

typedef NS_OPTIONS (NSInteger, animationType) {
    Fade,                     //淡入淡出
    Push,                     //推挤
    Reveal,                   //揭开
    MoveIn,                   //覆盖
    Cube,                     //立方体
    SuckEffect,               //吮吸
    OglFlip,                  //翻转
    RippleEffect,             //波纹
    PageCurl,                 //翻页
    PageUnCurl,               //反翻页
    CameraIrisHollowOpen,     //开镜头
    CameraIrisHollowClose,    //关镜头
    CurlDown,                 //下翻页
    CurlUp,                   //上翻页
    FlipFromLeft              //左翻转
};

@property (nonatomic, strong) NSString *animatedTypeName;


@end
