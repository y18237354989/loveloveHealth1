//
//  PostListTableViewCell.m
//  LoveHealth
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "PostListTableViewCell.h"
#import "Header.h"

@implementation PostListTableViewCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
     
     if (self) {
          self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
          
          self.userImg = [[UIImageView alloc]init];
          self.userImg.layer.cornerRadius = 10;
          self.userImg.layer.masksToBounds = YES;
          [self.contentView addSubview:self.userImg];
          
          self.userName = [[UILabel alloc]init];
          self.userName.font = FONT(12);
          self.userName.textAlignment = 0;
          [self.contentView addSubview:self.userName];
          
          self.date = [[UILabel alloc]init];
          self.date.font = FONT(12);
          self.date.textAlignment = 2;
          self.date.textColor = COLOR(150, 150, 150, 1);
          [self.contentView addSubview:self.date];
          
          
          //无图时
          if ([reuseIdentifier isEqualToString:@"nilPic"]) {
               
               self.postTitle = [[UILabel alloc]init];
               self.postTitle.font = FONT(15);
               self.postTitle.textAlignment = 0; //文字居左
               [self.contentView addSubview:self.postTitle];
               
               self.tagLabel = [[UILabel alloc]init];
               self.tagLabel.backgroundColor = COLOR(204, 255, 255, 1);
               self.tagLabel.layer.cornerRadius = 5;
               self.tagLabel.layer.masksToBounds = YES;
               self.tagLabel.font = FONT(12);
               self.tagLabel.textAlignment = 1; //文字居中
               [self.contentView addSubview:self.tagLabel];
               
               self.commentImg = [[UIImageView alloc]init];
               self.commentImg.layer.cornerRadius = 9;
               self.commentImg.layer.masksToBounds = YES;
               [self.contentView addSubview:self.commentImg];
               
               self.comNum = [[UILabel alloc]init];
               self.comNum.textAlignment = 0; //文字居左
               self.comNum.font = FONT(12);
               [self.contentView addSubview:self.comNum];
               
               self.collectImg = [[UIImageView alloc]init];
               self.collectImg.layer.cornerRadius = 9;
               self.collectImg.layer.masksToBounds = YES;
               [self.contentView addSubview:self.collectImg];
               
               self.colNum = [[UILabel alloc]init];
               self.colNum.textAlignment = 2; //文字居右
               self.colNum.font = FONT(12);
               [self.contentView addSubview:self.colNum];
               
               self.line = [[UILabel alloc]init];
               self.line.backgroundColor = COLOR(228, 228, 228, 1);
               [self.contentView addSubview:self.line];
          }
          
          //有图时
          if ([reuseIdentifier isEqualToString:@"havePic"]) {
               
               self.postTitle1 = [[UILabel alloc]init];
               self.postTitle1.font = FONT(15);
               self.postTitle1.textAlignment = 0; //文字居左
               [self.contentView addSubview:self.postTitle1];
               
               self.tagLabel1 = [[UILabel alloc]init];
               self.tagLabel1.backgroundColor = COLOR(204, 255, 255, 1);
               self.tagLabel1.layer.cornerRadius = 5;
               self.tagLabel1.layer.masksToBounds = YES;
               self.tagLabel1.font = FONT(12);
               self.tagLabel1.textAlignment = 1; //文字居中
               [self.contentView addSubview:self.tagLabel1];
               
               
               self.commentImg1 = [[UIImageView alloc]init];
               self.commentImg1.layer.cornerRadius = 9;
               self.commentImg1.layer.masksToBounds = YES;
               [self.contentView addSubview:self.commentImg1];
               
               self.comNum1 = [[UILabel alloc]init];
               self.comNum1.textAlignment = 0; //文字居左
               self.comNum1.font = FONT(12);
               [self.contentView addSubview:self.comNum1];
               
               self.collectImg1 = [[UIImageView alloc]init];
               self.collectImg1.layer.cornerRadius = 9;
               self.collectImg1.layer.masksToBounds = YES;
               [self.contentView addSubview:self.collectImg1];
               
               self.colNum1 = [[UILabel alloc]init];
               self.colNum1.textAlignment = 2; //文字居右
               self.colNum1.font = FONT(12);
               [self.contentView addSubview:self.colNum1];
               
               self.line1 = [[UILabel alloc]init];
               self.line1.backgroundColor = COLOR(228, 228, 228, 1);
               [self.contentView addSubview:self.line1];
               
               self.img = [[UIImageView alloc]init];
               [self.contentView addSubview:self.img];
          }
          
     }
     
     return self;
}

- (void)layoutSubviews{
     
     [super layoutSubviews];
     
     self.userImg.frame = CGRectMake(15, 10, WIDTH5S(30), HEIGHT5S(30));
     self.userName.frame = CGRectMake(WIDTH5S(55), HEIGHT5S(15), WIDTH5S(100), HEIGHT5S(20));
     self.date.frame = CGRectMake(WIDTH5S(205), HEIGHT5S(15), WIDTH5S(100), HEIGHT5S(20));
    
     //无图时
      self.postTitle.frame = CGRectMake(WIDTH5S(15), HEIGHT5S(50), WIDTH5S(250), HEIGHT5S(20));
     self.tagLabel.frame = CGRectMake(15, HEIGHT5S(82), WIDTH5S(30), HEIGHT5S(18));
     self.commentImg.frame = CGRectMake(WIDTH5S(219), HEIGHT5S(82), WIDTH5S(18), HEIGHT5S(18));
     self.comNum.frame = CGRectMake(WIDTH5S(179), HEIGHT5S(82), WIDTH5S(35), HEIGHT5S(18));
     self.collectImg.frame = CGRectMake(WIDTH5S(287), HEIGHT5S(82), WIDTH5S(18), HEIGHT5S(18));
     self.colNum.frame = CGRectMake(WIDTH5S(247), HEIGHT5S(82), WIDTH5S(35), HEIGHT5S(15));
     self.line.frame = CGRectMake(WIDTH5S(15), HEIGHT5S(109), WIDTH5S(290), HEIGHT5S(1));
     
     //有图时
      self.postTitle1.frame = CGRectMake(WIDTH5S(15), HEIGHT5S(50), WIDTH5S(165), HEIGHT5S(18));
     self.tagLabel1.frame = CGRectMake(15, HEIGHT5S(102), WIDTH5S(30), HEIGHT5S(18));
     self.commentImg1.frame = CGRectMake(WIDTH5S(219), HEIGHT5S(102), WIDTH5S(18), HEIGHT5S(18));
     self.comNum1.frame = CGRectMake(WIDTH5S(179), HEIGHT5S(102), WIDTH5S(35), HEIGHT5S(18));
     self.collectImg1.frame = CGRectMake(WIDTH5S(287), HEIGHT5S(102), WIDTH5S(18), HEIGHT5S(18));
     self.colNum1.frame = CGRectMake(WIDTH5S(247), HEIGHT5S(102), WIDTH5S(35), HEIGHT5S(15));
     self.line1.frame = CGRectMake(WIDTH5S(15), HEIGHT5S(129), WIDTH5S(290), HEIGHT5S(1));
     self.img.frame = CGRectMake(WIDTH5S(245), HEIGHT5S(50), WIDTH5S(60), HEIGHT5S(40));
     
}


@end
