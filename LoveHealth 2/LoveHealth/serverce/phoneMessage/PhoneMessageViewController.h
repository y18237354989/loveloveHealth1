//
//  PhoneMessageViewController.h
//  LoveHealth
//
//  Created by administrator on 16/4/11.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneMessageViewController : UIViewController

//获取验证码方法
+ (void)PhoneNum:(NSString *)phoneNum;
//验证验证码方法
+ (void)CodeNum:(NSString *)codeNUm andPhoneNum:(NSString *)phoneNum;
+ (void)CodeNum:(NSString *)codeNUm andPhoneNum:(NSString *)phoneNum and:(void(^)(NSString *str))success;
@end
