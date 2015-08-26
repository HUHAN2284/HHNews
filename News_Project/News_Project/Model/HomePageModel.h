//
//  HomePageModel.h
//  News_Project
//
//  Created by MS on 15/8/15.
//  Copyright (c) 2015年 hanhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageModel : NSObject
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *des;
@property (nonatomic, copy) NSString *creation_time;
@property (nonatomic, copy) NSString *comment_count;
@property (nonatomic, assign) NSNumber *pic_height;

@property (nonatomic, copy) NSString *hp_id;

@end
