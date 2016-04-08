//
//  ShoppingCartTableViewCell.h
//  LoveHealth
//
//  Created by administrator on 16/4/7.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartTableViewCell : UITableViewCell

@property (strong,nonatomic)UIImageView *goodsImage; //商品图片

@property (strong,nonatomic)UILabel *goodsNameLabel; //商品名称

@property (strong,nonatomic)UILabel *goodsNum; //商品数量

@property (strong,nonatomic)UILabel *goodsPrice; //商品价格

@property (strong,nonatomic)UIButton *circleBtn; //圆框Button

@property (strong,nonatomic)UIButton *payBtn;

@property (assign,nonatomic)int t;


@end
