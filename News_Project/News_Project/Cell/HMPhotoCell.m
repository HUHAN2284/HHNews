//
//  HMPhotoCell.m
//  News_Project
//
//  Created by MS on 15/8/19.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import "HMPhotoCell.h"
#import "HMWaterflowView.h"
#import "UIImageView+WebCache.h"
#import "PhotoModel.h"

@interface HMPhotoCell()
{
    UIImageView *_icon;
    UILabel *_titleLabel;
    UILabel *_desLabel;
}
@end

@implementation HMPhotoCell

+ (instancetype)cellWithWaterflowView:(HMWaterflowView *)waterflowView
{
    static NSString *ID = @"ID";
    HMPhotoCell *cell = [waterflowView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[HMPhotoCell alloc]init];
        cell.identifier = ID;
    }
    return cell;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _icon = [[UIImageView alloc] init];
        [self addSubview:_icon];
        
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        
        _desLabel = [[UILabel alloc] init];
        [self addSubview:_desLabel];
        
    }
    
    return self;
}
- (void)setModel:(PhotoModel *)model
{
    
    
    NSString *imageUrl = [NSString stringWithFormat:@"http://lifeweeker3.cms.palmtrends.com%@",model.icon];
    [_icon sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    _titleLabel.text = model.title;
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _desLabel.text = [self getDate:model.timestamp];
    _desLabel.font = [UIFont systemFontOfSize:10];
}

- (NSString *)getDate:(NSString *)date

{
    
    long long time=[date longLongValue];
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];//格式化
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    //    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
    
    NSString * timeStr =[df stringFromDate:d];
    
    return timeStr;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _icon.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-20-12);
    
    CGFloat priceX = 0;
    CGFloat priceH = 25;
    CGFloat priceY = self.bounds.size.height - priceH;
    CGFloat priceW = self.bounds.size.width;
    _titleLabel.frame = CGRectMake(priceX, priceY-12, priceW, priceH);
    _desLabel.frame = CGRectMake(priceX, priceY, priceW, priceH);
}

@end
