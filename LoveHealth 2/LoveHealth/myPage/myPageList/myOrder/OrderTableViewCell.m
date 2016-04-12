//
//  OrderTableViewCell.m
//  LoveHealth
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "Header.h"

@implementation OrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
     
     if (self) {
          self = [super  initWithStyle:style reuseIdentifier:reuseIdentifier];
          self.goodsImg = [[UIImageView alloc]init];
          self.goodsImg.layer.cornerRadius = 5;
          self.goodsImg.layer.masksToBounds = YES;
          [self.contentView addSubview:self.goodsImg];
          
          self.goodsName = [[UILabel alloc]init];
          self.goodsName.textAlignment = 0;
          self.goodsName.font = FONT(15);
          [self.contentView addSubview:self.goodsName];
          
          self.orderNumber = [[UILabel alloc]init];
          self.orderNumber.font = FONT(12);
          [self.contentView addSubview:self.orderNumber];
          
          self.date = [[UILabel alloc]init];
          self.date.font = FONT(12);
          [self.contentView addSubview:self.date];
          
          self.number = [[UILabel alloc]init];
          self.number.font = FONT(12);
          [self.contentView addSubview:self.number];
          
          self.isPay = [[UIButton alloc]init];
          self.isPay.titleLabel.font = FONT(15);
          [self.contentView addSubview:self.isPay];
          
          self.comment = [[UIButton alloc]init];
          [self.comment setTitle:@"评价" forState:UIControlStateNormal];
          [self.comment setTitleColor:COLOR(100, 100, 100, 1) forState:UIControlStateNormal];
          [self.contentView addSubview:self.comment];
          
          
     }
     
     return self;
}

- (void)layoutSubviews{
     
     [super layoutSubviews];
     self.goodsImg.frame = CGRectMake(15, 10, WIDTH5S(40), HEIGHT5S(40));
     self.goodsName.frame = CGRectMake(WIDTH5S(65), 10, WIDTH5S(180), HEIGHT5S(20));
     self.orderNumber.frame = CGRectMake(WIDTH5S(65), HEIGHT5S(35), WIDTH5S(180), HEIGHT5S(15));
     self.date.frame = CGRectMake(15, HEIGHT5S(60), WIDTH5S(100), HEIGHT5S(15));
     self.number.frame = CGRectMake(WIDTH5S(125), HEIGHT5S(60), WIDTH5S(60), HEIGHT5S(15));
     self.comment.frame = CGRectMake(WIDTH5S(255), HEIGHT5S(10), WIDTH5S(50), HEIGHT5S(25));
     self.isPay.frame = CGRectMake(WIDTH5S(255), HEIGHT5S(50), WIDTH5S(50), HEIGHT5S(25));
     
}

@end
