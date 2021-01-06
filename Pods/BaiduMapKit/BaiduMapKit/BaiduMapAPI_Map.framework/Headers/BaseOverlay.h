//
//  BaseOverlay.h
//  IphoneCom
//
//  Created by liuzhengui on 12-8-7.
//  Copyright (c) 2012年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapView.h"

@protocol BaseOverlayDelegate;
@interface BaseOverlay : NSObject
{
    BOOL                    _bShow;
    int                     _focusIndex;
}
@property (nonatomic,weak) MapView* mapView;
@property (nonatomic,assign) int focusIndex;
@property (nonatomic,weak) id<BaseOverlayDelegate> delegate;

- (id)initWithMapView:(MapView*)mapView;
- (void)setFocus:(int)index;
- (int)getFocus;
- (void)draw;
- (void)updateLayer;

- (BOOL)isShow;
- (void)show:(BOOL)bShow;
@end

@protocol BaseOverlayDelegate <NSObject>
@end
