//
//  Photo2ViewController.m
//  News_Project
//
//  Created by MS on 15/8/20.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import "Photo2ViewController.h"
#import "HttpRequestBlock.h"
#import "Photo2Model.h"
#import "UIImageView+WebCache.h"

#define PHOTO2_URL @"http://lifeweeker3.cms.palmtrends.com/api_v2.php?action=picture&gid=%@&offset=0&count=1000&uid=13836621"
@interface Photo2ViewController ()
{
    UIScrollView *_sv;
}

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation Photo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    // Do any additional setup after loading the view.
}


- (void)loadData
{
    NSString *photoUrl = [NSString stringWithFormat:PHOTO2_URL,self.photo2_id];
    
    HttpRequestBlock *request = [[HttpRequestBlock alloc] initWithUrlStr:photoUrl Block:^(HttpRequestBlock *http, BOOL isSucceed) {
        
        if (isSucceed) {
            if (self.dataArray == nil) {
                self.dataArray = [NSMutableArray array];
            }
            
            NSMutableArray *array = [NSMutableArray arrayWithArray:http.dataArray];
            for (NSDictionary *dic in array) {
                Photo2Model *model = [[Photo2Model alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                model.photo2_id = dic[@"id"];
                
                [self.dataArray addObject:model];
                
            }
            [self createScrollView];
        }
        
    }];
    
}

- (void)createScrollView
{
    _sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _sv.contentSize = CGSizeMake(self.view.frame.size.width*self.dataArray.count, self.view.frame.size.height);
    _sv.pagingEnabled = YES;
    _sv.contentOffset = CGPointZero;
    
    for (int i = 0; i<self.dataArray.count; i++) {
        Photo2Model *model = self.dataArray[i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://lifeweeker3.cms.palmtrends.com/%@",model.icon]]];
        [_sv addSubview:imageView];
    }
    
    [self.view addSubview:_sv];
    
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
