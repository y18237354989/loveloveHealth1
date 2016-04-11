//
//  ResendViewController.h
//  LoveHealth
//
//  Created by administrator on 16/4/9.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResendViewController : UIViewController


@property (strong, nonatomic)UITableView *resendTable;

@property (strong, nonatomic)UITextView *woreText; //输入框

@property (strong, nonatomic)UIButton *cancle;

@property (strong, nonatomic)UIButton *ok;

@property (copy, nonatomic)NSString *commentId; //评论Id

@end
