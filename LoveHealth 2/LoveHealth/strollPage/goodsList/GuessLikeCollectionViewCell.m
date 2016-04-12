//
//  GuessLikeCollectionViewCell.m
//  逛一逛Tableview
//
//  Created by Administrator on 16/3/31.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "GuessLikeCollectionViewCell.h"

@implementation GuessLikeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.goodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 157, 157)];
        self.goodsImage.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:self.goodsImage];
        
        self.goodsName = [[UILabel alloc]initWithFrame:CGRectMake(2, 160, 155, 30)];
        self.goodsName.textAlignment = NSTextAlignmentLeft;
        self.goodsName.font = [UIFont systemFontOfSize:12];
        self.goodsName.numberOfLines = 2;
        [self.contentView addSubview:self.goodsName];
        
        self.goodsPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 195, 60, 15)];
        self.goodsPriceLabel.textAlignment = NSTextAlignmentLeft;
        self.goodsPriceLabel.font = [UIFont systemFontOfSize:12];
        self.goodsPriceLabel.text = @"￥369.00";
        [self.contentView addSubview:self.goodsPriceLabel];
        
        self.goodsNum = [[UILabel alloc]initWithFrame:CGRectMake(100, 195, 40, 15)];
        self.goodsNum.textAlignment = NSTextAlignmentRight;
        self.goodsNum.font = [UIFont systemFontOfSize:12];
        self.goodsNum.text = @"10000";
        [self.contentView addSubview:self.goodsNum];
        
        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(60, 195, 40, 15)];
        self.label1.textAlignment = NSTextAlignmentRight;
        self.label1.font = [UIFont systemFontOfSize:12];
        self.label1.text = @"已售出";
        [self.contentView addSubview:self.label1];
        
        self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(140, 195, 15, 15)];
        self.label2.textAlignment = NSTextAlignmentLeft;
        self.label2.font = [UIFont systemFontOfSize:12];
        self.label2.text = @"件";
        [self.contentView addSubview:self.label2];
        
        
    }
    
    return self;
}

@end
