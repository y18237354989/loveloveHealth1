//
//  LogInServerceViewController.m
//  LoveHealth
//
//  Created by administrator on 16/4/8.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "LogInServerceViewController.h"
#import "AFHTTPSessionManager.h"

@interface LogInServerceViewController ()

@end

@implementation LogInServerceViewController

+ (void)logInUser:(NSMutableDictionary *)dataDic and:(void (^)(NSMutableDictionary *))success{
     
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     
     manager.responseSerializer = [AFJSONResponseSerializer serializer];
     
     NSString *url = @"http://139.129.50.9/Healthapp/index.php/home/user/login";
     
     NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dataDic];
     
     [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
          NSMutableDictionary *dics = responseObject;
          success(dics);
          
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          
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
