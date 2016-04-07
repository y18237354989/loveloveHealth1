//
//  GoodsDetailTableViewCell.m
//  LoveHealth
//
//  Created by administrator on 16/4/1.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "GoodsDetailTableViewCell.h"
#import "Header.h"

@implementation GoodsDetailTableViewCell

- (void)awakeFromNib {
     
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
     [super setSelected:selected animated:animated];
     
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
     
     if (self) {
          self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
          
          self.userImage = [[UIImageView alloc]init];
          self.userImage.layer.cornerRadius = 15;
          [self.contentView addSubview:self.userImage];
          
          self.userName = [[UILabel alloc]init];
          self.userName.font = FONT(13);
          self.userName.textAlignment = 0;
          [self.contentView addSubview:self.userName];
          
          self.commentLabel = [[UILabel alloc]init];
          self.commentLabel.font = FONT(12);
          self.commentLabel.textAlignment = 0;
          [self.contentView addSubview:self.commentLabel];
          
          if ([reuseIdentifier isEqualToString:@"nilPic"]) {
               self.dateLabel = [[UILabel alloc]init];
               self.dateLabel.font = FONT(12);
               self.dateLabel.textAlignment = 0;
               [self.contentView addSubview:self.dateLabel];
               
          }else if ([reuseIdentifier isEqualToString:@"havePic"]){
               
               self.dateLabel1 = [[UILabel alloc]init];
               self.dateLabel1.font = FONT(12);
               self.dateLabel1.textAlignment = 0;
               [self.contentView addSubview:self.dateLabel1];
               
               self.imageOne = [[UIImageView alloc]init];
               [self.contentView addSubview:self.imageOne];
               self.imageTwo = [[UIImageView alloc]init];
               [self.contentView addSubview:self.imageTwo];
               self.imageThree = [[UIImageView alloc]init];
               [self.contentView addSubview:self.imageThree];
          }
          
     }
     
     return self;
}

- (void)layoutSubviews{
     
     [super layoutSubviews];
     
     self.userImage.frame = CGRectMake(15, 10, WIDTH5S(30), HEIGHT5S(30));
     self.userName.frame = CGRectMake(WIDTH5S(55), HEIGHT5S(15), WIDTH5S(150), HEIGHT5S(20));
     self.commentLabel.frame = CGRectMake(15, HEIGHT5S(50), WIDTH5S(290), _h);
     
     //无图时
     self.dateLabel.frame = CGRectMake(WIDTH5S(205), HEIGHT5S(15), WIDTH5S(100), HEIGHT5S(20));
     
     //有图时
     self.imageOne.frame = CGRectMake(15, HEIGHT5S(60+_h), WIDTH5S(40), HEIGHT5S(40));
     self.imageTwo.frame = CGRectMake(WIDTH5S(65), HEIGHT5S(60+_h), WIDTH5S(40), HEIGHT5S(40));
     self.imageThree.frame = CGRectMake(WIDTH5S(115), HEIGHT5S(60+_h), WIDTH5S(40), HEIGHT5S(40));
     self.dateLabel.frame = CGRectMake(WIDTH5S(205), HEIGHT5S(15), WIDTH5S(100), HEIGHT5S(20));
     
}

- (void)setIntroductionText:(NSString *)text{
     
     CGRect frame = [self frame];
     
     self.commentLabel.text = text;
     self.commentLabel.font = FONT(12);
     
     CGRect textSize = [text boundingRectWithSize:CGSizeMake(WIDTH5S(290), 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT(12)} context:nil];
     
     _h = textSize.size.height;
     if (self.imageOne) {
          frame.size.height = textSize.size.height + WIDTH5S(135);
     }else{
          frame.size.height = textSize.size.height + WIDTH5S(85);
     }
     
     self.frame = frame;
}

@end
