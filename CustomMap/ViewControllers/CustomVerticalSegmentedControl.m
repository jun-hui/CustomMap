//
//  CustomVerticalSegmentedControl.m
//  CustomMap
//
//  Created by 小王 on 2017/1/22.
//  Copyright © 2017年 小王. All rights reserved.
//

#import "CustomVerticalSegmentedControl.h"

@implementation CustomVerticalSegmentedControl
{
    NSMutableArray *_buttonsArray;
}

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleArray = titleArray.count > 0 ? titleArray : [NSArray array];
        self.imageArray = imageArray.count > 0 ? imageArray : [NSArray array];
        _buttonsArray = [NSMutableArray arrayWithCapacity:0];
        
        [self setItems];
        [self setBorder];
        [self setMyLayer];
    }
    return self;
}

- (void)setItems
{
    float itemWidth = self.frame.size.width;
    int cout = self.titleArray.count > self.imageArray.count ? self.titleArray.count : self.imageArray.count;
    float itemHeight = self.frame.size.height / cout;
    
    UIButton *button;
    for (int i = 0; i < cout; i ++) {
        
        button = [[UIButton alloc]init];
        button.frame = CGRectMake(0, itemHeight *i, itemWidth, itemHeight);
        [button setBackgroundColor:whiteColor];
        if (self.titleArray.count > 0)
            [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        if (self.imageArray.count > 0)
            [button setBackgroundImage:[UIImage imageNamed:self.imageArray[i]] forState:UIControlStateNormal];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(buttonBackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(changeSegmentSelected:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(changeSegmentSelected:) forControlEvents:UIControlEventTouchUpOutside];
        
        if (i > 0) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(5, 0, button.frame.size.width - 10, 0.5)];
            line.backgroundColor = lightGrayColor;
            [button addSubview:line];
        }
        
        [self addSubview:button];
        [_buttonsArray addObject:button];
    }
}

- (void)setBorder
{
    UIButton *firstButton = [_buttonsArray firstObject];
    UIButton *lastButton = [_buttonsArray lastObject];
    
    UIBezierPath *plusMaskPath = [UIBezierPath bezierPathWithRoundedRect:firstButton.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *plusMaskLayer = [[CAShapeLayer alloc] init];
    plusMaskLayer.frame = firstButton.bounds;
    plusMaskLayer.path = plusMaskPath.CGPath;
    firstButton.layer.mask = plusMaskLayer;
    
    UIBezierPath *minusMaskPath = [UIBezierPath bezierPathWithRoundedRect:lastButton.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *minusMaskLayer = [[CAShapeLayer alloc] init];
    minusMaskLayer.frame = lastButton.bounds;
    minusMaskLayer.path = minusMaskPath.CGPath;
    lastButton.layer.mask = minusMaskLayer;
}

- (void)setMyLayer
{
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:5.0];
    [self.layer setBorderWidth:0.5];
    [self.layer setBorderColor:lightGrayColor.CGColor];
}

//  button高亮状态下的背景色
- (void)buttonBackGroundHighlighted:(UIButton *)sender
{
    sender.backgroundColor = lightGrayColor;
}

- (void)changeSegmentSelected:(UIButton *)segmentButton
{
    segmentButton.backgroundColor = whiteColor;
    NSInteger tag = segmentButton.tag - 100;
    [self changeSegmentSelected:segmentButton index:tag];
}

- (void)changeSegmentSelected:(UIButton *)segmentButton index:(NSInteger)index
{
    [_segmentDelegate changeSegmentSelected:segmentButton index:index];
}


@end


