//
//  AppDelegate.m
//  CustomMap
//
//  Created by 小王 on 2017/1/19.
//  Copyright © 2017年 小王. All rights reserved.
//


#import "AnimatedAnnotationView.h"
#import "CXAnimatedAnnotation.h"

#define kWidth          200.f
#define kHeight         200.f
#define kTimeInterval   0.15f

@implementation AnimatedAnnotationView

@synthesize imageView = _imageView;

#pragma mark - Life Cycle

-(instancetype)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame annotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self setBounds:frame];
        [self setBackgroundColor:[UIColor clearColor]];
        
//        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
//        [self addSubview:self.imageView];
    }
    
    return self;
}

#pragma mark - Utility

- (void)updateImageView
{
    CXAnimatedAnnotation *animatedAnnotation = (CXAnimatedAnnotation *)self.annotation;
    
    if ([self.imageView isAnimating])
    {
        [self.imageView stopAnimating];
    }
    
    self.imageView.animationImages      = animatedAnnotation.animatedImages;
    self.imageView.animationDuration    = kTimeInterval * [animatedAnnotation.animatedImages count];
    self.imageView.animationRepeatCount = 0;
    [self.imageView startAnimating];
}

#pragma mark - Override

- (void)setAnnotation:(id<BMKAnnotation>)annotation
{
    [super setAnnotation:annotation];
    
//    [self updateImageView];
    [self setLayerAnimo];
}

-(void)setLayerAnimo
{
    /*--------------- 扩散动画 ---------------*/

    CAShapeLayer *pulseLayer = [CAShapeLayer layer];
    pulseLayer.frame = self.bounds;
    pulseLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
    pulseLayer.fillColor = UIColorFromRGB(0x2EB3FF).CGColor;
    pulseLayer.opacity = 0.0;
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.bounds;
    replicatorLayer.instanceCount = 4;
    replicatorLayer.instanceDelay = 1;
    [replicatorLayer addSublayer:pulseLayer];
    
    [self.layer addSublayer:replicatorLayer];
    
    CABasicAnimation *opacityAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnima.fromValue = @(0.5);
    opacityAnima.toValue = @(0.0);
    
    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scaleAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.animations = @[opacityAnima, scaleAnima];
    groupAnima.duration = 4.0;//动画的时长
    groupAnima.autoreverses = NO;//动画结束时是否执行逆动画
    groupAnima.repeatCount = HUGE;//重复的次数
    [pulseLayer addAnimation:groupAnima forKey:@"groupAnimation"];
    /*---------------------------------------*/
}


@end
