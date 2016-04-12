//
//  changePasswordServerce.m
//  LoveHealth
//
//  Created by administrator on 16/4/12.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "changePasswordServerce.h"
#import "AFHTTPSessionManager.h"

@interface changePasswordServerce ()

@end

@implementation changePasswordServerce

+(void)changePassword:(NSDictionary *)dic and:(void (^)(NSDictionary *))success{
     
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     manager.responseSerializer = [AFJSONResponseSerializer serializer];
     NSString *url = @"http://139.129.50.9/Healthapp/index.php/home/user/updatapassword";
     [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
          NSDictionary *dics = responseObject;
          success(dics);
          
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"file");
     }];
}

+(void)changeUserMessage:(NSMutableDictionary *)dic and:(void (^)(NSDictionary *))success{
     
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     manager.responseSerializer = [AFJSONResponseSerializer serializer];
     NSString *url = @"http://139.129.50.9/Healthapp/index.php/home/user/updatausernickname";
     [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
          NSDictionary *dics = responseObject;
          success(dics);
          
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"file");
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
