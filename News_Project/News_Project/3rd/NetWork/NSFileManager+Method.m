//
//  NSFileManager+Method.m
//  HttpDemoBlock_1520
//
//  Created by 张诚 on 15/7/21.
//  Copyright (c) 2015年 zhangcheng. All rights reserved.
//

#import "NSFileManager+Method.h"

@implementation NSFileManager (Method)
-(BOOL)timeOutWithFileName:(NSString*)fileName timeOut:(NSTimeInterval)time{
    NSFileManager*manager=[NSFileManager defaultManager];
    //获取文件属性
    NSDictionary*info=[manager attributesOfItemAtPath:[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),fileName] error:nil];
    //获取文件创建时间
    NSDate*createDate=[info objectForKey:NSFileCreationDate];
    //获取当前时间
    NSDate*date=[NSDate date];
    //二个时间，算时间差
    NSTimeInterval time1=[date timeIntervalSinceDate:createDate];
    //与我们设定时间间隔进行对比
    if (time1<time) {
        return YES;
    }else{
        return NO;
    }
    
    
    
    

}
@end
