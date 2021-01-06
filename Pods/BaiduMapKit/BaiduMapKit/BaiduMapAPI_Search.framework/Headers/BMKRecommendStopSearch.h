//
//  BMKRecommendStopSearch.h
//  BaiduMapAPI_Search
//
//  Created by Baidu on 2020/7/27.
//  Copyright © 2020 Baidu. All rights reserved.
//

#import "BMKSearchBase.h"
#import <BaiduMapAPI_Base/BMKTypes.h>
#import "BMKRecommendStopSearchOption.h"
#import "BMKRecommendStopSearchResult.h"

@protocol BMKRecommendStopSearchDelegate;
NS_ASSUME_NONNULL_BEGIN

/// 推荐上车点检索服务
@interface BMKRecommendStopSearch : BMKSearchBase


/// 推荐上车点检索模块的Delegate
@property (nonatomic, weak) id<BMKRecommendStopSearchDelegate> delegate;


/// 推荐上车点检索
/// @param recommendStopOption 推荐上车点检索信息类
/// @return 成功返回YES，否则返回NO
- (BOOL)recommendStopSearch:(BMKRecommendStopSearchOption *)recommendStopOption;

@end

///搜索delegate，用于获取搜索结果
@protocol BMKRecommendStopSearchDelegate<NSObject>
@optional

/// 推荐上车点检索结果回调
/// @param searcher 搜索对象
/// @param recommendStopResult  搜索结果
/// @param errorCode  错误号，@see BMKSearchErrorCode
- (void)onGetRecommendStopResult:(BMKRecommendStopSearch *)searcher
                          result:(BMKRecommendStopSearchResult *)recommendStopResult
                       errorCode:(BMKSearchErrorCode)errorCode;

@end

NS_ASSUME_NONNULL_END
