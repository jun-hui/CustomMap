//
//  BaseMapView.h
//  CustomMap
//
//  Created by 小王 on 2017/1/20.
//  Copyright © 2017年 小王. All rights reserved.
//

#import "SearchAddressViewController.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface SearchAddressViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,BMKSuggestionSearchDelegate>
{
    NSMutableArray *addressArray;
    NSString *searchAddress;
    NSArray *nameArray;//地名
    NSMutableArray *districtList;//区/县名
    CLGeocoder *_geocoder;
    NSDictionary *addressDic;
    NSString *endSearchAddress;
    
    BMKGeoCodeSearch *_geoCodeSearch;
    BMKReverseGeoCodeOption *_reverseGeoCodeOption;
}


@end

@implementation SearchAddressViewController

#pragma mark - XF
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIButton *leftView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [leftView sd_setImageWithURL:imageUrl forState:UIControlStateNormal];
    [leftView setImage:[UIImage imageNamed:@"sousuo"] forState:UIControlStateNormal];
    [leftView setTintColor:lightGrayColor];
    [leftView setEnabled:NO];
    
    _searchTextField.leftView = leftView;
    [_searchTextField setBackgroundColor:whiteColor];
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    _searchTextField.delegate = self;
    [_searchTextField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventAllEditingEvents];
    
    [_searchButton.layer setMasksToBounds:YES];
    [_searchButton.layer setCornerRadius:5];
    [_searchButton.layer setBackgroundColor:UIColorFromRGB(0x007AFF).CGColor];

    nameArray = [[NSMutableArray alloc]init];
    _geocoder = [[CLGeocoder alloc]init];
    
    [_searchTitleTableView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    _searchTitleTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _searchTitleTableView.delegate = self;
    _searchTitleTableView.dataSource = self;
}

- (void)textDidChange:(UITextField *)textField{
    
    //初始化检索对象
    BMKSuggestionSearch *_searcher =[[BMKSuggestionSearch alloc]init];
    _searcher.delegate = self;
    BMKSuggestionSearchOption* option = [[BMKSuggestionSearchOption alloc] init];
    option.cityname = self.cityString;
    option.keyword  = textField.text;
    BOOL flag = [_searcher suggestionSearch:option];
    if(flag)
    {
        NSLog(@"建议检索发送成功");
    }
    else
    {
        NSLog(@"建议检索发送失败");
    }
}
//实现Delegate处理回调结果
- (void)onGetSuggestionResult:(BMKSuggestionSearch*)searcher result:(BMKSuggestionResult*)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        districtList = [NSMutableArray array];
        [districtList removeAllObjects];
        //在此处理正常结果
        nameArray = result.keyList;
        NSArray *_cityList = result.cityList;
        NSArray *_districtList = result.districtList;
        for (int i = 0; i < nameArray.count; i ++) {
            NSString *key = nameArray[i];
            NSString *city = _cityList[i];
            NSString *district = _districtList[i];
            NSLog(@"%@,%@,%@",city,district,key);
            district = [district stringByAppendingString:key];
            [districtList addObject:district];
            
            [self.searchTitleTableView reloadData];
        }
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}
//不使用时将delegate设置为 nil
-(void)viewWillDisappear:(BOOL)animated
{
    _geoCodeSearch.delegate = nil;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"endtext = %@",textField.text);
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_searchTextField resignFirstResponder];
}

//- (IBAction)searchBtnClick:(id)sender {
//    if (_searchTextField.text.length > 0) {
//        if ([self.searchDelegate respondsToSelector:@selector(searchWithPlaceName: coordinate:)]) {
//            [self.searchDelegate searchWithPlaceName:_searchTextField.text coordinate:_coordinate2D];
//        }
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defult"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"defult"];
    }
    
    cell.textLabel.text = [nameArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [districtList objectAtIndex:indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *searchName = cell.textLabel.text;
    
    if ([self.searchDelegate respondsToSelector:@selector(searchWithPlaceName: coordinate:)]) {
        
        [self.searchDelegate searchWithPlaceName:searchName coordinate:_coordinate2D];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)goBack:(UIButton *)sender
{
    [self setAnimation:AnimationTypeOfFade];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)search:(UIButton *)sender
{
    
}


@end
