//
//  VideoViewController.m
//  News_Project
//
//  Created by MS on 15/8/19.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import "VideoViewController.h"
#import "HttpRequestBlock.h"
#import "VideoModel.h"
#import "VideoCell.h"
#import "MJRefresh.h"
#import "Video2ViewController.h"
@interface VideoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSInteger page;
    BOOL isUpDate;
}

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createCollectionView];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"VideoCell" bundle:nil] forCellWithReuseIdentifier:@"VideoCell"];
    
    [self loadData];
    // Do any additional setup after loading the view.
}



- (void)loadData
{
    NSString *videoUrl = [NSString stringWithFormat:@"http://lifeweeker3.cms.palmtrends.com/api_v2.php?action=list&sa=shipin&offset=%ld&count=20&uid=13836621", page*20+1];
    
    HttpRequestBlock *request = [[HttpRequestBlock alloc] initWithUrlStr:videoUrl Block:^(HttpRequestBlock *http, BOOL isSceedd) {
        
        if (isSceedd) {
            
            if (self.dataArray == nil) {
                self.dataArray = [NSMutableArray array];
            }else{
                if (page == 0) {
                    self.dataArray = [NSMutableArray array];
                }
            }
            
            NSMutableArray *array = [NSMutableArray arrayWithArray:http.dataDic[@"list"]];
            for (NSDictionary *dic in array) {
                VideoModel *model = [[VideoModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                model.video_id = dic[@"id"];
                [self.dataArray addObject:model];
            }
            [_collectionView reloadData];
        }
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
        isUpDate = NO;
    }];
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-49-59) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_collectionView];
    
    [_collectionView addLegendHeaderWithRefreshingBlock:^{
        if (isUpDate == NO) {
            isUpDate = !isUpDate;
            page = 0;
            [self loadData];
        }
    }];
    [_collectionView addLegendFooterWithRefreshingBlock:^{
        if (isUpDate == NO) {
            isUpDate = !isUpDate;
            page ++;
            [self loadData];
        }
    }];
}

#pragma mark -UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    VideoModel *model = self.dataArray[indexPath.row];
    [cell configModel:model];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.bounds.size.width/2 - 10*2, 170);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 5, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Video2ViewController *vc = [[Video2ViewController alloc] init];
    VideoModel *model = self.dataArray[indexPath.row];
    
    vc.video2_id = model.video_id;
    
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
