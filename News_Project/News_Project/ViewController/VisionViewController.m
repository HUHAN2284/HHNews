//
//  VisionViewController.m
//  News_Project
//
//  Created by MS on 15/8/18.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import "VisionViewController.h"
#import "PhotoViewController.h"
#import "SCNavTabBarController.h"
#import "VideoViewController.h"
@interface VisionViewController ()

@end

@implementation VisionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self scNav];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scNav
{
    PhotoViewController *oneViewController = [[PhotoViewController alloc] init];
    oneViewController.title = @"图片";
    oneViewController.view.backgroundColor = [UIColor brownColor];
    
    VideoViewController *twoViewController = [[VideoViewController alloc] init];
    twoViewController.title = @"视频";
    twoViewController.view.backgroundColor = [UIColor purpleColor];
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[oneViewController, twoViewController];
    navTabBarController.showArrowButton = NO;
    [navTabBarController addParentController:self];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
