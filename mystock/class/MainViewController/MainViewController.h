//
//  MainViewController.h
//  mystock
//
//  Created by Ryan on 14-5-19.
//  Copyright (c) 2014年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"

@interface MainViewController : UIViewController<ICSDrawerControllerChild,ICSDrawerControllerPresenting>

@property(nonatomic, weak) ICSDrawerController *drawer;

@end
