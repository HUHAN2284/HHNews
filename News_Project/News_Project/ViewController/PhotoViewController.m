//
//  PhotoViewController.m
//  News_Project
//
//  Created by MS on 15/8/18.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import "PhotoViewController.h"
#import "HttpRequestBlock.h"
#import "PhotoModel.h"

#import "HMPhotoCell.h"

#import "HMWaterflowView.h"
#import "Photo2ViewController.h"
#import "MJRefresh.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface PhotoViewController ()<HMWaterflowViewDataSource,HMWaterflowViewDelegate>
{
    HMWaterflowView *_waterflowView;
    NSInteger page;
    BOOL isUpDate;
    
    AppDelegate *app;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWaterflowView];
    [self loadData];
    
    // 消除菊花
    app = [UIApplication sharedApplication].delegate;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    [MBProgressHUD hideHUDForView:app.window animated:YES];
    [_waterflowView reloadData];
    // Do any additional setup after loading the view.
}

- (void)loadData
{
    NSString *listUrl = [NSString stringWithFormat:@"http://lifeweeker3.cms.palmtrends.com/api_v2.php?action=piclist&sa=tupian&offset=%ld&count=10&uid=13836621",page*10+1];
    
    HttpRequestBlock *request = [[HttpRequestBlock alloc] initWithUrlStr:listUrl Block:^(HttpRequestBlock *http, BOOL isSucceed) {
        
        if (isSucceed) {
            if (self.dataArray == nil) {
                self.dataArray = [NSMutableArray array];
            }else{
                if (page == 0) {
                    self.dataArray = [NSMutableArray array];
                }
            }
            
            NSMutableArray *array = [NSMutableArray arrayWithArray:http.dataDic[@"list"]];
            for (NSDictionary *dic in array) {
                PhotoModel *model = [[PhotoModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                
                [self.dataArray addObject:model];
                
            }
//            [_waterflowView reloadData];
            [_waterflowView reloadData];
            
        }
        [_waterflowView.header endRefreshing];
        [_waterflowView.footer endRefreshing];
        isUpDate = NO;
    }];
}

- (void)createWaterflowView
{
    _waterflowView = [[HMWaterflowView alloc] init];
    _waterflowView.backgroundColor = [UIColor whiteColor];
    
    _waterflowView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-49-59);
    _waterflowView.dataSource = self;
    _waterflowView.delegate = self;
    [self.view addSubview:_waterflowView];
    
    [_waterflowView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    [_waterflowView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    
}
-(void)headRefresh
{
    if (isUpDate == NO) {
        isUpDate = !isUpDate;
        page = 0;
        [self loadData];
    }
}
-(void)footerRefresh
{
    if (isUpDate == NO) {
        isUpDate = !isUpDate;
        page ++;
        [self loadData];
    }
}


#pragma mark -HMWaterflowViewDelegate
- (NSUInteger)numberOfCellsInWaterflowView:(HMWaterflowView *)waterflowView
{
    return self.dataArray.count;
}
- (HMWaterflowViewCell *)waterflowView:(HMWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index
{
    HMPhotoCell *cell = [HMPhotoCell cellWithWaterflowView:waterflowView];
    
    cell.model = self.dataArray[index];
    
    return cell;
}

- (CGFloat)waterflowView:(HMWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index
{
    PhotoModel *model= self.dataArray[index];
    // 根据cell的宽度 和 图片的宽高比 算出 cell的高度
    if (index%2 == 0) {
        return 200;
    }
    return 160;
}

- (void)waterflowView:(HMWaterflowView *)waterflowView didSelectAtIndex:(NSUInteger)index
{
    PhotoModel *model = self.dataArray[index];
    
    Photo2ViewController *vc = [[Photo2ViewController alloc] init];
    vc.photo2_id = model.gid;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
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
