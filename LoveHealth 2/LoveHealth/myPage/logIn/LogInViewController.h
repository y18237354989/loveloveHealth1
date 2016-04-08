//
//  LogInViewController.h
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : UIViewController

@property (strong, nonatomic)UIView *picView;

@property (strong, nonatomic)UIImageView *userNumberLogo;

@property (strong, nonatomic)UIImageView *passwordLogo;

@property (strong, nonatomic)UITextField *userNumberText;

@property (strong, nonatomic)UITextField *passwordText;

@property (strong, nonatomic)UIButton *registerBtn;

@property (strong, nonatomic)UIButton *logInBtn;

@property (strong, nonatomic)UIButton *forgetPassword;

@property (strong, nonatomic)UIButton *changePassword;

@property (strong, nonatomic)UILabel *userNumLine;

@property (strong, nonatomic)UILabel *passwordLine;

@end
