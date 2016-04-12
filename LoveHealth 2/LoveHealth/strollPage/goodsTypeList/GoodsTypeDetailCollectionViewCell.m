//
//  GoodsTypeDetailCollectionViewCell.m
//  LoveHealth
//
//  Created by Administrator on 16/4/12.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "GoodsTypeDetailCollectionViewCell.h"

@implementation GoodsTypeDetailCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.goodsImage = [[UIImageView alloc]init];
        self.goodsImage.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:self.goodsImage];
        
        self.goodsName = [[UILabel alloc]init];
        self.goodsName.textAlignment = NSTextAlignmentLeft;
        self.goodsName.font = [UIFont systemFontOfSize:15];
        self.goodsName.numberOfLines = 2;
        [self.contentView addSubview:self.goodsName];
        
        self.goodsPriceLabel = [[UILabel alloc]init];
        self.goodsPriceLabel.textAlignment = NSTextAlignmentLeft;
        self.goodsPriceLabel.font = [UIFont systemFontOfSize:15];
        self.goodsPriceLabel.text = @"￥369.00";
        [self.contentView addSubview:self.goodsPriceLabel];

        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.goodsImage.frame = CGRectMake(0, 0, 100, 100);
    self.goodsName.frame = CGRectMake(105, 5, 200, 40);
    self.goodsPriceLabel.frame = CGRectMake(105, 80, 70, 18);
}

@end
