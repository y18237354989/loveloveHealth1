//
//  MyOrderViewController.h
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderViewController : UIViewController

@property (strong, nonatomic)UITableView *orderTable;

@property (strong, nonatomic)UIButton *state1,*state2,*state3,*state4,*state5;  //订单状态

@property (strong, nonatomic)NSMutableArray *orderArr;  //订单数组

@property (strong, nonatomic)NSMutableDictionary *orderDic;  //订单信息字典

@property (assign, nonatomic)int num;  //每个订单所购买商品的数量

@property (strong, nonatomic)UIView *sendCommentView;  //发送评价
@property (strong, nonatomic)UIView *commentBackView;  //阴影view
@property (strong, nonatomic)UITextView *commentView;  //评价text
@property (strong, nonatomic)UIButton *sendComment;
@property (strong, nonatomic)UIButton *cancleComment;
@property (strong, nonatomic)UIButton *typebtn1,*typebtn2,*typebtn3,*typebtn4,*typebtn5,*typebtn6;  //6种评价

@end
