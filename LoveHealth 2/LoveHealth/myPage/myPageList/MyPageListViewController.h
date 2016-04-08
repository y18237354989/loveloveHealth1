//
//  MyPageListViewController.h
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPageListViewController : UIViewController

@property (strong, nonatomic)UIView *bgView;

@property (strong, nonatomic)UIImageView *bgImage;

@property (strong, nonatomic)UITableView *myTable;

@property (strong, nonatomic)UIImageView *userHeadImage;  //用户头像

@property (strong, nonatomic)UIButton *registerBtn;  //注册

@property (strong, nonatomic)UIButton *logInBtn;  //登录

@end
