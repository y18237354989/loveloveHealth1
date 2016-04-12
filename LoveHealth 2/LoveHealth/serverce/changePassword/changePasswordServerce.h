//
//  changePasswordServerce.h
//  LoveHealth
//
//  Created by administrator on 16/4/12.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface changePasswordServerce : UIViewController

//修改密码
+ (void)changePassword:(NSDictionary *)dic and:(void(^)(NSDictionary *userDic))success;

//修改个人信息
+ (void)changeUserMessage:(NSMutableDictionary *)dic and:(void(^)(NSDictionary *userDic))success;

@end
