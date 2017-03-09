//
//  AppDelegate.m
//  CustomMap
//
//  Created by 小王 on 2017/1/19.
//  Copyright © 2017年 小王. All rights reserved.
//



@interface AnimatedAnnotationView : BMKAnnotationView

@property (nonatomic, strong) UIImageView *imageView;

-(instancetype)initWithFrame:(CGRect)frame annotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;

@end
