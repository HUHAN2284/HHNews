//
//  NSFileManager+Method.h
//  HttpDemoBlock_1520
//
//  Created by 张诚 on 15/7/21.
//  Copyright (c) 2015年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Method)
//扩展方法用于判断文件是否超时
-(BOOL)timeOutWithFileName:(NSString*)fileName timeOut:(NSTimeInterval)time;
@end
