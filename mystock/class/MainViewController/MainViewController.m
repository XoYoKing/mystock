//
//  MainViewController.m
//  mystock
//
//  Created by Ryan on 14-5-19.
//  Copyright (c) 2014年 Ryan. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.suggestArray = [NSMutableArray array];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationController.navigationBar.barTintColor = NAVI_COLOR;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    titleLabel.font = HEI_(18);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"推荐列表";
    self.navigationItem.titleView = titleLabel;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(back_click:)];
    
    [self request_suggest_list];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Method
- (void)back_click:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOpenDrawer object:nil];
}

- (void)request_suggest_list{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [format stringFromDate:[NSDate date]];
    
    NSMutableDictionary *sendDataDict = [NSMutableDictionary dictionary];
    //添加默认参数
    [sendDataDict setValue:@"get_suggest" forKey:@"m"];
    [sendDataDict setValue:dateStr forKey:@"date"];
    
    BOOL needHUD = [[PersistenceHelper dataForKey:@"hasInitDB"] boolValue];
    if (needHUD) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"推荐ing....";
        [hud hide:YES afterDelay:30];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:apiHost parameters:sendDataDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DMLog(@"JSON: %@", responseObject);
        if (responseObject == nil || [responseObject objForKey:@"result"] == 0) {
            return;
        }
        
        if (needHUD) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DMLog(@"Error: %@", error);
        if (needHUD) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];

}
@end
