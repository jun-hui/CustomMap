//
//  BaseMapView.h
//  CustomMap
//
//  Created by 小王 on 2017/1/20.
//  Copyright © 2017年 小王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
@protocol SearchAddressDelegate <NSObject>

- (void)searchWithPlaceName:(NSString *)name coordinate:(CLLocationCoordinate2D)coordinate;

@end

@interface SearchAddressViewController : UIViewController

@property (nonatomic, strong)id<SearchAddressDelegate>searchDelegate;
@property (nonatomic) CLLocationCoordinate2D coordinate2D;
@property (nonatomic, strong) NSString *cityString;
@property (nonatomic, weak) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (nonatomic, weak) IBOutlet UITableView *searchTitleTableView;

@end
