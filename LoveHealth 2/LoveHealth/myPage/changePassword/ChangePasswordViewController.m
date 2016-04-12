//
//  ChangePasswordViewController.m
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "Header.h"
#import "PhoneMessageViewController.h"
#import "changePasswordServerce.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>

@property (strong, nonatomic)UITextField *userNum; //账号

@property (strong, nonatomic)UITextField *password;

@property (strong, nonatomic)UITextField *passwordAgain;

@property (strong, nonatomic)UIButton *tagBtn; //获取验证码

@property (strong, nonatomic)UITextField *codeNum;  //验证码

@property (strong, nonatomic)UILabel *line1, *line2, *line3, *line4; //自定义分割线

@property (strong, nonatomic)UIButton *change;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     self.view.backgroundColor = COLOR(255, 255, 255, 1);
     self.navigationItem.title = @"修改密码";
     [self createControl];
}


//创建控件
- (void)createControl{
     
     self.userNum = TEXT_RECT(WIDTH5S(15), HEIGHT5S(74), WIDTH5S(290), HEIGHT5S(20));
     self.userNum.delegate = self;
     self.userNum.tag = 1001;
     self.userNum.placeholder = @"请输入您的账号";
     [self.view addSubview:self.userNum];
     
     self.password = TEXT_RECT(WIDTH5S(15), HEIGHT5S(114), WIDTH5S(290), HEIGHT5S(20));
     self.password.delegate = self;
     self.password.tag = 1002;
     self.password.placeholder = @"新密码";
     [self.view addSubview:self.password];
     
     self.passwordAgain = TEXT_RECT(WIDTH5S(15), HEIGHT5S(154), WIDTH5S(290), HEIGHT5S(20));
     self.passwordAgain.delegate = self;
     self.passwordAgain.tag = 1003;
     self.passwordAgain.placeholder = @"确认密码";
     [self.view addSubview:self.passwordAgain];
     
     self.tagBtn = BUTTON_RECT(WIDTH5S(15), HEIGHT5S(192), WIDTH5S(80), HEIGHT5S(24));
     self.tagBtn.backgroundColor = COLOR(0, 210, 210, 1);
     [self.tagBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
     self.tagBtn.titleLabel.font = FONT(14);
     self.tagBtn.layer.cornerRadius = 3;
     self.tagBtn.layer.masksToBounds = YES;
     [self.view addSubview:self.tagBtn];
     [self.tagBtn addTarget:self action:@selector(getTag) forControlEvents:UIControlEventTouchUpInside];
     
     self.codeNum = TEXT_RECT(WIDTH5S(105), HEIGHT5S(194), WIDTH5S(200), HEIGHT5S(HEIGHT5S(20)));
     self.codeNum.delegate = self;
     self.codeNum.tag = 1004;
     self.codeNum.placeholder = @"请输入验证码";
     [self.view addSubview:self.codeNum];
     
     self.change = BUTTON_RECT(WIDTH5S(15), HEIGHT5S(234), WIDTH5S(290), HEIGHT5S(30));
     self.change.backgroundColor = COLOR(0, 210, 210, 1);
     [self.change setTitle:@"确认修改" forState:UIControlStateNormal];
     self.change.layer.cornerRadius = 3;
     self.change.layer.masksToBounds = YES;
     [self.view addSubview:self.change];
     [self.change addTarget:self action:@selector(changePassword) forControlEvents:UIControlEventTouchUpInside];
     
     self.line1 = LABEL_RECT(WIDTH5S(15), HEIGHT5S(103), WIDTH5S(290), HEIGHT5S(1));
     self.line1.backgroundColor = COLOR(228, 228, 228, 1);
     [self.view addSubview:self.line1];
     
     self.line2 = LABEL_RECT(WIDTH5S(15), HEIGHT5S(143), WIDTH5S(290), HEIGHT5S(1));
     self.line2.backgroundColor = COLOR(228, 228, 228, 1);
     [self.view addSubview:self.line2];
     
     self.line3 = LABEL_RECT(WIDTH5S(15), HEIGHT5S(183), WIDTH5S(290), HEIGHT5S(1));
     self.line3.backgroundColor = COLOR(228, 228, 228, 1);
     [self.view addSubview:self.line3];
     
     self.line4 = LABEL_RECT(WIDTH5S(15), HEIGHT5S(223), WIDTH5S(290), HEIGHT5S(1));
     self.line4.backgroundColor = COLOR(228, 228, 228, 1);
     [self.view addSubview:self.line4];
     
}

//获取验证码方法
- (void)getTag{
     
     [PhoneMessageViewController PhoneNum:self.userNum.text];
     
}
//匹配验证码信息-匹配成功修改
- (void)changePassword{
     
//     //验证输入验证码是否匹配
//     [PhoneMessageViewController CodeNum:self.codeNum.text andPhoneNum:self.userNum.text and:^(NSString *str) {
//          
//          if ([str isEqualToString:@"seccess"]) {
//               
//               NSDictionary *dic = @{
//                                     @"newpassword":self.password.text,
//                                     @"usernumber":self.userNum.text
//                                     };
//               //修改
//               [changePasswordServerce changePassword:dic and:^(NSDictionary *userDic) {
//                    NSLog(@"%@",userDic);
//               }];
//               
//          }else{
//               NSLog(@"验证码不正确");
//          }
//     }];
     
     //验证输入验证码是否匹配
     [PhoneMessageViewController CodeNum:self.codeNum.text andPhoneNum:self.userNum.text];
     
     
     NSDictionary *dic = @{
                           @"newpassword":self.password.text,
                           @"usernumber":self.userNum.text
                           };
     
     [changePasswordServerce changePassword:dic and:^(NSDictionary *userDic) {
          NSLog(@"%@",userDic);
     }];
     
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
     
     if (textField.tag == 1001) {
          self.line1.backgroundColor = COLOR(0, 210, 210, 1);
          self.line2.backgroundColor = COLOR(228, 228, 228, 1);
          self.line3.backgroundColor = COLOR(228, 228, 228, 1);
          self.line4.backgroundColor = COLOR(228, 228, 228, 1);
          
     }else if (textField.tag == 1002){
          self.line2.backgroundColor = COLOR(0, 210, 210, 1);
          self.line1.backgroundColor = COLOR(228, 228, 228, 1);
          self.line3.backgroundColor = COLOR(228, 228, 228, 1);
          self.line4.backgroundColor = COLOR(228, 228, 228, 1);
          
     }else if (textField.tag == 1003){
          self.line3.backgroundColor = COLOR(0, 210, 210, 1);
          self.line1.backgroundColor = COLOR(228, 228, 228, 1);
          self.line2.backgroundColor = COLOR(228, 228, 228, 1);
          self.line4.backgroundColor = COLOR(228, 228, 228, 1);
     }else if (textField.tag == 1004){
          self.line4.backgroundColor = COLOR(0, 210, 210, 1);
          self.line1.backgroundColor = COLOR(228, 228, 228, 1);
          self.line2.backgroundColor = COLOR(228, 228, 228, 1);
          self.line3.backgroundColor = COLOR(228, 228, 228, 1);
     }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
     
     self.line1.backgroundColor = COLOR(228, 228, 228, 1);
     self.line2.backgroundColor = COLOR(228, 228, 228, 1);
     self.line3.backgroundColor = COLOR(228, 228, 228, 1);
     self.line4.backgroundColor = COLOR(228, 228, 228, 1);
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
