//
//  UIViewController+animation.h
//  CustomMap
//
//  Created by 小王 on 2017/2/7.
//  Copyright © 2017年 小王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (animation)

-(void)pushToViewController:(UIViewController *)viewController animation:(NSString *)animationName;

-(void)presentToViewController:(UIViewController *)viewController animation:(NSString *)animationName completion:(void (^ __nullable)(void))completion;

@end
