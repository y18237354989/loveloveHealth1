//
//  RegisterViewController.m
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "RegisterViewController.h"
#import "Header.h"
#import "RegisterServerceViewController.h"
#import "AppDelegate.h"

@interface RegisterViewController ()<UITextFieldDelegate>

@end

@implementation RegisterViewController

- (void)viewWillAppear:(BOOL)animated{
     
     self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
     
     [super viewDidLoad];
     self.navigationItem.title = @"注册";
     self.view.backgroundColor = COLOR(255, 255, 255, 1);
     [self createControl];
     
}

//创建控件
- (void)createControl{
    
     self.picView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH5S(0), HEIGHT5S(64), SCREEN_WIDTH, HEIGHT5S(80))];
     self.picView.image = IMAGE(@"1.1.jpg");
     self.picView.layer.masksToBounds = YES;
     [self.view addSubview:self.picView];
     
     self.userNumberLogo = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(154), WIDTH5S(20), HEIGHT5S(20))];
     self.userNumberLogo.image = IMAGE(@"me@2x");
     [self.view addSubview:self.userNumberLogo];
     
     self.userNumberText = [[UITextField alloc]initWithFrame:CGRectMake(WIDTH5S(45), HEIGHT5S(154), WIDTH5S(260), HEIGHT5S(20))];
     self.userNumberText.font = FONT(14);
     self.userNumberText.placeholder = @"你的手机号";
     self.userNumberText.keyboardType = UIKeyboardTypeNamePhonePad;
     self.userNumberText.delegate = self;
     self.userNumberText.tag = 1001;
     [self.view addSubview:self.userNumberText];
     
     self.passwordLogo = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(194), WIDTH5S(20), HEIGHT5S(20))];
     self.passwordLogo.image = IMAGE(@"lock");
     [self.view addSubview:self.passwordLogo];
     
     self.passwordText = [[UITextField alloc]initWithFrame:CGRectMake(WIDTH5S(45), HEIGHT5S(194), WIDTH5S(260), HEIGHT5S(20))];
     self.passwordText.font = FONT(14);
     self.passwordText.placeholder = @"请输入密码";
     self.passwordText.keyboardType = UIKeyboardTypeDefault;
     self.passwordText.tag = 1002;
     self.passwordText.delegate = self;
     [self.view addSubview:self.passwordText];
     
     self.codeText = [[UITextField alloc]initWithFrame:CGRectMake(WIDTH5S(95), HEIGHT5S(234), WIDTH5S(260), HEIGHT5S(20))];
     self.codeText.font = FONT(14);
     self.codeText.placeholder = @"请输入验证码";
     self.codeText.keyboardType = UIKeyboardTypeNamePhonePad;
     self.codeText.tag = 1003;
     self.codeText.delegate = self;
     [self.view addSubview:self.codeText];
     
     self.codeBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(234), WIDTH5S(70), HEIGHT5S(20))];
     [self.codeBtn setTitle:@"验证码" forState:UIControlStateNormal];
     self.codeBtn.backgroundColor = COLOR(0, 210, 210, 1);
     self.codeBtn.layer.cornerRadius = 3;
     self.codeBtn.layer.masksToBounds = YES;
     [self.view addSubview:self.codeBtn];
     [self.codeBtn addTarget:self action:@selector(code) forControlEvents:UIControlEventTouchUpInside];
     
     self.userNumLine = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(183), WIDTH5S(290), HEIGHT5S(1))];
     self.userNumLine.backgroundColor = COLOR(228, 228, 228, 1);
     [self.view addSubview:self.userNumLine];
     
     self.passwordLine = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(223), WIDTH5S(290), HEIGHT5S(1))];
     self.passwordLine.backgroundColor = COLOR(228, 228, 228, 1);
     [self.view addSubview:self.passwordLine];
     
     self.codeLine = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(263), WIDTH5S(290), HEIGHT5S(1))];
     self.codeLine.backgroundColor = COLOR(228, 228, 228, 1);
     [self.view addSubview:self.codeLine];

     self.registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(274), WIDTH5S(290), HEIGHT5S(30))];
     [self.registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
     [self.registerBtn setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateNormal];
     self.registerBtn.layer.borderWidth = 1;
     self.registerBtn.layer.borderColor = COLOR(0, 210, 210, 1).CGColor;
     self.registerBtn.layer.cornerRadius = 3;
     self.registerBtn.layer.masksToBounds =YES;
     [self.view addSubview:self.registerBtn];
     
     [self.registerBtn addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
     
}


//获取验证码
- (void)code{
     
     [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.userNumberText.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
          if (!error) {
               NSLog(@"获取验证成功");
          }else{
               NSLog(@"错误信息:%@",error);
          }
     }];
}



- (void)registerUser{
     
     //先验证信息  再注册
//     [SMSSDK commitVerificationCode:self.codeText.text phoneNumber:self.userNumberText.text zone:@"86" result:^(NSError *error) {
//          if (!error) {
//               NSLog(@"验证成功");
//               NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithCapacity:0];
//               [dics setObject:self.userNumberText.text forKey:@"tel"];
//               [dics setObject:self.passwordText.text forKey:@"pwd"];
//               
//               [RegisterServerceViewController registerUser:dics and:^(NSMutableDictionary *dic) {
//                    
//                    if (dic == Nil) {
//                         NSLog(@"register file");
//                    }else{
//                         [self.navigationController popViewControllerAnimated:YES];
//                    }
//               }];
//          }else{
//               NSLog(@"错误信息:%@",error);
//          }
//     }];
     
     
     NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithCapacity:0];
     [dics setObject:self.userNumberText.text forKey:@"tel"];
     [dics setObject:self.passwordText.text forKey:@"pwd"];
     
     [RegisterServerceViewController registerUser:dics and:^(NSMutableDictionary *dic) {
          
          if (dic == Nil) {
               NSLog(@"register file");
          }else{
               [self.navigationController popViewControllerAnimated:YES];
          }
     }];
     
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
     
     if (textField.tag == 1001) {
          self.userNumLine.backgroundColor = COLOR(0, 210, 210, 1);
          self.passwordLine.backgroundColor = COLOR(228, 228, 228, 1);
          self.codeLine.backgroundColor = COLOR(228, 228, 228, 1);
     }else if (textField.tag == 1002){
          self.passwordLine.backgroundColor = COLOR(0, 210, 210, 1);
          self.userNumLine.backgroundColor = COLOR(228, 228, 228, 1);
          self.codeLine.backgroundColor = COLOR(228, 228, 228, 1);
     }if (textField.tag == 1003) {
          self.codeLine.backgroundColor = COLOR(0, 210, 210, 1);
          self.userNumLine.backgroundColor = COLOR(228, 228, 228, 1);
          self.passwordLine.backgroundColor = COLOR(228, 228, 228, 1);
     }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
     
     self.userNumLine.backgroundColor = COLOR(228, 228, 228, 1);
     self.passwordLine.backgroundColor = COLOR(228, 228, 228, 1);
     self.codeLine.backgroundColor = COLOR(228, 228, 228, 1);
     return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     
     [self.view endEditing:YES];
     
}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     
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
