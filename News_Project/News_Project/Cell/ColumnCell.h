//
//  ColumnCell.h
//  News_Project
//
//  Created by MS on 15/8/15.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ColumnModel;
@interface ColumnCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *redTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *blackLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)configModel:(ColumnModel *)model;

@end
