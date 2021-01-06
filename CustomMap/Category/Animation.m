//
//  Animation.m
//  CustomMap
//
//  Created by 小王 on 2017/2/7.
//  Copyright © 2017年 小王. All rights reserved.
//

#import "Animation.h"

NSString * const AnimationTypeOfFade                      =      @"Fade";
NSString * const AnimationTypeOfPush                      =      @"Push";
NSString * const AnimationTypeOfReveal                    =      @"Reveal";
NSString * const AnimationTypeOfMoveIn                    =      @"MoveIn";
NSString * const AnimationTypeOfCube                      =      @"Cube";
NSString * const AnimationTypeOfSuckEffect                =      @"SuckEffect";
NSString * const AnimationTypeOfOglFlip                   =      @"OglFlip";
NSString * const AnimationTypeOfRippleEffect              =      @"RippleEffect";
NSString * const AnimationTypeOfPageCurl                  =      @"PageCurl";
NSString * const AnimationTypeOfPageUnCurl                =      @"PageUnCurl";
NSString * const AnimationTypeOfCameraIrisHollowOpen      =      @"CameraIrisHollowOpen";
NSString * const AnimationTypeOfCameraIrisHollowClose     =      @"CameraIrisHollowClose";
NSString * const AnimationTypeOfCurlDown                  =      @"CurlDown";
NSString * const AnimationTypeOfCurlUp                    =      @"CurlUp";
NSString * const AnimationTypeOfFlipFromLeft              =      @"FlipFromLeft";

@implementation Animation


NSString * JHAnimationType[] = {
    [Fade]                      =      AnimationTypeOfFade,
    [Push]                      =      AnimationTypeOfPush,
    [Reveal]                    =      AnimationTypeOfReveal,
    [MoveIn]                    =      AnimationTypeOfMoveIn,
    [Cube]                      =      AnimationTypeOfCube,
    [SuckEffect]                =      AnimationTypeOfSuckEffect,
    [OglFlip]                   =      AnimationTypeOfOglFlip,
    [RippleEffect]              =      AnimationTypeOfRippleEffect,
    [PageCurl]                  =      AnimationTypeOfPageCurl,
    [PageUnCurl]                =      AnimationTypeOfPageUnCurl,
    [CameraIrisHollowOpen]      =      AnimationTypeOfCameraIrisHollowOpen,
    [CameraIrisHollowClose]     =      AnimationTypeOfCameraIrisHollowClose,
    [CurlDown]                  =      AnimationTypeOfCurlDown,
    [CurlUp]                    =      AnimationTypeOfCurlUp,
    [FlipFromLeft]              =      AnimationTypeOfFlipFromLeft,
};

@end
