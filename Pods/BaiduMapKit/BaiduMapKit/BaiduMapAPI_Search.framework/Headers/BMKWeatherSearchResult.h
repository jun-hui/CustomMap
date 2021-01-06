//
//  BMKWeatherSearchResult.h
//  BaiduMapAPI_Search
//
//  Created by Baidu on 2020/4/30.
//  Copyright © 2020 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class BMKWeatherSearchNow, BMKWeatherSearchLocation, BMKWeatherSearchForecastForHours, BMKWeatherSearchForecasts, BMKWeatherSearchIndexes, BMKWeatherSearchAlerts;

/// 注意：天气服务高级字段，需要申请高级权限 http://lbsyun.baidu.com/apiconsole/fankui#?typeOne=产品需求&typeTwo=高级服务
@interface BMKWeatherSearchResult : NSObject
/// 天气实况数据
@property (nonatomic, strong) BMKWeatherSearchNow *realTimeWeather;
/// 地理位置信息
@property (nonatomic, strong) BMKWeatherSearchLocation *location;
/// 未来5天预报数据
@property (nonatomic, strong) NSArray <BMKWeatherSearchForecasts *> *forecasts;
/// 未来24小时逐小时预报，高级字段
@property (nonatomic, strong) NSArray <BMKWeatherSearchForecastForHours *> * forecastHours;
/// 生活指数数据，高级字段
@property (nonatomic, strong) NSArray <BMKWeatherSearchIndexes *> * lifeIndexes;
/// 气象预警数据，高级字段
@property (nonatomic, strong) NSArray <BMKWeatherSearchAlerts *> * weatherAlerts;

@end

@interface BMKWeatherSearchNow : NSObject
/// 相对湿度(%)
@property (nonatomic, assign) NSInteger relativeHumidity;
/// 体感温度(℃)
@property (nonatomic, assign) NSInteger sensoryTemp;
/// 天气现象
@property (nonatomic, copy) NSString *phenomenon;
/// 风向描述
@property (nonatomic, copy) NSString *windDirection;
/// 数据更新时间，北京时间
@property (nonatomic, copy) NSString *updateTime;
/// 温度（℃）
@property (nonatomic, assign) NSInteger temperature;
/// 风力等级
@property (nonatomic, copy) NSString *windPower;
/// 云量(%)，高级字段
@property (nonatomic, assign) NSInteger clouds;
/// 1小时累计降水量(mm)，高级字段
@property (nonatomic, assign) float hourlyPrecipitation;
/// 能见度(m)，高级字段
@property (nonatomic, assign) NSInteger visibility;
/// 臭氧浓度(μg/m3)，高级字段，仅国内支持
@property (nonatomic, assign) NSInteger O3;
/// pm2.5浓度(μg/m3)，高级字段，仅国内支持
@property (nonatomic, assign) NSInteger PM2_5;
/// 二氧化氮浓度(μg/m3)，高级字段，仅国内支持
@property (nonatomic, assign) NSInteger NO2;
/// 二氧化硫浓度(μg/m3)，高级字段，仅国内支持
@property (nonatomic, assign) NSInteger SO2;
/// 空气质量指数数值，高级字段，仅国内支持
@property (nonatomic, assign) NSInteger airQualityIndex;
/// pm10浓度(μg/m3)，高级字段，仅国内支持
@property (nonatomic, assign) NSInteger PM10;
/// 一氧化碳浓度(mg/m3)，高级字段，仅国内支持
@property (nonatomic, assign) float CO;

@end

@interface BMKWeatherSearchLocation : NSObject
/// 国家名称
@property (nonatomic, copy) NSString *country;
/// 省份名称
@property (nonatomic, copy) NSString *province;
/// 城市名称
@property (nonatomic, copy) NSString *city;
/// 区县名称
@property (nonatomic, copy) NSString *districtName;
/// 区县id
@property (nonatomic, copy) NSString *districtID;

@end

@interface BMKWeatherSearchForecasts : NSObject
/// 日期，北京时区
@property (nonatomic, copy) NSString *date;
/// 星期，北京时区
@property (nonatomic, copy) NSString *week;
/// 最低温度(℃)
@property (nonatomic, assign) NSInteger lowestTemp;
/// 最高温度(℃)
@property (nonatomic, assign) NSInteger highestTemp;
/// 白天风力
@property (nonatomic, copy) NSString *windPowerDay;
/// 晚上风力
@property (nonatomic, copy) NSString *windPowerNight;
/// 白天风向
@property (nonatomic, copy) NSString *windDirectionDay;
/// 晚上风向
@property (nonatomic, copy) NSString *windDirectionrNight;
/// 白天天气现象
@property (nonatomic, copy) NSString *phenomenonDay;
/// 晚上天气现象
@property (nonatomic, copy) NSString *phenomenonNight;
/// 空气质量指数数值，高级字段
@property (nonatomic, assign) NSInteger airQualityIndex;

@end

@interface BMKWeatherSearchIndexes : NSObject
/// 生活指数中文名称，高级字段
@property (nonatomic, copy) NSString *name;
/// 生活指数概要说明，高级字段
@property (nonatomic, copy) NSString *brief;
/// 生活指数详细说明，高级字段
@property (nonatomic, copy) NSString *detail;

@end

@interface BMKWeatherSearchForecastForHours : NSObject
/// 相对湿度(%)，高级字段
@property (nonatomic, assign) NSInteger relativeHumidity;
/// 数据时间，高级字段
@property (nonatomic, copy) NSString *dataTime;
/// 风向描述，高级字段
@property (nonatomic, copy) NSString *windDirection;
/// 风力等级，高级字段
@property (nonatomic, copy) NSString *windPower;
/// 温度(℃)，高级字段
@property (nonatomic, assign) NSInteger temperature;
/// 云量(%)，高级字段
@property (nonatomic, assign) NSInteger clouds;
/// 天气现象，高级字段
@property (nonatomic, copy) NSString *phenomenon;
/// 1小时累计降水量(mm)，高级字段
@property (nonatomic, assign) NSInteger hourlyPrecipitation;

@end

@interface BMKWeatherSearchAlerts : NSObject
/// 预警事件类型，高级字段
@property (nonatomic, copy) NSString *type;
/// 预警事件等级，高级字段
@property (nonatomic, copy) NSString *level;
/// 预警标题，高级字段
@property (nonatomic, copy) NSString *title;
/// 预警详细提示信息，高级字段
@property (nonatomic, copy) NSString *desc;

@end


NS_ASSUME_NONNULL_END
