//
//  PostDetailViewController.h
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface PostDetailViewController : UIViewController

//tableHeadView上
@property (strong, nonatomic)UILabel *postTitle;

@property (strong, nonatomic)UIImageView *userImg;

@property (strong, nonatomic)UILabel *userName;

@property (strong, nonatomic)UILabel *date;

@property (strong, nonatomic)UILabel *tagLabel;

@property (strong, nonatomic)UILabel *line;

@property (strong, nonatomic)UIImageView *img;

@property (strong, nonatomic)UITextView *postText;  //帖子内容

//table上（评论）
@property (strong, nonatomic)UITableView *postDetailTable;

//底部评论栏
@property (strong, nonatomic)UIView *commentView;
@property (strong, nonatomic)UITextField *text;
@property (strong, nonatomic)UIButton *send;
@property (strong, nonatomic)UIButton *collect;

@property (strong,nonatomic)NSString *str;

@end
