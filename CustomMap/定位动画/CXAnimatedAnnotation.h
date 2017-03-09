//
//  AppDelegate.m
//  CustomMap
//
//  Created by 小王 on 2017/1/19.
//  Copyright © 2017年 小王. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface CXAnimatedAnnotation :NSObject <BMKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, strong) NSMutableArray *animatedImages;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
