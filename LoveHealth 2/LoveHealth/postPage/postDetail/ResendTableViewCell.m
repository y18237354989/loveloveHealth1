//
//  ResendTableViewCell.m
//  LoveHealth
//
//  Created by administrator on 16/4/9.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "ResendTableViewCell.h"
#import "Header.h"

@implementation ResendTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
     
     self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
          self.userhead = [[UIImageView alloc]init];
          self.userhead.layer.cornerRadius = 15;
          self.userhead.layer.masksToBounds = YES;
          [self.contentView addSubview:self.userhead];
          
          self.username = [[UILabel alloc]init];
          self.username.textAlignment = 0;
          [self.contentView addSubview:self.username];
          
          self.time = [[UILabel alloc]init];
          self.time.font = FONT(12);
          self.time.textColor = COLOR(150, 150, 150, 1);
          self.time.textAlignment = 2;
          [self.contentView addSubview:self.time];
          
          self.sendword = [[UILabel alloc]init];
          self.sendword.font = FONT(12);
          [self.contentView addSubview:self.sendword];
     }
     
     return self;
}

- (void)layoutSubviews{
     
     [super layoutSubviews];
     self.userhead.frame = CGRectMake(WIDTH5S(15), HEIGHT5S(10), WIDTH5S(30), HEIGHT5S(30));
     self.username.frame = CGRectMake(WIDTH5S(55), HEIGHT5S(15), WIDTH5S(100), HEIGHT5S(20));
     self.time.frame = CGRectMake(WIDTH5S(165), HEIGHT5S(15), WIDTH5S(140), HEIGHT5S(20));
     self.sendword.frame = CGRectMake(WIDTH5S(15), HEIGHT5S(50), WIDTH5S(290), HEIGHT5S(self.h));
     
}

-(void)setIntroductionText:(NSString *)text{
     
     CGRect frame = [self frame];
     
     self.sendword.text = text;
     self.sendword.font = FONT(12);
     
     CGRect textSize = [text boundingRectWithSize:CGSizeMake(WIDTH5S(290), HEIGHT5S(9999)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
     self.h = textSize.size.height;
     frame.size.height = self.h + HEIGHT5S(50);
     
     self.frame = frame;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
