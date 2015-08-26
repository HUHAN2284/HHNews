//
//  HttpRequestBlock.h
//  HttpDemoBlock_1520
//
//  Created by 张诚 on 15/7/21.
//  Copyright (c) 2015年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface HttpRequestBlock : NSObject<NSURLConnectionDataDelegate>
{
    AppDelegate*app;

}
//下载文件保存路径
@property(nonatomic,copy)NSString*path;
//下载的指针
@property(nonatomic,strong)NSURLConnection*connection;

//保存下载的原始数据
@property(nonatomic,strong)NSMutableData*data;
//解析结果
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)NSMutableDictionary*dataDic;
@property(nonatomic)UIImage*dataImage;

//声明
@property(nonatomic,copy)void(^myBlock)(HttpRequestBlock*,BOOL isSucceed);

//方法
-(instancetype)initWithUrlStr:(NSString*)urlStr Block:(void(^)(HttpRequestBlock*,BOOL))a;

@end









