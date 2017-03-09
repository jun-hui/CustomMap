//
//  BaseMapView.h
//  CustomMap
//
//  Created by 小王 on 2017/1/20.
//  Copyright © 2017年 小王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomVerticalSegmentedControl.h"
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>

typedef void (^searchAddressBlock) (NSString *addressName);

@interface BaseMapView : UIView<BMKMapViewDelegate,BMKLocationServiceDelegate,CustomSegmentDelegate,BMKGeoCodeSearchDelegate,BDSSpeechSynthesizerDelegate>

@property (nonatomic, copy) searchAddressBlock addressBlock;

-(void)viewWillDeleget;
-(void)viewWillDisDeleget;

@end
