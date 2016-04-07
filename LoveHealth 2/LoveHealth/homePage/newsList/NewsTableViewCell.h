//
//  NewsTableViewCell.h
//  LoveHealth
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell

//新闻标题、时间、收藏图标、收藏数、评论图标、评论数、新闻图片无or1or多

@property (strong, nonatomic)UILabel *newsTitleLabel;
//无图
@property (strong, nonatomic)UILabel *dateLabel;
@property (strong, nonatomic)UIImageView *collectImage;
@property (strong, nonatomic)UILabel *collectNumLabel;
@property (strong, nonatomic)UIImageView *commentImage;
@property (strong, nonatomic)UILabel *commentNumLabel;
//一图
@property (strong, nonatomic)UILabel *dateLabel1;
@property (strong, nonatomic)UIImageView *collectImage1;
@property (strong, nonatomic)UILabel *collectNumLabel1;
@property (strong, nonatomic)UIImageView *commentImage1;
@property (strong, nonatomic)UILabel *commentNumLabel1;
@property (strong, nonatomic)UIImageView *newsImage1;
//多图
@property (strong, nonatomic)UILabel *dateLabel2;
@property (strong, nonatomic)UIImageView *collectImage2;
@property (strong, nonatomic)UILabel *collectNumLabel2;
@property (strong, nonatomic)UIImageView *commentImage2;
@property (strong, nonatomic)UILabel *commentNumLabel2;
@property (strong, nonatomic)UIImageView *newsImage2, *newsImage3, *newsImage4;
@end
