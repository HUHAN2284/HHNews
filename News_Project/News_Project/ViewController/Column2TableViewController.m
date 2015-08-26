//
//  Column2TableViewController.m
//  News_Project
//
//  Created by MS on 15/8/17.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import "Column2TableViewController.h"
#import "HttpRequestBlock.h"
#import "Column2Model.h"
#import "Column2Cell.h"
#import "Column3ViewController.h"
#import "MJRefresh.h"

@interface Column2TableViewController ()
{
    NSInteger page;
    BOOL isUpDate;
}

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation Column2TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self creatTableView];
    
    [self loadData];
    [self upDate];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)upDate
{
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        if (isUpDate == NO) {
            isUpDate = !isUpDate;
            page = 0;
            [self loadData];
        }
    }];
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        if (isUpDate == NO) {
            isUpDate = !isUpDate;
            page ++;
            [self loadData];
        }
    }];
    
}


- (void)loadData
{
    NSString *columnUrl = [NSString stringWithFormat:@"http://lifeweeker3.cms.palmtrends.com/api_v2.php?action=list&sa=%@&offset=%ld&count=20&uid=13836621", self.cp2_id, page*20+1];
    
    HttpRequestBlock *request = [[HttpRequestBlock alloc] initWithUrlStr:columnUrl Block:^(HttpRequestBlock *http, BOOL isSucceed) {
        
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
                
                Column2Model *model = [[Column2Model alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                model.colunmn2_id = dic[@"id"];
                [self.dataArray addObject:model];
                
            }
            [self.tableView reloadData];
        }
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        isUpDate = NO;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Column2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Column2Cell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Column2Cell" owner:nil options:nil] lastObject];
    }
    
    Column2Model *model = self.dataArray[indexPath.row];
    
    [cell configModel:model];
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    Column2Model *model = self.dataArray[indexPath.row];
    Column3ViewController *vc = [[Column3ViewController alloc] init];
    vc.cp3_id = model.colunmn2_id;
    
    [self.navigationController pushViewController:vc animated:YES];
    
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
