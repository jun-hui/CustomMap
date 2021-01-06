//
//  BMKRecommendStopSearchResult.h
//  BaiduMapAPI_Search
//
//  Created by Baidu on 2020/7/27.
//  Copyright © 2020 Baidu. All rights reserved.
//

#import <BaiduMapAPI_Base/BMKTypes.h>

@class BMKRecommendStopInfo;

NS_ASSUME_NONNULL_BEGIN

@interface BMKRecommendStopSearchResult : NSObject

/// 推荐上车点返回结果列表
@property (nonatomic, copy) NSArray<BMKRecommendStopInfo *> *recommendStopInfoList;

@end


@interface BMKRecommendStopInfo : NSObject

/// 推荐上车点名称
@property (nonatomic, copy) NSString *name;

/// 推荐上车点地址
@property (nonatomic, copy) NSString *address;

/// 推荐上车点经纬度
@property (nonatomic, assign) CLLocationCoordinate2D location;

/// 推荐点poi的uid
@property (nonatomic, copy) NSString *uid;

/// 距查找点的距离，单位米
@property (nonatomic, assign) CGFloat distance;

@end

NS_ASSUME_NONNULL_END
