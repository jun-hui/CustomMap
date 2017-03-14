//
//  ViewController.m
//  CustomMap
//
//  Created by 小王 on 2017/1/19.
//  Copyright © 2017年 小王. All rights reserved.
//

#import "ViewController.h"
#import "BaseMapView.h"
#import "SearchAddressViewController.h"

@interface ViewController ()<UITextFieldDelegate,SearchAddressDelegate>

@property (nonatomic, weak) IBOutlet BaseMapView *mapView;

@end

@implementation ViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.mapView viewWillDeleget];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.mapView viewWillDisDeleget];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSubViews];
}

-(void)setSubViews
{
    [self.headView setClipsToBounds:false];
    [self.headView.layer setShadowColor:lightGrayColor.CGColor];
    [self.headView.layer setShadowOffset:CGSizeMake(0, 5.0)];
    [self.headView.layer setShadowOpacity:1.0];
    [self.headView.layer setShadowRadius:5.0];
    [self.headView.layer setCornerRadius:5.0];
    
    [self.searchTextFiled setValue:lightGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.searchTextFiled setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.searchTextFiled setDelegate:self];
    self.searchTextFiled.returnKeyType = UIReturnKeySearch;
    [self.searchTextFiled setKeyboardType:UIKeyboardTypeDefault];
    
    self.mapView.addressBlock = ^(NSString *addressName)
    {
        [self setSearchBarTextFiledPlaceText:addressName];
    };
    
    [self.locationButton.layer setMasksToBounds:YES];
    [self.locationButton.layer setBackgroundColor:whiteColor.CGColor];
    [self.locationButton.layer setCornerRadius:5.0];
    [self.locationButton.layer setBorderWidth:0.5];
    [self.locationButton.layer setBorderColor:lightGrayColor.CGColor];
}

-(void)setSearchBarTextFiledPlaceText:(NSString *)address
{
    NSString *placeText = [NSString stringWithFormat:@"在%@附近搜索",address];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:placeText];
    [attrString setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(1, address.length)];
    
    self.searchTextFiled.attributedPlaceholder = attrString;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self pushSearchAddress];
    
    return NO;
}


-(void)pushSearchAddress{
    
    SearchAddressViewController *searchVC = [[SearchAddressViewController alloc]init];
    searchVC.searchDelegate = self;
    [self presentToViewController:searchVC animation:AnimationTypeOfFade completion:^{
        
    }];
}

-(void)searchWithPlaceName:(NSString *)name coordinate:(CLLocationCoordinate2D)coordinate
{
    
}


@end
