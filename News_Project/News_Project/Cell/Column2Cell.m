//
//  Column2Cell.m
//  News_Project
//
//  Created by MS on 15/8/17.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import "Column2Cell.h"
#import "Column2Model.h"
@implementation Column2Cell

- (void)configModel:(Column2Model *)model
{
    _titleLabel.text = model.title;
    _desLabel.text = model.des;
    _timeLabel.text = [self getDate:model.creation_time];

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
