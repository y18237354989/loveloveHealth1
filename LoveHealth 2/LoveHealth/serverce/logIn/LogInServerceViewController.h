//
//  LogInServerceViewController.h
//  LoveHealth
//
//  Created by administrator on 16/4/8.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInServerceViewController : UIViewController

+ (void)logInUser:(NSMutableDictionary *)dataDic and:(void(^)(NSMutableDictionary *dic))success;

@end
