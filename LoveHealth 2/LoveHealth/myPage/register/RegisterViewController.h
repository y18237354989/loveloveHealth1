//
//  RegisterViewController.h
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (strong, nonatomic)UIImageView *picView;

@property (strong, nonatomic)UIImageView *userNumberLogo;

@property (strong, nonatomic)UIImageView *passwordLogo;

@property (strong, nonatomic)UITextField *userNumberText;

@property (strong, nonatomic)UITextField *passwordText;

@property (strong, nonatomic)UITextField *codeText;

@property (strong, nonatomic)UIButton *codeBtn; //手机验证码

@property (strong, nonatomic)UIButton *registerBtn;

@property (strong, nonatomic)UILabel *userNumLine;

@property (strong, nonatomic)UILabel *passwordLine;

@property (strong, nonatomic)UILabel *codeLine;

@end
