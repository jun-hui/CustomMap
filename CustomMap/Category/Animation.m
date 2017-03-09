//
//  Animation.m
//  CustomMap
//
//  Created by 小王 on 2017/2/7.
//  Copyright © 2017年 小王. All rights reserved.
//

#import "Animation.h"

@implementation Animation


NSString * SaleStatusName[] = {
    [Fade]                      =      @"fade",
    [Push]                      =      @"Push",
    [Reveal]                    =      @"Reveal",
    [MoveIn]                    =      @"MoveIn",
    [Cube]                      =      @"Cube",
    [SuckEffect]                =      @"SuckEffect",
    [OglFlip]                   =      @"OglFlip",
    [RippleEffect]              =      @"RippleEffect",
    [PageCurl]                  =      @"PageCurl",
    [PageUnCurl]                =      @"PageUnCurl",
    [CameraIrisHollowOpen]      =      @"CameraIrisHollowOpen",
    [CameraIrisHollowClose]     =      @"CameraIrisHollowClose",
    [CurlDown]                  =      @"CurlDown",
    [CurlUp]                    =      @"CurlUp",
    [FlipFromLeft]              =      @"FlipFromLeft",
};

-(NSString *)animatedTypeName
{
    return SaleStatusName[Fade];
}


@end
