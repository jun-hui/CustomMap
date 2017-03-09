//
//  BaseMapView.m
//  CustomMap
//
//  Created by 小王 on 2017/1/20.
//  Copyright © 2017年 小王. All rights reserved.
//

#import "BaseMapView.h"
#import "SVAnnotation.h"
#import "SVPulsingAnnotationView.h"
#import <BaiduMapAPI_Search/BMKPoiSearch.h>

@implementation BaseMapView

{
    CLLocation *_userLocation;
    NSString *_addressString;
    UIButton *_locationButton;
//    BOOL locationMyAddress;
    float _mapZoomLevel;
}

static BMKMapView *_mapView;
       BMKLocationService* _locService;
       BMKGeoCodeSearch *_searcher;
       float leftLeading = 15;

//这个方法会在 第一次初始化这个类之前 被调用，我们用它来初始化静态变量
//+ initialize 的调用发生在 +init 方法之前。
+ (void)initialize {
    //设置自定义地图样式，会影响所有地图实例
    //注：必须在BMKMapView对象初始化之前调用
    NSString* path = [[NSBundle mainBundle] pathForResource:@"custom_config_清新蓝" ofType:@""];
    [BMKMapView customMapStyle:path];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = whiteColor;
        [self addMapView];
        [self setSubviews];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = whiteColor;
        [self addMapView];
        [self setSubviews];
    }
    return self;
}

-(void)viewWillDeleget {
    
    [_mapView viewWillAppear];
    [BMKMapView enableCustomMapStyle:YES];//关闭个性化地图
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _searcher.delegate = self;
}

-(void)viewWillDisDeleget {
    
    [_mapView viewWillDisappear];
    [BMKMapView enableCustomMapStyle:NO];//关闭个性化地图
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _searcher.delegate = nil;
}

-(void)addMapView
{
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self insertSubview:_mapView atIndex:0];
    
    [self addLocation];
    [self setMapView];
}

-(void)setSubviews
{
    NSArray *imageArray = @[@"加",@"减"];
    CustomVerticalSegmentedControl *segmentControl = [[CustomVerticalSegmentedControl alloc]initWithFrame:CGRectMake(leftLeading, 360, 35, 35*2) titleArray:nil imageArray:imageArray];
    segmentControl.segmentDelegate = self;
    [self addSubview:segmentControl];
}

-(void)changeSegmentSelected:(UIButton *)segmentButton index:(NSInteger)index
{
    if (index == 0) {
        
        [_mapView zoomIn];
    }
    if (index == 1) {
        
        [_mapView zoomOut];
    }
}

- (IBAction)locationButtonBackGroundHighlighted:(UIButton *)sender
{
    sender.backgroundColor = lightGrayColor;
}
-(IBAction)location:(UIButton *)locationButton
{
    [_locService startUserLocationService];
    
    locationButton.backgroundColor = whiteColor;
    [UIView animateWithDuration:1.0 animations:^{
        
        [_mapView setCenterCoordinate:_userLocation.coordinate animated:YES];
    }];
//    locationMyAddress = NO;
}

-(void)addLocation
{
    _locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
    _locService.distanceFilter = 50;//定位的最小更新距离(米)
}

-(void)setMapView
{
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = 0;//设置定位的状态
    _mapView.showMapScaleBar = YES;//是否显式比例尺
    _mapView.mapScaleBarPosition = CGPointMake(leftLeading, ScreenHeight - 60);// 比例尺的位置
//     _mapView.showsUserLocation = YES;//显示定位图层
    
    //用户位置类
    BMKLocationViewDisplayParam *param = [[BMKLocationViewDisplayParam alloc]init];
    param.locationViewOffsetY = 0;//偏移量
    param.locationViewOffsetX = 0;
    param.isAccuracyCircleShow = NO;//设置是否显示定位的那个精度圈
    param.isRotateAngleValid = YES;//跟随态旋转角度是否生效
    param.locationViewImgName = @"icon_center_point@2x.png";
    [_mapView updateLocationViewWithParam:param];
    
    _mapZoomLevel = 19;
    _mapView.zoomLevel = _mapZoomLevel;//设置地图缩放级别（3-21级）
    //设置地图中心为屏幕中心
    [_mapView setMapCenterToScreenPt:ScreenCenter];
}

