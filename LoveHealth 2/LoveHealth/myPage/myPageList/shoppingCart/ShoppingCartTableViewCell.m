//
//  ShoppingCartTableViewCell.m
//  LoveHealth
//
//  Created by administrator on 16/4/7.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"
#import "Header.h"
@implementation ShoppingCartTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        self.circleBtn = [[UIButton alloc]init];
//        self.circleBtn.tag = 1001;
//        [self.circleBtn setImage:[UIImage imageNamed:@"check1.png"] forState:UIControlStateNormal];
//        self.circleBtn.adjustsImageWhenHighlighted = NO;//长按不让背景变灰
//        [self.circleBtn addTarget:self action:@selector(choose1) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:self.circleBtn];
        //商品图片
        self.goodsImage = [[UIImageView alloc]init];
        [self.contentView addSubview:self.goodsImage];
        //商品名称
        self.goodsNameLabel = [[UILabel alloc]init];
        self.goodsNameLabel.font = FONT(15);
        self.goodsNameLabel.textAlignment = NSTextAlignmentLeft;
        self.goodsNameLabel.numberOfLines = 0;
        [self.contentView addSubview:self.goodsNameLabel];
        //商品数量
        self.goodsNum = [[UILabel alloc]init];
        self.goodsNum.font = FONT(15);
        self.goodsNum.textAlignment = NSTextAlignmentRight;
        self.goodsNum.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.goodsNum];
        //商品价格
        self.goodsPrice = [[UILabel alloc]init];
        self.goodsPrice.font = FONT(15);
        self.goodsPrice.textAlignment = NSTextAlignmentLeft;
        self.goodsPrice.textColor = [UIColor redColor];
        [self.contentView addSubview:self.goodsPrice];
        //去付款
        self.payBtn = [[UIButton alloc]init];
        self.payBtn.titleLabel.font = FONT(13);
        [self.payBtn setTitle:@"去付款" forState:UIControlStateNormal];
        [self.payBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.payBtn];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
//    self.circleBtn.frame = CGRectMake(0, 0, 50, 100);
    
//    self.goodsImage.frame = CGRectMake(50, 5, 90, 90);
//    
//    self.goodsNameLabel.frame = CGRectMake(50+90+10, 5, SCREEN_WIDTH-160, 40);
//    
//    self.goodsNum.frame = CGRectMake(SCREEN_WIDTH-60, 70, 50, 20);
//    
//    self.goodsPrice.frame = CGRectMake(50+90+10, 70, 50, 20);
//    
//    self.payBtn.frame = CGRectMake(SCREEN_WIDTH-70, 40, 50, 20);
    
        self.goodsImage.frame = CGRectMake(10, 15, 50, 50);
    
        self.goodsNameLabel.frame = CGRectMake(50+10+10, 10, 160, 35);
    
        self.goodsNum.frame = CGRectMake(190, 47, 50, 20);
    
        self.goodsPrice.frame = CGRectMake(50+10+10, 47, 45, 20);
    
        self.payBtn.frame = CGRectMake(250, 30, 50, 20);
}

//- (void)choose1{
//    
//    
//    if (_t==0) {
//        [self.circleBtn setImage:[UIImage imageNamed:@"check2.png"] forState:UIControlStateNormal];
//        self.t++;
//    }else{
//        
//        [self.circleBtn setImage:[UIImage imageNamed:@"check1.png"] forState:UIControlStateNormal];
//        self.t = 0;
//    }
//    
//}


@end
