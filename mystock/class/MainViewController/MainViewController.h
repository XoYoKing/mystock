//
//  MainViewController.h
//  mystock
//
//  Created by Ryan on 14-5-19.
//  Copyright (c) 2014年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuggestDetailViewController.h"

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *suggestArray;
@property (nonatomic, strong) NSString *dateStr;

@property (nonatomic, strong) UIView *dateView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIToolbar *toolBar;

@property (nonatomic, strong) UITableView *sTableView;

@property (nonatomic, strong) SuggestDetailViewController *sDetailVC;

@end
