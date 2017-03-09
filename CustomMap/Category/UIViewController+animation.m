//
//  UIViewController+animation.m
//  CustomMap
//
//  Created by 小王 on 2017/2/7.
//  Copyright © 2017年 小王. All rights reserved.
//

#import "UIViewController+animation.h"

@implementation UIViewController (animation)

-(void)pushToViewController:(UIViewController *)viewController animation:(NSString *)animationName
{
    //创建动画
    CATransition *animation = [CATransition animation];
    //设置运动轨迹的速度
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //设置动画类型
    animation.type = animationName;
    //设置动画时长
    animation.duration = 0.3f;
    //控制器间跳转动画
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
    
    [self.navigationController pushViewController:viewController animated:NO];
}

-(void)presentToViewController:(UIViewController *)viewController animation:(NSString *)animationName completion:(void (^ __nullable)(void))completion
{
    //创建动画
    CATransition *animation = [CATransition animation];
    //设置运动轨迹的速度
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //设置动画类型
    animation.type = animationName;
    //设置动画时长
    animation.duration = 0.3f;
    //控制器间跳转动画
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:viewController animated:NO completion:completion];
}



@end
