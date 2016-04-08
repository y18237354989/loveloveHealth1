//
//  RegisterServerceViewController.h
//  LoveHealth
//
//  Created by administrator on 16/4/8.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterServerceViewController : UIViewController

+ (void)registerUser:(NSMutableDictionary *)dataDic and:(void(^)(NSMutableDictionary *dic))success;

@end
