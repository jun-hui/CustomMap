//
//  BMKWeatherSearch.h
//  BaiduMapAPI_Search
//
//  Created by Baidu on 2020/4/30.
//  Copyright © 2020 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMKWeatherSearchOption.h"
#import <BaiduMapAPI_Base/BMKTypes.h>
#import "BMKSearchBase.h"
#import "BMKWeatherSearchResult.h"
NS_ASSUME_NONNULL_BEGIN
@protocol BMKWeatherSearchDelegate;
/// weather搜索服务
@interface BMKWeatherSearch : BMKSearchBase

/// 检索模块的Delegate
@property (nonatomic, weak) id<BMKWeatherSearchDelegate> delegate;

/**
 *weather检索
 *@param weatherSearchOption      weather检索信息类
 *异步函数，返回结果在BMKWeatherSearchDelegate的onGetWeatherResult通知
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)weatherSearch:(BMKWeatherSearchOption *)weatherSearchOption;
@end

///搜索delegate，用于获取搜索结果
@protocol BMKWeatherSearchDelegate <NSObject>
@optional
/**
 *返回Weather搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetWeatherResult:(BMKWeatherSearch *)searcher result:(BMKWeatherSearchResult *)result errorCode:(BMKSearchErrorCode)error;

@end

NS_ASSUME_NONNULL_END
