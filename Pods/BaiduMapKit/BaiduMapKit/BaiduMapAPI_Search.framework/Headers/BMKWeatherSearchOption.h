//
//  BMKWeatherSearchOption.h
//  BaiduMapAPI_Search
//
//  Created by Baidu on 2020/4/30.
//  Copyright © 2020 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <BaiduMapAPI_Base/BMKTypes.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *开通高级权限： http://lbsyun.baidu.com/apiconsole/fankui#?typeOne=产品需求&typeTwo=高级服务
 *国内行政区域编码表：https://mapopen-website-wiki.cdn.bcebos.com/cityList/weather_district_id.csv
 *海外行政区域编码表：https://mapopen-website-wiki.cdn.bcebos.com/cityList/weather_aboard_district_id.xlsx
 *天气取值对照表：https://mapopen-website-wiki.cdn.bcebos.com/cityList/百度地图天气取值对照表(0410).xlsx
*/
@interface BMKWeatherSearchOption : NSObject
/// 必选。区县的行政区划编码，和location二选一
@property (nonatomic, copy) NSString *districtID;
/// 必选。经纬度，高级字段，需要申请高级权限
@property (nonatomic, assign) CLLocationCoordinate2D location;
/// 可选。天气服务类型，默认国内
@property (nonatomic, assign) BMKWeatherServerType serverType;
/// 可选。请求数据类型，默认：BMKWeatherDataTypeNow
@property (nonatomic, assign) BMKWeatherDataType dataType;
/// 可选。语言类型，默认中文。目前仅支持海外天气服务行政区划显示英文。
@property (nonatomic, assign) BMKLanguageType languageType;
@end

NS_ASSUME_NONNULL_END
