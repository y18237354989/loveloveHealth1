//
//  newsServerceViewController.m
//  LoveHealth
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "newsServerceViewController.h"
#import "AFNetworking.h"
#import "Header.h"

@interface newsServerceViewController ()

@end

@implementation newsServerceViewController

+(void)newsServerce1:(void (^)(NSDictionary *))success{
     
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     manager.responseSerializer = [AFJSONResponseSerializer serializer];
     NSString *url = @"http://10.110.5.159:8888/Healthapp/index.php/home/user/news?newsType=1";
     [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
          NSDictionary *dic = responseObject;
          NSLog(@">>>>%@",dic);
          
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"file");
     }];

}

+ (void)newsServerce:(void (^)(NSDictionary *newsDic))success{
     
//     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//     manager.responseSerializer = [AFJSONResponseSerializer serializer];
//     NSString *url = @"http://139.129.50.9/Healthapp/index.php/home/user/news?newsType=1";
//     [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//          
//          NSDictionary *dic = responseObject;
//          NSArray *arr = [dic objectForKey:@"data"];
//          NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]initWithCapacity:0];
//          for (int i = 0; i < arr.count; i++) {
//               [dic1 setObject:arr[i] forKey:[arr[i] objectForKey:@"title"]];
//          }
//          success(dic1);
//          NSLog(@">>>>%@",dic1);
//     
//     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//          NSLog(@"file");
//     }];
     NSDictionary *Dic=@{
          
          @"result" :@{
                       @"code" :@"200",
                       @"reason" :@"success",
                       @"total":@"12306",
                       @"data" : @[
                                 @{
                                      @"title" :@"健康是养生",
                                      @"text" :@ "研究称：床头朝向竟能影响人类寿命 心肌炎、哮喘、心力衰竭：采取半躺半坐的睡姿，可改善肺部的血液循环",
                                      @"code" : @"200",
                                      @"date" :@ "2016-03-29",
                                      @"newsType" :@"健康",
                                      @"newsId": @" 0",
                                      @"image" :@[@"1.0.jpg"],
                                      @"commentNum":@"123",
                                      @"collectNum":@"321"
                                      },
                                 @{
                                      @"title" :@"床头朝向",
                                      @"text" :@"床头朝向竟能影响人类寿命 心肌炎、哮喘、心力衰竭：采取半躺半坐的睡姿",
                                      @"code" : @"200",
                                      @"date" :@"2016-03-29",
                                      @"newsType" :@"养生",
                                      @"newsId": @"1",
                                      @"image" :@[@"1.0.jpg",@"1.1.jpg",@"1.2.jpg"],
                                      @"commentNum":@"456",
                                      @"collectNum":@"654"
                                      }
                                 ]
                       }
     };

     success(Dic);
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
