//
//  VideoCell.h
//  News_Project
//
//  Created by MS on 15/8/19.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoModel;
@interface VideoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *video_lengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *creation_timeLabel;

-(void)configModel:(VideoModel *)model;

@end
