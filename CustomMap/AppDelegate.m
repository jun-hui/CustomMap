//
//  AppDelegate.m
//  CustomMap
//
//  Created by 小王 on 2017/1/19.
//  Copyright © 2017年 小王. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (nonatomic, strong) BMKMapManager *mapManager;

@end

// 填写应用的鉴权信息，请联系我们获取sn
NSString * BD_APP_ID = @"23493060";
NSString * BD_API_KEY = @"sBMx7DLCjUM4TFYETbqe3DEnTmAVoS8V";
NSString * BD_SECRET_KEY = @"Ai7ZmGGI8qUyIIiQF0wFbuHUEZaLDq24";
NSString * TTS_SN = @"97c71bd8-739902ea-0a8f-0053-6818b-00";

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setBaiduTTS];
    [self startMapManager];
    
    return YES;
}

- (void)setBaiduTTS
{
    [self configureOnlineTTS];
    [self configureOfflineTTS];
}
- (void)configureOnlineTTS{
    // FIXME: 真机需要注释掉，不然编译不通过
//    // 设置在线引擎
//    [[BDSSpeechSynthesizer sharedInstance] setApiKey:@"vRFovcnCtqHeyoeHlRf6KXjv" withSecretKey:@"jrfZM932f7PO87GQlEumsAya8MsifO1f"];
}

- (void)configureOfflineTTS{
    // FIXME: 真机需要注释掉，不然编译不通过
//    // 设置离线引擎
//    NSString *offlineEngineSpeechData = [[NSBundle mainBundle] pathForResource:@"Chinese_Speech_Female" ofType:@"dat"];
//    NSString *offlineEngineTextData = [[NSBundle mainBundle] pathForResource:@"Chinese_Text" ofType:@"dat"];
//    NSString *offlineEngineEnglishSpeechData = [[NSBundle mainBundle] pathForResource:@"English_Speech_Female" ofType:@"dat"];
//    NSString *offlineEngineEnglishTextData = [[NSBundle mainBundle] pathForResource:@"English_Text" ofType:@"dat"];
//    NSString *offlineEngineLicenseFile = [[NSBundle mainBundle] pathForResource:@"offline_engine_tmp_license" ofType:@"dat"];
//
//    NSError *err = [[BDSSpeechSynthesizer sharedInstance] loadOfflineEngine:offlineEngineTextData speechDataPath:offlineEngineSpeechData licenseFilePath:offlineEngineLicenseFile withAppCode:nil];
//
//    if(err){
//        NSLog(@"离线语音合成初始化失败"); return;
//    }
//
//    err = [[BDSSpeechSynthesizer sharedInstance] loadEnglishDataForOfflineEngine:offlineEngineEnglishTextData speechData:offlineEngineEnglishSpeechData];
//
//    if(err){
//        NSLog(@"加载英文资源失败"); return;
//    }
}

- (void)startMapManager
{
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:BD_API_KEY generalDelegate:self];
    if (!ret) {
        NSLog(@"百度地图 manager 开启失败!");
    }
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"联网失败 %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"授权失败 %d",iError);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
