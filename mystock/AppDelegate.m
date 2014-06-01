//
//  AppDelegate.m
//  mystock
//
//  Created by Ryan on 14-5-19.
//  Copyright (c) 2014年 Ryan. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.leftVC = [[LeftViewController alloc] init];
    self.mainVC = [[MainViewController alloc] init];
    
    self.icsDrawerC = [[ICSDrawerController alloc] initWithLeftViewController:_leftVC centerViewController:_mainVC];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = _icsDrawerC;
    
    hasInitDB = [[PersistenceHelper dataForKey:@"hasInitDB"] boolValue];

    if (![[NSFileManager defaultManager] fileExistsAtPath:kDBFilePath]) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:kDBFileName ofType:@""];
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:kDBFilePath error:nil];
    }

    if (!hasInitDB) {
        NSMutableDictionary *sendDataDict = [NSMutableDictionary dictionary];
        //添加默认参数
        [sendDataDict setValue:@"focus_list" forKey:@"m"];
        [sendDataDict setValue:@"0" forKey:@"act"];

        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:apiHost parameters:sendDataDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            DMLog(@"JSON: %@", responseObject);
            if (responseObject == nil || [responseObject objForKey:@"result"] == 0) {
                return;
            }
            
            NSArray *dataArray = [responseObject objForKey:@"data"];
            
            FMDatabase *dbBase = [FMDatabase databaseWithPath:kDBFilePath];
            
            NSString *sql = @"insert into corp_codes (code,name,focus,order_num) values (%@,%@,%d,%d)";
            
            if ([dbBase open]) {
                for (NSDictionary *item in dataArray) {
                    if ([dbBase executeUpdateWithFormat:sql,[item objForKey:@"code"],[item objForKey:@"name"],[[item objForKey:@"focus"] intValue],[[item objForKey:@"order_num"] intValue]]) {
                        DMLog(@"success");
                    }
                }
                
            }
            
            [dbBase close];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            DMLog(@"Error: %@", error);
        }];
    }
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
