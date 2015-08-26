//
//  Column2Cell.h
//  News_Project
//
//  Created by MS on 15/8/17.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Column2Model;
@interface Column2Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


- (void)configModel:(Column2Model *)model;

@end
