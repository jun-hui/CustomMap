//
//  UIViewController+animation.m
//  CustomMap
//
//  Created by 小王 on 2017/2/7.
//  Copyright © 2017年 小王. All rights reserved.
//

#import "UIViewController+animation.h"

@implementation UIViewController (animation)

- (void)pushToViewController:(UIViewController *)viewController animation:(NSString *)animationName
{
    [self setAnimation:animationName];
    
    if (@available(iOS 13.0, *)) {
        
        viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    
    [self.navigationController pushViewController:viewController animated:NO];
}

- (void)presentToViewController:(UIViewController *)viewController animation:(NSString *)animationName completion:(void (^ __nullable)(void))completion
{
    [self setAnimation:animationName];
    
    if (@available(iOS 13.0, *)) {
        
        viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    
    [self presentViewController:viewController animated:NO completion:completion];
}

- (void)setAnimation:(NSString *)animationName
{
    if (!animationName || animationName.length == 0) return;
    
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
}



@end
