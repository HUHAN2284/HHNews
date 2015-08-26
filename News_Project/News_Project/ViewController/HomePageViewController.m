//
//  HomePageViewController.m
//  News_Project
//
//  Created by MS on 15/8/15.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import "HomePageViewController.h"
#import "HttpRequestBlock.h"
#import "HomePageModel.h"
#import "UIImageView+WebCache.h"
#import "HPCell.h"
#import "HomePage2ViewController.h"
#import "MJRefresh.h"
@interface HomePageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *HPtableView;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _HPtableView.pagingEnabled = YES;
    [self loadData];
    [self upDate];
    // Do any additional setup after loading the view.
}

- (void)upDate
{
    [_HPtableView addLegendHeaderWithRefreshingBlock:^{
        [self loadData];
    }];
}

- (void)loadData
{
    NSString *url = @"http://lifeweeker3.cms.palmtrends.com/api_v2.php?action=top&height=960&uid=13836621&platform=a&mobile=HM+NOTE+1LTE&pid=10022&e=b4ecebb1a582a3179cb095c0d15e7461";
    HttpRequestBlock *request = [[HttpRequestBlock alloc] initWithUrlStr:url Block:^(HttpRequestBlock *http, BOOL isSucceed) {
        
        if (isSucceed) {
//            if (self.dataArray == nil) {
                self.dataArray = [NSMutableArray array];
//            }
            
            NSMutableArray *array = [NSMutableArray arrayWithArray:http.dataDic[@"list"]];
            for (NSDictionary *dic in array) {
                HomePageModel *model = [[HomePageModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                model.hp_id = dic[@"id"];
                [self.dataArray addObject:model];
            }
            [_HPtableView reloadData];
        }
        [_HPtableView.header endRefreshing];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HPCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
//        cell = [[HPCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HPCell" owner:nil options:nil
                 ]lastObject];
    }
    
    HomePageModel *model = self.dataArray[indexPath.row];
    [cell configModel:model];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return _HPtableView.bounds.size.height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HomePageModel *model = self.dataArray[indexPath.row];
    HomePage2ViewController *vc = [[HomePage2ViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.hp2_id  = model.hp_id;
    
    [self.navigationController pushViewController:vc animated:YES];
    
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
