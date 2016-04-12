//
//  PhoneMessageViewController.m
//  LoveHealth
//
//  Created by administrator on 16/4/11.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "PhoneMessageViewController.h"
#import "Header.h"
@interface PhoneMessageViewController ()

@end

@implementation PhoneMessageViewController

//获取验证码
+ (void)PhoneNum:(NSString *)phoneNum{
     
     [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneNum zone:@"86" customIdentifier:nil result:^(NSError *error) {
          if (!error) {
               NSLog(@"获取验证成功");
          }else{
               NSLog(@"错误信息:%@",error);
          }
     }];
}

+ (void)CodeNum:(NSString *)codeNUm andPhoneNum:(NSString *)phoneNum{
     
     [SMSSDK commitVerificationCode:codeNUm phoneNumber:phoneNum zone:@"86" result:^(NSError *error) {
          if (!error) {
               NSLog(@"验证成功");
          }else{
               NSLog(@"错误信息:%@",error);
          }
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
