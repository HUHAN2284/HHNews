//
//  ADViewController.m
//  News_Project
//
//  Created by MS on 15/8/26.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import "ADViewController.h"


@interface ADViewController ()
{
    UIWebView *webV;
}
@end

@implementation ADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWebView];
    // Do any additional setup after loading the view.
}

- (void)createWebView
{
    webV = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"privacy" ofType:@"html"];
    NSURL *url = [[NSURL alloc] initWithString:path];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [webV loadRequest:request];
    [self.view addSubview:webV];
    
    // 3.2s后调到下一个主界面
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"Main"];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
