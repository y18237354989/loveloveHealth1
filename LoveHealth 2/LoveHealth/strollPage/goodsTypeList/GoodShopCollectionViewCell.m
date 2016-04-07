//
//  GoodShopCollectionViewCell.m
//  逛一逛Tableview
//
//  Created by Administrator on 16/3/31.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "GoodShopCollectionViewCell.h"

@implementation GoodShopCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.goodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 90, 90)];
        self.goodsImage.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:self.goodsImage];
        
        self.goodsName = [[UILabel alloc]initWithFrame:CGRectMake(0, 95, 90, 15)];
        self.goodsName.textAlignment = NSTextAlignmentLeft;
        self.goodsName.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.goodsName];
        
    }
    
    return self;
}

@end
