//
//  HttpRequestBlock.m
//  HttpDemoBlock_1520
//
//  Created by 张诚 on 15/7/21.
//  Copyright (c) 2015年 zhangcheng. All rights reserved.
//

#import "HttpRequestBlock.h"
#import "MyMD5.h"
#import "NSFileManager+Method.h"
#import "MBProgressHUD.h"

@implementation HttpRequestBlock
-(instancetype)initWithUrlStr:(NSString*)urlStr Block:(void(^)(HttpRequestBlock*,BOOL))a{

    if (self=[super init]) {
        //首先进行赋值，保存block指针
        self.myBlock=a;
        
        app=[UIApplication sharedApplication].delegate;
        //数据缓存我们一般按照网络请求地址进行保存，但是网络地址有时候总是小白吐槽说你泄露我用户隐私，为了解决这类问题，我们需要对文件名称进行加密，加密后小白看不懂 加密有哪些库是可以用的 MD5 sha-1 sha-256这类sha系列加密  RC4 RCS
        
        //这个地址用于保存文件下载成功后保存路径
        self.path=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),[MyMD5 md5:urlStr]];
        
//        NSFileManager 对这个类进行添加一个扩展方法
        NSFileManager*manager=[NSFileManager defaultManager];
        if ([manager fileExistsAtPath:self.path]&&[manager timeOutWithFileName:[MyMD5 md5:urlStr] timeOut:60*60]) {
            
            //如果缓存有效，读取缓存
            self.data=[NSMutableData dataWithContentsOfFile:self.path];
            //进行解析
            [self jsonValue];
            
        }else{
            //转换中文地址
            NSString*tempStr=urlStr;
            tempStr=[tempStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            //经过转换比如愤怒的小鸟就会变为 %ER%CD%KJ之类的字符串接口
            
            //在开始网络请求时候旋转菊花
            [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
            [MBProgressHUD showHUDAddedTo:app.window animated:YES];
            //进行网络请求
            _connection=[NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:tempStr]] delegate:self];

        
        
        }
 
        
    }

    return self;
}
#pragma mark NSURLConnectionDataDelegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.data=[NSMutableData data];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //进行数据保存
    [self.data writeToFile:self.path atomically:YES];
    
    //进行开始解析
    [self jsonValue];
    //在开始网络请求时候旋转菊花
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    [MBProgressHUD hideHUDForView:app.window animated:YES];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //调用错误
    if (self.myBlock) {
        self.myBlock(self,NO);
    }
    //在开始网络请求时候旋转菊花
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    [MBProgressHUD hideHUDForView:app.window animated:YES];

}
-(void)jsonValue{
    id result=[NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
    if ([result isKindOfClass:[NSArray class]]) {
        self.dataArray=result;
    }else{
        if ([result isKindOfClass:[NSDictionary class]]) {
            self.dataDic=result;
        }else{
            //如果不是数组也不是字典 result就为nil，data转换为image
            self.dataImage=[UIImage imageWithData:self.data];
        
        
        }
    
    }
    
    
    //调用block
    if (self.myBlock) {
        self.myBlock(self,YES);
    }


}

@end








