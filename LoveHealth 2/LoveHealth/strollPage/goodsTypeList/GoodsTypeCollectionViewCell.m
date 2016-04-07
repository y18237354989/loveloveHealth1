//
//  GoodsTypeCollectionViewCell.m
//  逛一逛Tableview
//
//  Created by Administrator on 16/3/31.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "GoodsTypeCollectionViewCell.h"

@implementation GoodsTypeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.goodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, 25, 40, 40)];
        //        self.goodsImage.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:self.goodsImage];
        
        self.goodsType = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, 60, 20)];
        self.goodsType.textAlignment = NSTextAlignmentCenter;
        self.goodsType.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.goodsType];
        
    }
    
    return self;
}

@end
