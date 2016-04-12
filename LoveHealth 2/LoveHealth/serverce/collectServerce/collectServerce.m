//
//  collectServerce.m
//  LoveHealth
//
//  Created by administrator on 16/4/11.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "collectServerce.h"
#import "AFHTTPSessionManager.h"
@implementation collectServerce

+(void)newscollect:(NSString *)str and:(void(^)(NSMutableDictionary *dic))success{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *url =[NSString stringWithFormat:@"http://139.129.50.9/Healthapp/index.php/home/user/getmycollectnews?userid=%@",str];
   
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableDictionary *dics = responseObject;
        success(dics);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
 
}
+(void)shopcollect:(NSString *)str and:(void(^)(NSMutableDictionary *dic))success{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *url =[NSString stringWithFormat:@"http://139.129.50.9/Healthapp/index.php/home/user/getmycollectshop?userid=%@",str];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableDictionary *dics = responseObject;
        success(dics);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
+(void)postcollect:(NSString *)str and:(void(^)(NSMutableDictionary *dic))success{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *url =[NSString stringWithFormat:@"http://139.129.50.9/Healthapp/index.php/home/user/getmycollectpost?userid=%@",str];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableDictionary *dics = responseObject;
        success(dics);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}



@end
