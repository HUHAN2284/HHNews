//
//  HomePage2ViewController.m
//  News_Project
//
//  Created by MS on 15/8/15.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import "HomePage2ViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
@interface HomePage2ViewController ()<UIWebViewDelegate>
{
    AppDelegate *app;
    UIWebView *_wv;
}
@end

@implementation HomePage2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createWebView];
    // Do any additional setup after loading the view.
}

- (void)createWebView
{
    app = [UIApplication sharedApplication].delegate;
    
    _wv = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _wv.delegate = self;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://lifeweeker3.cms.palmtrends.com/api_v2.php?action=article&id=%@&fontsize=m&mode=day&uid=13836621&e=b4ecebb1a582a3179cb095c0d15e7461&platform=a&pid=10022&mobile=HM+NOTE+1LTE&picMode=show&nextTitle=hide", self.hp2_id]];
    // 菊花
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    [MBProgressHUD showHUDAddedTo:_wv animated:YES];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_wv loadRequest:request];
    
    [self.view addSubview:_wv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark **UIWebViewDelegate**
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
//    NSLog(@"请求结束");
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    [MBProgressHUD hideHUDForView:_wv animated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    [MBProgressHUD hideHUDForView:_wv animated:YES];
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
