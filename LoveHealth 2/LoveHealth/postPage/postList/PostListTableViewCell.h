//
//  PostListTableViewCell.h
//  LoveHealth
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostListTableViewCell : UITableViewCell

@property (strong, nonatomic)UIImageView *userImg;  //用户头像

@property (strong, nonatomic)UILabel *userName;  //用户名

@property (strong, nonatomic)UILabel *date;  //发帖日期

//无图
@property (strong, nonatomic)UILabel *postTitle;
@property (strong, nonatomic)UILabel *tagLabel;  //标签
@property (strong, nonatomic)UIImageView *commentImg;
@property (strong, nonatomic)UILabel *comNum;  //评论数
@property (strong, nonatomic)UIImageView *collectImg;
@property (strong, nonatomic)UILabel *colNum;  //收藏数
@property (strong, nonatomic)UILabel *line;  //分割线

//一图
@property (strong, nonatomic)UILabel *postTitle1;
@property (strong, nonatomic)UILabel *tagLabel1;  //标签
@property (strong, nonatomic)UIImageView *commentImg1;
@property (strong, nonatomic)UILabel *comNum1;  //评论数
@property (strong, nonatomic)UIImageView *collectImg1;
@property (strong, nonatomic)UILabel *colNum1;  //收藏数
@property (strong, nonatomic)UILabel *line1;  //分割线
@property (strong, nonatomic)UIImageView *img;


@end
