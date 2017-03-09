//
//  AppDelegate.m
//  CustomMap
//
//  Created by 小王 on 2017/1/19.
//  Copyright © 2017年 小王. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseMapViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) BMKMapManager* mapManager;

@end

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    BaseMapViewController *BaseMapVC = [[BaseMapViewController alloc]init];
//    window.rootViewController = BaseMapVC;
//    [window makeKeyAndVisible];

    [self setBaiduTTS];
    [self startMapManager];
    
    return YES;
}

-(void)setBaiduTTS
{
    [self configureOnlineTTS];
    [self configureOfflineTTS];
}
-(void)configureOnlineTTS{
    // 设置在线引擎
    [[BDSSpeechSynthesizer sharedInstance] setApiKey:@"vRFovcnCtqHeyoeHlRf6KXjv" withSecretKey:@"jrfZM932f7PO87GQlEumsAya8MsifO1f"];
}

-(void)configureOfflineTTS{
    // 设置离线引擎
    NSString* offlineEngineSpeechData = [[NSBundle mainBundle] pathForResource:@"Chinese_Speech_Female" ofType:@"dat"];
    NSString* offlineEngineTextData = [[NSBundle mainBundle] pathForResource:@"Chinese_Text" ofType:@"dat"];
    NSString* offlineEngineEnglishSpeechData = [[NSBundle mainBundle] pathForResource:@"English_Speech_Female" ofType:@"dat"];
    NSString* offlineEngineEnglishTextData = [[NSBundle mainBundle] pathForResource:@"English_Text" ofType:@"dat"];
    NSString* offlineEngineLicenseFile = [[NSBundle mainBundle] pathForResource:@"offline_engine_tmp_license" ofType:@"dat"];

    NSError* err = [[BDSSpeechSynthesizer sharedInstance] loadOfflineEngine:offlineEngineTextData speechDataPath:offlineEngineSpeechData licenseFilePath:offlineEngineLicenseFile withAppCode:nil];
    
    if(err){
        [self displayError:err withTitle:@"离线语音合成初始化失败"];
        return;
    }
//    [TTSConfigViewController setCurrentOfflineSpeaker:OfflineSpeaker_Female];
    err = [[BDSSpeechSynthesizer sharedInstance] loadEnglishDataForOfflineEngine:offlineEngineEnglishTextData speechData:offlineEngineEnglishSpeechData];
    if(err){
        [self displayError:err withTitle:@"加载英文资源失败"];
        return;
    }
}

-(void)displayError:(NSError*)error withTitle:(NSString*)title{
    
    NSString* errMessage = error.localizedDescription;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:errMessage preferredStyle:UIAlertControllerStyleAlert];
    if (alert) {
        UIAlertAction* dismiss = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        }];
        [alert addAction:dismiss];
//        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        
        [DKProgressHUD showErrorWithStatus:errMessage];
    }
}

-(void)startMapManager
{
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"7RAcRRwRvY8y4tLpACaimXYFknq0wIgs" generalDelegate:self];
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
