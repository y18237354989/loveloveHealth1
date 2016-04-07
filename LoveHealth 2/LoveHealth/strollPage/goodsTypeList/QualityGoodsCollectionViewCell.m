//
//  QualityGoodsCollectionViewCell.m
//  逛一逛Tableview
//
//  Created by Administrator on 16/3/31.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "QualityGoodsCollectionViewCell.h"

@implementation QualityGoodsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.goodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 100, 100)];
        self.goodsImage.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:self.goodsImage];
        
        self.goodsName = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, 100, 30)];
        self.goodsName.textAlignment = NSTextAlignmentLeft;
        self.goodsName.font = [UIFont systemFontOfSize:12];
         self.goodsName.numberOfLines = 2;
        [self.contentView addSubview:self.goodsName];
        
        self.goodsPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, 100, 15)];
        self.goodsPriceLabel.textAlignment = NSTextAlignmentLeft;
        self.goodsPriceLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.goodsPriceLabel];
        
    }
    
    return self;
}


@end
