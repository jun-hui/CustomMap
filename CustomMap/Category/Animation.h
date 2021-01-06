//
//  Animation.h
//  CustomMap
//
//  Created by 小王 on 2017/2/7.
//  Copyright © 2017年 小王. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const AnimationTypeOfFade;
extern NSString * const AnimationTypeOfPush;
extern NSString * const AnimationTypeOfReveal;
extern NSString * const AnimationTypeOfMoveIn;
extern NSString * const AnimationTypeOfCube;
extern NSString * const AnimationTypeOfSuckEffect;
extern NSString * const AnimationTypeOfOglFlip;
extern NSString * const AnimationTypeOfRippleEffect;
extern NSString * const AnimationTypeOfPageCurl;
extern NSString * const AnimationTypeOfPageUnCurl;
extern NSString * const AnimationTypeOfCameraIrisHollowOpen;
extern NSString * const AnimationTypeOfCameraIrisHollowClose;
extern NSString * const AnimationTypeOfCurlDown;
extern NSString * const AnimationTypeOfCurlUp;
extern NSString * const AnimationTypeOfFlipFromLeft;

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

extern NSString * JHAnimationType[];

@end
