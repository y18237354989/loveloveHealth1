//
//  GoodsDetailTableViewCell.h
//  LoveHealth
//
//  Created by administrator on 16/4/1.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsDetailTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *userImage;  //用户头像

@property (strong, nonatomic) UILabel *userName;  //用户名

@property (strong, nonatomic) UILabel *commentLabel;  //评论内容

@property (strong, nonatomic) UILabel *dateLabel;  //评论时间(无图)
@property (strong, nonatomic) UILabel *dateLabel1;  //（有图）

@property (strong, nonatomic) UIImageView *imageOne;  //comment附图
@property (strong, nonatomic) UIImageView *imageTwo;
@property (strong, nonatomic) UIImageView *imageThree;

@property (assign, nonatomic) double h;  //评论内容label高度

-(void)setIntroductionText:(NSString *)text;

@end
