//
//  ListViewController.m
//  News_Project
//
//  Created by MS on 15/8/17.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import "ListViewController.h"
#import "HttpRequestBlock.h"
#import "ListModel.h"
#import "List2ViewController.h"

#define WEEK @"http://lifeweeker3.cms.palmtrends.com/api_v2.php?action=rank&type=article&level=week&sa=week&offset=0&count=20&uid=13836621&platform=a&mobile=HM+NOTE+1LTE&pid=10022&e=b4ecebb1a582a3179cb095c0d15e7461"
#define MONTH @"http://lifeweeker3.cms.palmtrends.com/api_v2.php?action=rank&type=article&level=month&offset=0&count=20&uid=13836621&platform=a&mobile=HM+NOTE+1LTE&pid=10022&e=b4ecebb1a582a3179cb095c0d15e7461"
#define YEAR @"http://lifeweeker3.cms.palmtrends.com/api_v2.php?action=rank&type=article&level=year&offset=0&count=20&uid=13836621&platform=a&mobile=HM+NOTE+1LTE&pid=10022&e=b4ecebb1a582a3179cb095c0d15e7461"

@interface ListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UIButton *currentBtn;
@property (weak, nonatomic) IBOutlet UITableView *listTableVIew;
@property (weak, nonatomic) IBOutlet UIButton *zhouBtn;
@property (weak, nonatomic) IBOutlet UIButton *yueBtn;
@property (weak, nonatomic) IBOutlet UIButton *nianBtn;


@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ListViewController
- (IBAction)zhouBtn:(id)sender {
    
    
    self.currentBtn.selected = NO;
    self.zhouBtn.selected = YES;
    self.currentBtn = self.zhouBtn;
    
    [self loadDataWithUrl:WEEK];
}
- (IBAction)yueBtn:(id)sender {
    
    self.currentBtn.selected = NO;
    self.yueBtn.selected = YES;
    self.currentBtn = self.yueBtn;
    
    [self loadDataWithUrl:MONTH];
}
- (IBAction)nianBtn:(id)sender {
    self.currentBtn.selected = NO;
    self.nianBtn.selected = YES;
    self.currentBtn = self.nianBtn;
    
    [self loadDataWithUrl:YEAR];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.currentBtn = self.zhouBtn;
//    [self zhouBtn];
    [self loadDataWithUrl:WEEK];
}


- (void)loadDataWithUrl:(NSString *)url
{

    
    HttpRequestBlock *request = [[HttpRequestBlock alloc] initWithUrlStr:url Block:^(HttpRequestBlock *http, BOOL isSucceed) {
        
        if (isSucceed) {
//            if (self.dataArray == nil) {
                self.dataArray = [NSMutableArray array];
//            }
            
            NSMutableArray *array = [NSMutableArray arrayWithArray:http.dataDic[@"list"]];
            for (NSDictionary *dic in array) {
                ListModel *model = [[ListModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                model.list_id = dic[@"id"];
                
                [self.dataArray addObject:model];
                
            }
            [_listTableVIew reloadData];
        }
        
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
    ListModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld.%@", (long)indexPath.row+1, model.title];
    if (indexPath.row <3) {
        cell.textLabel.textColor = [UIColor redColor];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ListModel *model = self.dataArray[indexPath.row];
    List2ViewController *vc = [[List2ViewController alloc] init];
    vc.list2_id = model.list_id;
    
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
