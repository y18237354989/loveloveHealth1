//
//  GoodsServerceViewController.m
//  LoveHealth
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "GoodsServerceViewController.h"
#import "XXXPlistLocalInfo.h"

@interface GoodsServerceViewController ()

@end

@implementation GoodsServerceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(void)saveData:(NSMutableDictionary *)dic and:(void (^)(NSMutableArray *))success{
     //数据录入plist
     XXXPlistLocalInfo *localInfo = [[XXXPlistLocalInfo alloc]init];
     NSString *localPath = [localInfo userInfoPath];
     NSString *lastPath = [localPath stringByAppendingPathComponent:@"goodsComment.plist"];
     NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:lastPath];
     if (arr == nil) {
          NSMutableArray *arrs = [NSMutableArray arrayWithCapacity:0];
          [arrs addObject:dic];
          BOOL iswrite = [arrs writeToFile:lastPath atomically:YES];
          if (iswrite) {
               NSLog(@"存入plist成功");
          }else{
               NSLog(@"存入plist失败");
          }
     }else{
          [arr addObject:dic];
          BOOL iswrite = [arr writeToFile:lastPath atomically:YES];
          if (iswrite) {
               NSLog(@"存入plist成功");
          }else{
               NSLog(@"存入plist失败");
          }
     }

}

+(void)getData:(void (^)(NSMutableArray *))success{
     
     //数据录入plist
     XXXPlistLocalInfo *localInfo = [[XXXPlistLocalInfo alloc]init];
     NSString *localPath = [localInfo userInfoPath];
     NSString *lastPath = [localPath stringByAppendingPathComponent:@"goodsComment.plist"];
     NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:lastPath];
     
     success(arr);
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
