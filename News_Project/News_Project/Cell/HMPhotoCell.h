//
//  HMPhotoCell.h
//  News_Project
//
//  Created by MS on 15/8/19.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import "HMWaterflowViewCell.h"
@class HMWaterflowView, PhotoModel;
@interface HMPhotoCell : HMWaterflowViewCell

+ (instancetype)cellWithWaterflowView:(HMWaterflowView *)waterflowView;
@property (nonatomic, strong) PhotoModel *model;

@end
