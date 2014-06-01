//
//  SelectionViewController.m
//  mystock
//
//  Created by Ryan on 14-5-19.
//  Copyright (c) 2014年 Ryan. All rights reserved.
//

#import "SelectionViewController.h"

@interface SelectionViewController ()

@end

@implementation SelectionViewController

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
    
    self.view.backgroundColor = [UIColor blueColor];
    
    
    NSMutableDictionary *sendDataDict = [NSMutableDictionary dictionary];
    //添加默认参数
    [sendDataDict setValue:@"focus_list" forKey:@"m"];
//    [sendDataDict setValue:kClientVersion forKey:@"cver"];
//    [sendDataDict setValue:kServerVersion forKey:@"version"];
//    [sendDataDict setValue:kVia forKey:@"via"];
//    [sendDataDict setValue:kUDID forKey:@"uuid"];
//    [sendDataDict setValue:kApp forKey:@"app"];
//    [sendDataDict setValue:kToken forKey:@"token"];
//    
//    [sendDataDict setValue:groupNameStr forKey:@"name"];
//    [sendDataDict setValue:urlStr forKey:@"avatar"];
//    [sendDataDict setValue:gamePkg forKey:@"pkg"];
//    [sendDataDict setValue:@"group_1.jpg" forKey:@"background"];
//    [sendDataDict setValue:gameAppid forKey:@"appid"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:apiHost parameters:sendDataDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DMLog(@"JSON: %@", responseObject);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DMLog(@"Error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
