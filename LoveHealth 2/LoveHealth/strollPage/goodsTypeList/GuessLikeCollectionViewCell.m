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
        
        self.goodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 140, 140)];
        self.goodsImage.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:self.goodsImage];
        
        self.goodsName = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, 140, 30)];
        self.goodsName.textAlignment = NSTextAlignmentLeft;
        self.goodsName.font = [UIFont systemFontOfSize:12];
        self.goodsName.numberOfLines = 2;
        [self.contentView addSubview:self.goodsName];
        
        self.goodsPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 185, 90, 15)];
        self.goodsPriceLabel.textAlignment = NSTextAlignmentLeft;
        self.goodsPriceLabel.font = [UIFont systemFontOfSize:12];
        self.goodsPriceLabel.text = @"￥369";
        [self.contentView addSubview:self.goodsPriceLabel];
        
    }
    
    return self;
}

@end
