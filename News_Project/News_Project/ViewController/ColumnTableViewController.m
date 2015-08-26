//
//  ColumnTableViewController.m
//  News_Project
//
//  Created by MS on 15/8/15.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import "ColumnTableViewController.h"
#import "HttpRequestBlock.h"
#import "ColumnModel.h"
#import "ColumnCell.h"
#import "Column2TableViewController.h"
#import "MJRefresh.h"
@interface ColumnTableViewController ()
{
    
}
@property (strong, nonatomic) IBOutlet UITableView *columnTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ColumnTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self upDate];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)upDate
{
    [_columnTableView addLegendHeaderWithRefreshingBlock:^{
        [self loadData];
    }];
}
     
     
- (void)loadData
{
    NSString *columnUrl = @"http://lifeweeker3.cms.palmtrends.com/api_v2.php?action=zl&offset=0&count=20&uid=13836621&platform=a&mobile=HM+NOTE+1LTE&pid=10022&e=b4ecebb1a582a3179cb095c0d15e7461";
    HttpRequestBlock *request = [[HttpRequestBlock alloc] initWithUrlStr:columnUrl Block:^(HttpRequestBlock *http, BOOL isSucceed) {
        
        if (isSucceed) {
//            if (self.dataArray == nil) {
                self.dataArray = [NSMutableArray array];
//            }
            
            NSMutableArray *array = [NSMutableArray arrayWithArray:http.dataDic[@"list"]];
            for (NSDictionary *dic in array) {
                
                ColumnModel *model = [[ColumnModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                model.colunmn_id = dic[@"id"];
                [self.dataArray addObject:model];
                
            }
            [_columnTableView reloadData];
        }
        [_columnTableView.header endRefreshing];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ColumnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ColumnCell" forIndexPath:indexPath];
    
    ColumnModel *model = self.dataArray[indexPath.row];
    
    [cell configModel:model];
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ColumnModel *model = self.dataArray[indexPath.row];
    Column2TableViewController *vc = [[Column2TableViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.cp2_id  = model.colunmn_id;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
