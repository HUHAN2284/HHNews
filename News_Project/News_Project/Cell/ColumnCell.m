//
//  ColumnCell.m
//  News_Project
//
//  Created by MS on 15/8/15.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import "ColumnCell.h"
#import "ColumnModel.h"
#import "UIImageView+WebCache.h"
@implementation ColumnCell



- (void)configModel:(ColumnModel *)model
{
    _nameLabel.text = model.author;
    
    NSString *imageUrl = [NSString stringWithFormat:@"http://lifeweeker3.cms.palmtrends.com/%@",model.icon];
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    _redTitleLabel.text = model.intro;
    _blackLabel.text = model.title;
    _desLabel.text = model.des;
    _timeLabel.text = model.addtate;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
