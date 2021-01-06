//
//  BMKRecommendStopSearchOption.h
//  BaiduMapAPI_Search
//
//  Created by Baidu on 2020/7/27.
//  Copyright © 2020 Baidu. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMKRecommendStopSearchOption : NSObject

/// 推荐上车点经纬度 （必选）
@property (nonatomic, assign) CLLocationCoordinate2D location;

@end

NS_ASSUME_NONNULL_END
