//
//  LogInViewController.m
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "LogInViewController.h"
#import "Header.h"
#import "LogInServerceViewController.h"
#import "RegisterViewController.h"
#import "MyPageListViewController.h"
#import "ChangePasswordViewController.h"

@interface LogInViewController ()<UITextFieldDelegate>

@end

@implementation LogInViewController

- (void)viewWillAppear:(BOOL)animated{
     
     self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
     [super viewDidLoad];
     self.navigationItem.title = @"登录";
     self.view.backgroundColor = COLOR(255, 255, 255, 1);
     [self createControl];
}

//创建控件
- (void)createControl{
     
     self.picView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(64), SCREEN_WIDTH, HEIGHT5S(80))];
     self.picView.backgroundColor = COLOR(228, 228, 228, 1);
     [self.view addSubview:self.picView];
     
     self.userNumberLogo = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(154), WIDTH5S(20), HEIGHT5S(20))];
     self.userNumberLogo.image = IMAGE(@"me@2x");
     [self.view addSubview:self.userNumberLogo];
     
     self.userNumberText = [[UITextField alloc]initWithFrame:CGRectMake(WIDTH5S(45), HEIGHT5S(154), WIDTH5S(260), HEIGHT5S(20))];
     self.userNumberText.font = FONT(14);
     self.userNumberText.placeholder = @"你的手机号";
     self.userNumberText.keyboardType = UIKeyboardTypeNamePhonePad;
     self.userNumberText.tag = 1001;
     self.userNumberText.delegate = self;
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
     
     self.userNumLine = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(183), WIDTH5S(290), HEIGHT5S(1))];
     self.userNumLine.backgroundColor = COLOR(228, 228, 228, 1);
     [self.view addSubview:self.userNumLine];
     
     self.passwordLine = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(223), WIDTH5S(290), HEIGHT5S(1))];
     self.passwordLine.backgroundColor = COLOR(228, 228, 228, 1);
     [self.view addSubview:self.passwordLine];
     
     self.registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(234), WIDTH5S(140), HEIGHT5S(30))];
     [self.registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
     [self.registerBtn setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateNormal];
     self.registerBtn.layer.borderWidth = 1;
     self.registerBtn.layer.borderColor = COLOR(0, 210, 210, 1).CGColor;
     self.registerBtn.layer.cornerRadius = 3;
     self.registerBtn.layer.masksToBounds =YES;
     [self.view addSubview:self.registerBtn];
     
     self.logInBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(165), HEIGHT5S(234), WIDTH5S(140), HEIGHT5S(30))];
     [self.logInBtn setTitle:@"登录" forState:UIControlStateNormal];
     [self.logInBtn setTitleColor:COLOR(255, 255, 255, 1) forState:UIControlStateNormal];
     self.logInBtn.backgroundColor = COLOR(100, 210, 210, 1);
     self.logInBtn.layer.cornerRadius = 3;
     self.logInBtn.layer.masksToBounds =YES;
     [self.view addSubview:self.logInBtn];
     
     self.changePassword = BUTTON_RECT(WIDTH5S(245), HEIGHT5S(274), WIDTH5S(60), HEIGHT5S(20));
     self.changePassword.titleLabel.font = FONT(12);
     [self.changePassword setTitle:@"修改密码" forState:UIControlStateNormal];
     [self.changePassword setTitleColor:COLOR(0, 0, 200, 1) forState:UIControlStateNormal];
     [self.view addSubview:self.changePassword];
     
     
     [self.registerBtn addTarget:self action:@selector(goToRegister) forControlEvents:UIControlEventTouchUpInside];
     [self.logInBtn addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
     [self.changePassword addTarget:self action:@selector(changePasswords) forControlEvents:UIControlEventTouchUpInside];
     
}
//去注册
- (void)goToRegister{
     
     RegisterViewController *rvc = [[RegisterViewController alloc]init];
     [self.navigationController pushViewController:rvc animated:YES];
}

//修改密码
- (void)changePasswords{
     
     ChangePasswordViewController *pvc = [[ChangePasswordViewController alloc]init];
     [self.navigationController pushViewController:pvc animated:YES];
}

//登录
- (void)logIn{
     
     NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithCapacity:0];
     [dics setObject:self.userNumberText.text forKey:@"tel"];
     [dics setObject:self.passwordText.text forKey:@"pwd"];
     
     [LogInServerceViewController logInUser:dics and:^(NSMutableDictionary *dic) {
          
          if ([[dic objectForKey:@"message"] isEqualToString:@"登录失败"]) {
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码错误" preferredStyle:UIAlertControllerStyleAlert];
               UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
               [alert addAction:action];
               [self presentViewController:alert animated:YES completion:nil];
               self.passwordText.text = @"";
               
          }else{
               NSLog(@"%@",dic);
               
               NSUserDefaults  *user=[NSUserDefaults standardUserDefaults];
               NSArray *arr=[dic objectForKey:@"result"];
               
               NSString *dics = [arr[0] objectForKey:@"user_id"];
               
               [user setObject:dics forKey:@"usermessage"];
               
               [self.navigationController popViewControllerAnimated:YES];
          }
     }];
     
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
     
     if (textField.tag == 1001) {
          self.userNumLine.backgroundColor = COLOR(0, 210, 210, 1);
          self.passwordLine.backgroundColor = COLOR(228, 228, 228, 1);
          
     }else if (textField.tag == 1002){
          self.passwordLine.backgroundColor = COLOR(0, 210, 210, 1);
          self.userNumLine.backgroundColor = COLOR(228, 228, 228, 1);
          
     }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
     
     self.userNumLine.backgroundColor = COLOR(228, 228, 228, 1);
     self.passwordLine.backgroundColor = COLOR(228, 228, 228, 1);
     return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     
     [self.view endEditing:YES];
     
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
