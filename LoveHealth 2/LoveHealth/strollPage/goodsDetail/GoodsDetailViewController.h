//
//  GoodsDetailViewController.h
//  逛一逛Tableview
//
//  Created by Administrator on 16/3/31.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsDetailViewController : UIViewController

@property (strong, nonatomic) UITableView *goodsDetail;

@property (strong, nonatomic) NSMutableArray *picArr; //评论图片

@property (strong, nonatomic)UIView *headView;  //放在tabelheaderView上
@property (strong, nonatomic)UIScrollView *headScroll;
@property (strong, nonatomic)UIImageView *headImage;
@property (strong, nonatomic)UILabel *goodsNameLabel;  //商品名label
@property (strong, nonatomic)UILabel *collectLabel;  //收藏label
@property (strong, nonatomic)UIButton *collectbtn;  //收藏image
@property (strong, nonatomic)UILabel *verticalLineLabel;  //垂直线label
@property (strong, nonatomic)UILabel *transervseLineLabel;  //横线label
@property (strong, nonatomic)UILabel *goodsPriceLabel;  //商品价格label
@property (strong, nonatomic)UILabel *goodsOldPriceLabel;  //商品原价label
@property (strong, nonatomic)UILabel *expressFeeLabel;  //快递费label
@property (strong, nonatomic)UILabel *saleLabel; //月销量label
@property (strong, nonatomic)UILabel *shopAddressLabel; //商家地址
@property (strong, nonatomic)UILabel *sizeSelectLabel;  //尺寸选择
@property (strong, nonatomic)UILabel *sellerPromiseLabel; //卖家承诺
@property (strong, nonatomic)UILabel *separateLineLabel; //灰色分割线
@property (strong, nonatomic)UILabel * evaluateLabel;  //评价

@property (strong, nonatomic)NSMutableDictionary *goodsDic;

@end
