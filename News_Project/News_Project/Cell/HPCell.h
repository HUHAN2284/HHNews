//
//  HPCell.h
//  News_Project
//
//  Created by MS on 15/8/15.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomePageModel;

@interface HPCell : UITableViewCell
{
//    UIImageView *iconImageView;
//    UILabel *titleLabel;
//    UILabel *desLabel;
}
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
-(void)configModel:(HomePageModel *)model;

@end