/**
 * 在地图 View 将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser
{
    NSLog(@"开始定位");
}

/**
 * 用户方向更新后，会调用此函数
 * @param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
}

/**
 * 用户位置更新后，会调用此函数
 * @param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"位置更新了：lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    _userLocation = userLocation.location;
    
    [self searchAddressOfCoordinate2D:userLocation.location.coordinate];
    
    //动态更新我的位置数据
    [_mapView updateLocationData:userLocation];
    
    //设定地图中心点坐标
    [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    SVAnnotation *annotation = [[SVAnnotation alloc] initWithCoordinate:userLocation.location.coordinate];
    annotation.title = @"Current Location";
    annotation.subtitle = @"Montréal, QC";
    
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView addAnnotation:annotation];
    
//    locationMyAddress = YES;
}

//自定义泡泡
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if([annotation isKindOfClass:[SVAnnotation class]]) {
        static NSString *identifier = @"currentLocation";
        SVPulsingAnnotationView *pulsingView = (SVPulsingAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if(pulsingView == nil) {
            pulsingView = [[SVPulsingAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            pulsingView.annotationColor = UIColorFromRGB(0x006FEF);
            pulsingView.canShowCallout = YES;
        }
        
        return pulsingView;
    }
    return nil;
}

//反向地理编码
-(void)searchAddressOfCoordinate2D:(CLLocationCoordinate2D)coordinate2D
{
    //初始化检索对象
    _searcher = [[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    
    //发起反向地理编码检索
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
    BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = coordinate2D;
    
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];

    if(flag)
    {
      NSLog(@"反geo检索发送成功");
    }
    else
    {
      NSLog(@"反geo检索发送失败");
    }
}

//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result: (BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
  if (error == BMK_SEARCH_NO_ERROR) {
      //在此处理正常结果
      BMKAddressComponent *addressDetail = result.addressDetail;
      
      NSString *address = result.address;
      NSString *businessCircle = result.businessCircle;
      NSString *sematicDescription = result.sematicDescription;
      
      NSString *district = addressDetail.district;
      NSString *streetName = addressDetail.streetName;
      
      _addressString = streetName;
      
      if (self.addressBlock) {
          self.addressBlock(_addressString);
      }
      NSLog(@"address:%@,businessCircle:%@,sematicDescription:%@,district:%@,streetName:%@",address,businessCircle,sematicDescription,district,streetName);
      
      NSString *adjfio = [NSString stringWithFormat:@"您现在的位置在%@",sematicDescription];
      [self setBaiduTTSWithText:adjfio];
      
//      NSArray *poiList = result.poiList;
//      for (int i = 0; i < poiList.count; i ++) {
//          BMKPoiInfo *poiInfo = poiList[i];
//          
//          NSString *name = poiInfo.name;///<POI名称
//          NSString *uid = poiInfo.uid;
//          NSString *address2 = poiInfo.address;///<POI地址
//          NSString *city = poiInfo.city;///<POI所在城市
//          NSString *phone = poiInfo.phone;///<POI电话号码
//          NSString *postcode = poiInfo.postcode;///<POI邮编
//          int epoitype = poiInfo.epoitype;///<POI类型，0:普通点 1:公交站 2:公交线路 3:地铁站 4:地铁线路
//          
//          NSLog(@"name:%@,uid:%@,address2:%@,city:%@,phone:%@,postcode:%@,epoitype:%d",name,uid,address2,city,phone,postcode,epoitype);
//      }
  }
  else {
      NSLog(@"抱歉，未找到结果:%u",error);
  }
}

//正向地理编码
-(void)searchAddressOfCity:(NSString *)city address:(NSString *)address
{
    //初始化检索对象
    _searcher = [[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geoCodeSearchOption.city = city;
    geoCodeSearchOption.address = address;
    
    BOOL flag = [_searcher geoCode:geoCodeSearchOption];

    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
}

//接收正向编码结果
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
    }
    else {
        NSLog(@"抱歉，未找到结果:%u",error);
    }
}



/**
 * 在地图 View 停止定位后，会调用此函数
 */
- (void)didStopLocatingUser
{
    NSLog(@"停止定位了");
}

-(void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    NSLog(@"定位完成");
    
    for (UIView *mapSubView in [[mapView subviews][0] subviews]) {
        
        if ([mapSubView isKindOfClass:NSClassFromString(@"TapDetectingView")]) {
            for (UIView *SubView in [mapSubView subviews]) {
                
                if ([SubView isKindOfClass:NSClassFromString(@"LocationView")]) {
                    NSLog(@"%@",NSStringFromCGRect(SubView.frame));
                }
            }
        }
    }
}

/**
 * 定位失败后，会调用此函数
 * @param error 错误号，参考 CLError.h 中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"定位失败：%ld",(long)error.code);
}



# pragma mark -- 初始化百度语音
-(void)setBaiduTTSWithText:(NSString *)text
{
    // 获得合成器实例
    [[BDSSpeechSynthesizer sharedInstance] setSynthesizerDelegate:self];
    
    // 设置委托对象
    [[BDSSpeechSynthesizer sharedInstance] setSynthesizerDelegate:self];
    
    // 开始合成并播放
    NSError* speakError = nil;
    NSInteger errorCode = [[BDSSpeechSynthesizer sharedInstance] speakSentence:text withError:&speakError];
    if(errorCode == -1){
        // 错误
        NSLog(@"错误: %ld, %@", (long)speakError.code, speakError.localizedDescription);
    }
}

# pragma mark -- 百度语音代理方法
- (void)synthesizerStartWorkingSentence:(NSInteger)SynthesizeSentence
{
    NSLog(@"开始合成：%ld", (long)SynthesizeSentence);
}

- (void)synthesizerFinishWorkingSentence:(NSInteger)SynthesizeSentence
{
    NSLog(@"合成完毕：%ld", (long)SynthesizeSentence);
}

- (void)synthesizerSpeechStartSentence:(NSInteger)SpeakSentence
{
    NSLog(@"开始播放语音：%ld", (long)SpeakSentence);
}

- (void)synthesizerSpeechEndSentence:(NSInteger)SpeakSentence
{
    NSLog(@"播放语音完成：%ld", (long)SpeakSentence);
}





- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

@end
