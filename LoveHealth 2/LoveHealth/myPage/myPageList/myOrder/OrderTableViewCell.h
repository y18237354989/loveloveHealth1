//
//  OrderTableViewCell.h
//  LoveHealth
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell

@property (strong, nonatomic)UIImageView *goodsImg;  //购买商品图片
@property (strong, nonatomic)UILabel *goodsName;  //购买商品名称
@property (strong, nonatomic)UILabel *orderNumber;  //订单号
@property (strong, nonatomic)UILabel *date;  //购买时间
@property (strong, nonatomic)UILabel *number;  //购买数量
@property (strong, nonatomic)UIButton *isPay; //付款状态
@property (strong, nonatomic)UIButton *comment; //评论

@end
