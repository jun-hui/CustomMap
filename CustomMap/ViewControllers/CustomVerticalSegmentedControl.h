//
//  CustomVerticalSegmentedControl.h
//  CustomMap
//
//  Created by 小王 on 2017/1/22.
//  Copyright © 2017年 小王. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomSegmentDelegate <NSObject>
@optional

- (void)changeSegmentSelected:(UIButton *)segmentButton index:(NSInteger)index;

@end

@interface CustomVerticalSegmentedControl : UIControl

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) id<CustomSegmentDelegate> segmentDelegate;

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray;

@end

