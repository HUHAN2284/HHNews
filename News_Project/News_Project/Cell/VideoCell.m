//
//  VideoCell.m
//  News_Project
//
//  Created by MS on 15/8/19.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import "VideoCell.h"
#import "VideoModel.h"
#import "UIImageView+WebCache.h"
@implementation VideoCell

-(void)configModel:(VideoModel *)model
{
    NSString *url = [NSString stringWithFormat:@"http://lifeweeker3.cms.palmtrends.com%@",model.icon];
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    _video_lengthLabel.text = model.video_length;
    _titleLabel.text = model.title;
    _creation_timeLabel.text = [self getDate:model.creation_time];
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
- (void)awakeFromNib {
    // Initialization code
}

@end
