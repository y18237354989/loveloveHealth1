//
//  GoodsServerceViewController.h
//  LoveHealth
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsServerceViewController : UIViewController

//存储数据
+ (void)saveData:(NSMutableDictionary *)dic and:(void(^)(NSMutableArray *dataArr))success;
//获取数据
+ (void)getData:(void(^)(NSMutableArray *dataArr))success;

@end
