//
//  PostCommentServerceViewController.m
//  LoveHealth
//
//  Created by administrator on 16/4/9.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "PostCommentServerceViewController.h"
#import "AFHTTPSessionManager.h"

@interface PostCommentServerceViewController ()

@end

@implementation PostCommentServerceViewController

//获取帖子数据
+(void)postCommentRequerst:(NSString *)postId and:(void (^)(NSMutableDictionary *))success{
     
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     
     manager.responseSerializer = [AFJSONResponseSerializer serializer];
     NSString *url = [NSString stringWithFormat:@"http://139.129.50.9/Healthapp/index.php/home/post/getnewscomment?postid=%@",postId];
     
     [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
          NSMutableDictionary *dic = responseObject;
          success(dic);
          
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"file");
     }];
     
}

//发送评论
+(void)sendCommentWithDic:(NSDictionary *)dic andWith:(void (^)(NSDictionary *))success{
     
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     
     manager.responseSerializer = [AFJSONResponseSerializer serializer];
     
     NSString *url = @"http://139.129.50.9/Healthapp/index.php/home/post/postcommet";
     
     NSMutableDictionary *mutdic = [NSMutableDictionary dictionaryWithCapacity:0];
     [mutdic setDictionary:dic];
     
     [manager POST:url parameters:mutdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
          NSDictionary *dic1 = responseObject;
          
          NSDictionary *dics = [dic1 objectForKey:@"result"];
          NSLog(@"%@",dics);
          success(dics);
          
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@".....");
     }];
}
//发送回复
+(void)postRecomm:(NSDictionary *)reCommData and:(void(^)(NSDictionary *))success{
     
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     
     manager.responseSerializer = [AFJSONResponseSerializer serializer];
     

     NSString *url = @"http://139.129.50.9/Healthapp/index.php/home/post/postreply";
     NSDictionary *dic = reCommData;
     
     [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
          NSDictionary *dic1 = responseObject;
     success(dic1);
          
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@".....");
     }];

}

//请求评论回复数据
+(void)getReCommData:(NSString *)commentId and:(void (^)(NSDictionary *))success{
     
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     
     manager.responseSerializer = [AFJSONResponseSerializer serializer];
     
     NSString *url = [NSString stringWithFormat:@"http://139.129.50.9/Healthapp/index.php/home/post/getpostreply?postcommentid=%@",commentId];
     
     [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
          NSDictionary *dics = responseObject;
          success(dics);
          
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"file");
     }];
     
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
