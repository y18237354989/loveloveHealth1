//
//  NewsTableViewCell.m
//  LoveHealth
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "Header.h"

@implementation NewsTableViewCell


- (void)awakeFromNib {
     
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
     [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
     
     if (self) {
          
          self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
          //新闻标题
          self.newsTitleLabel = [[UILabel alloc]init];
          self.newsTitleLabel.font = FONT(15.0);
          [self.contentView addSubview:self.newsTitleLabel];
          
          
          if ([reuseIdentifier isEqualToString:@"nilPic"]) {
               //时间
               self.dateLabel = [[UILabel alloc]init];
               self.dateLabel.font = FONT(12.0);
               [self.contentView addSubview:self.dateLabel];
               
               self.collectImage = [[UIImageView alloc]init];
               [self.contentView addSubview:self.collectImage];
               //新闻收藏数
               self.collectNumLabel = [[UILabel alloc]init];
               self.collectNumLabel.font = FONT(12.0);
               self.collectNumLabel.textAlignment = 2;
               [self.contentView addSubview:self.collectNumLabel];
               
               self.commentImage = [[UIImageView alloc]init];
               [self.contentView addSubview:self.commentImage];
               //新闻评论数
               self.commentNumLabel = [[UILabel alloc]init];
               self.commentNumLabel.font = FONT(12.0);
               self.commentNumLabel.textAlignment = 2;
               [self.contentView addSubview:self.commentNumLabel];
          }else if ([reuseIdentifier isEqualToString:@"onePic"]) {
               //时间
               self.dateLabel1 = [[UILabel alloc]init];
               self.dateLabel1.font = FONT(12.0);
               [self.contentView addSubview:self.dateLabel1];
               
               self.collectImage1 = [[UIImageView alloc]init];
               [self.contentView addSubview:self.collectImage1];
               //新闻收藏数
               self.collectNumLabel1 = [[UILabel alloc]init];
               self.collectNumLabel1.font = FONT(12.0);
               self.collectNumLabel1.textAlignment = 2;
               [self.contentView addSubview:self.collectNumLabel1];
               
               self.commentImage1 = [[UIImageView alloc]init];
               [self.contentView addSubview:self.commentImage1];
               //新闻评论数
               self.commentNumLabel1 = [[UILabel alloc]init];
               self.commentNumLabel1.font = FONT(12.0);
               self.commentNumLabel1.textAlignment = 2;
               [self.contentView addSubview:self.commentNumLabel1];
               //新闻图片
               self.newsImage1 = [[UIImageView alloc]init];
               [self.contentView addSubview:self.newsImage1];
          }else if ([reuseIdentifier isEqualToString:@"manyPic"]) {
               //时间
               self.dateLabel2 = [[UILabel alloc]init];
               self.dateLabel2.font = FONT(12.0);
               [self.contentView addSubview:self.dateLabel2];
               
               self.collectImage2 = [[UIImageView alloc]init];
               [self.contentView addSubview:self.collectImage2];
               //新闻收藏数
               self.collectNumLabel2 = [[UILabel alloc]init];
               self.collectNumLabel2.font = FONT(12.0);
               self.collectNumLabel2.textAlignment = 2;
               [self.contentView addSubview:self.collectNumLabel2];
               
               self.commentImage2 = [[UIImageView alloc]init];
               [self.contentView addSubview:self.commentImage2];
               //新闻评论数
               self.commentNumLabel2 = [[UILabel alloc]init];
               self.commentNumLabel2.font = FONT(12.0);
               self.commentNumLabel2.textAlignment = 2;
               [self.contentView addSubview:self.commentNumLabel2];
               //新闻图片
               self.newsImage2 = [[UIImageView alloc]init];
               [self.contentView addSubview:self.newsImage2];
               
               //新闻图片
               self.newsImage2 = [[UIImageView alloc]init];
               [self.contentView addSubview:self.newsImage2];
               self.newsImage3 = [[UIImageView alloc]init];
               [self.contentView addSubview:self.newsImage3];
               self.newsImage4 = [[UIImageView alloc]init];
               [self.contentView addSubview:self.newsImage4];
          }
          
          
     }
     
     return self;
}

-(void)layoutSubviews{
     
     [super layoutSubviews];
     self.newsTitleLabel.frame = CGRectMake(15, 10, WIDTH5S(290), HEIGHT5S(18));
     
     //无图时
     self.dateLabel.frame = CGRectMake(15, 55, WIDTH5S(80), HEIGHT5S(15));
     self.collectImage.frame = CGRectMake(225, 55, WIDTH5S(15), HEIGHT5S(15));
     self.collectNumLabel.frame = CGRectMake(185, 55, WIDTH5S(35), HEIGHT5S(15));
     self.commentImage.frame = CGRectMake(290, 55, WIDTH5S(15), HEIGHT5S(15));
     self.commentNumLabel.frame = CGRectMake(250, 55, WIDTH5S(35), HEIGHT5S(15));
     
     //一图时
     self.dateLabel1.frame = CGRectMake(15, 55, WIDTH5S(80), HEIGHT5S(15));
     self.collectImage1.frame = CGRectMake(125, 55, WIDTH5S(15), HEIGHT5S(15));
     self.collectNumLabel1.frame = CGRectMake(85, 55, WIDTH5S(35), HEIGHT5S(15));
     self.commentImage1.frame = CGRectMake(190, 55, WIDTH5S(15), HEIGHT5S(15));
     self.commentNumLabel1.frame = CGRectMake(150, 55, WIDTH5S(35), HEIGHT5S(15));
     self.newsImage1.frame = CGRectMake(215, 10, WIDTH5S(90), HEIGHT5S(60));
     
     //多图时
     self.dateLabel2.frame = CGRectMake(15, 108, WIDTH5S(80), HEIGHT5S(15));
     self.collectImage2.frame = CGRectMake(225, 108, WIDTH5S(15), HEIGHT5S(15));
     self.collectNumLabel2.frame = CGRectMake(185, 108, WIDTH5S(35), HEIGHT5S(15));
     self.commentImage2.frame = CGRectMake(290, 108, WIDTH5S(15), HEIGHT5S(15));
     self.commentNumLabel2.frame = CGRectMake(250, 108, WIDTH5S(35), HEIGHT5S(15));
     self.newsImage2.frame = CGRectMake(15, 38, WIDTH5S(90), HEIGHT5S(60));
     self.newsImage3.frame = CGRectMake(115, 38, WIDTH5S(90), HEIGHT5S(60));
     self.newsImage4.frame = CGRectMake(215, 38, WIDTH5S(90), HEIGHT5S(60));
}

@end


