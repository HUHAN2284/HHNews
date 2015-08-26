//
//  HPCell.m
//  News_Project
//
//  Created by MS on 15/8/15.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import "HPCell.h"
#import "HomePageModel.h"
#import "UIImageView+WebCache.h"
@implementation HPCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self makeUI];
    }
    return self;
}

//- (void)makeUI
//{
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//    CGFloat height = [UIScreen mainScreen].bounds.size.height;
//    
//    iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height/2)];
//    [self.contentView addSubview:iconImageView];
//    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height/2, width, height/4)];
//    [self.contentView addSubview:titleLabel];
//    desLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height-height/4, width, height/4)];
//    desLabel.numberOfLines = 0;
//    [self.contentView addSubview:desLabel];
//}

-(void)configModel:(HomePageModel *)model
{
//    _iconImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [model.pic_height floatValue]/2);
//    = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [model.pic_height floatValue])];
    NSString *imageUrl = [NSString stringWithFormat:@"http://lifeweeker3.cms.palmtrends.com%@",model.thumb];
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    _titleLabel.text = model.title;
    _desLabel.text = model.des;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
