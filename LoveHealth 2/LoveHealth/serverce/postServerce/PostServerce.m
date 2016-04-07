//
//  PostServerce.m
//  LoveHealth
//
//  Created by administrator on 16/4/7.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "PostServerce.h"
#import "AFNetworking.h"

@implementation PostServerce

+(void)sendPostWithDic:(NSDictionary *)dic andWith:(void (^)(NSDictionary *))success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *url = @"http://139.129.50.9/Healthapp/index.php/home/post/newpost";
    
    NSMutableDictionary *mutdic = [NSMutableDictionary dictionaryWithCapacity:0];
    [mutdic setDictionary:dic];
    
    [manager POST:url parameters:mutdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic1 = responseObject;
        
        NSDictionary *dics = [dic1 objectForKey:@"result"];
        NSLog(@"%@",dics);
        success(dics);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

+(void)getPostWithDic:(NSDictionary *)dic andWith:(void (^)(NSDictionary *))success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"http://139.129.50.9/Healthapp/index.php/home/post/post?postType=%@&pageindex=%@",[dic objectForKey:@"postType"],[dic objectForKey:@"pageindex"]
                     ];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 = responseObject;

        success(dic1);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
@end
