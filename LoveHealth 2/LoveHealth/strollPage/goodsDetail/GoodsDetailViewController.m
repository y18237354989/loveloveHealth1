//
//  GoodsDetailViewController.m
//  逛一逛Tableview
//
//  Created by Administrator on 16/3/31.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "Header.h"
#import "GoodsDetailTableViewCell.h"
#import <RongIMKit/RongIMKit.h>
#import "MyOrderViewController.h"
#import "MJRefresh.h"
#import "GoodsServerceViewController.h"

@interface GoodsDetailViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>



@property (strong,nonatomic)UIView *bottomView;
@property (strong,nonatomic)UIButton *serviceBtn; //客服按钮
@property (strong,nonatomic)UIButton *shopBtn;  //店铺按钮
@property (strong,nonatomic)UIButton *buyBtn;  //立即购买按钮
@property (strong,nonatomic)UILabel *label;  //底部分隔线
@property (strong,nonatomic)UILabel *assess1, *assess2, *assess3, *assess4, *assess5, *assess6;  //评价类
@property (strong,nonatomic)NSMutableArray *allArr;  //累计评论数
@property (strong,nonatomic)NSMutableArray *typeArr1, *typeArr2, *typeArr3, *typeArr4, *typeArr5, *typeArr6;
@property (assign, nonatomic)float height;  //评论label高度

@property (strong,nonatomic)UIView *backGroundView; //背景灰色（透明度）
@property (strong,nonatomic)UIView *buyView;  //购买
@property (assign,nonatomic)int numberHave;  //商品库存数量
@property (assign,nonatomic)int number;  //添加商品数量（直接购买）
@property (strong,nonatomic)UILabel *cartNum;  //购物车添加数量
@property (strong,nonatomic)UILabel *buyNum;  //直接支付数量

@property (strong,nonatomic)GoodsDetailViewController *goodsDv;

@property (assign,nonatomic)int i;

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     self.navigationItem.title = @"商品详情";
     self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
     self.view.backgroundColor = [UIColor whiteColor];
     
     self.goodsDetail = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(504)) style:UITableViewStyleGrouped];
     self.goodsDetail.dataSource = self;
     self.goodsDetail.delegate = self;
     [self.view addSubview:self.goodsDetail];
     
     self.goodsDetail.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(561))];
     [self.goodsDetail addSubview:self.goodsDetail.tableHeaderView];
     
     self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(561))];
     self.headView.backgroundColor = COLOR(255, 255, 255, 1);
     [self.goodsDetail.tableHeaderView addSubview:self.headView];
     
     self.picArr = [NSMutableArray arrayWithCapacity:0];
//     self.goodsDic = [NSMutableDictionary dictionaryWithCapacity:0];
     
     [self createHeadScroll];
     [self createOtherPart];
     [self createBottomView];
     [self createShopBuy];
     
     self.i = 1;
     
     
     //刷新评论列表
     self.goodsDetail.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
          self.i = self.i +3;
          [self.goodsDetail reloadData];
          [self.goodsDetail.mj_footer endRefreshing];
          if (self.i>5) {
               self.i = 5;
               [self.goodsDetail reloadData];
               [self.goodsDetail.mj_footer endRefreshingWithNoMoreData];
          }
     }];
     
}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}

//定义顶部Scroll
-(void)createHeadScroll{
     
     self.headScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(200))];
     self.headScroll.contentSize = CGSizeMake(SCREEN_WIDTH*4, HEIGHT5S(200));
     self.headScroll.showsVerticalScrollIndicator = NO;//是否显示竖向滚动条
     self.headScroll.showsHorizontalScrollIndicator = NO;//是否显示横向滚动条
     self.headScroll.pagingEnabled = YES;//是否设置分页
     [self.headView addSubview:self.headScroll];
     
     for (int i = 0; i<4; i++) {
          self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, HEIGHT5S(200))];
          self.headImage.image = [UIImage imageNamed:@"1.jpg"];
          [self.headScroll addSubview:self.headImage];
     }
     
}
//创建底部view
-(void)createBottomView{
     
     //    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 519, 320, 49)];
     //    [self.view addSubview:self.bottomView];
     
     self.serviceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, HEIGHT5S(519), WIDTH5S(60), HEIGHT5S(49))];
     self.serviceBtn.backgroundColor = COLOR(228, 228, 228, 1);
     [self.serviceBtn setImage:[UIImage imageNamed:@"shop"] forState:UIControlStateNormal];
     [self.serviceBtn setImageEdgeInsets:UIEdgeInsetsMake(-15, 0, 0, -20)];
     [self.serviceBtn setTitle:@"客服" forState:UIControlStateNormal];
     self.serviceBtn.titleLabel.font = FONT(10);
     [self.serviceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [self.serviceBtn setTitleEdgeInsets:UIEdgeInsetsMake(20, -24, 0, 0)];
     self.serviceBtn.tag = 1;
     [self.serviceBtn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:self.serviceBtn];
     
     self.shopBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(60), HEIGHT5S(519), WIDTH5S(60), HEIGHT5S(49))];
     self.shopBtn.backgroundColor = COLOR(228, 228, 228, 1);
     [self.shopBtn setImage:[UIImage imageNamed:@"shop"] forState:UIControlStateNormal];
     [self.shopBtn setImageEdgeInsets:UIEdgeInsetsMake(-15, 0, 0, -20)];
     [self.shopBtn setTitle:@"店铺" forState:UIControlStateNormal];
     self.shopBtn.titleLabel.font = FONT(10);
     [self.shopBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [self.shopBtn setTitleEdgeInsets:UIEdgeInsetsMake(20, -24, 0, 0)];
     self.shopBtn.tag = 2;
     [self.shopBtn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:self.shopBtn];
     
     self.buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(120), HEIGHT5S(519), WIDTH5S(200), HEIGHT5S(49))];
     self.buyBtn.backgroundColor = COLOR(0, 210, 210, 1);
     [self.buyBtn setTitle:@"添加订单" forState:UIControlStateNormal];
     self.buyBtn.tag = 3;
     [self.buyBtn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:self.buyBtn];
     
     self.label = [[UILabel alloc]initWithFrame:CGRectMake(60, 519, 1, 49)];
     self.label.backgroundColor = [UIColor grayColor];
     [self.view addSubview:self.label];
     
}

-(void)createOtherPart{
     
     self.goodsNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(210), WIDTH5S(140), HEIGHT5S(30))];
     self.goodsNameLabel.textAlignment = NSTextAlignmentLeft;
     self.goodsNameLabel.text = [self.goodsDic objectForKey:@"name"];
     [self.headView addSubview:self.goodsNameLabel];
     
     self.collectLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40, HEIGHT5S(236), WIDTH5S(30), HEIGHT5S(18))];
     self.collectLabel.textAlignment = NSTextAlignmentCenter;
     self.collectLabel.text =@"收藏";
     self.collectLabel.font = FONT(10);
     [self.headView addSubview:self.collectLabel];
     
     self.collectbtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-38, HEIGHT5S(211), WIDTH5S(24), HEIGHT5S(24))];
     self.collectbtn.layer.cornerRadius = 12;
     self.collectbtn.layer.masksToBounds = YES;
     [self.collectbtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
     [self.collectbtn addTarget:self action:@selector(collectbtnClick) forControlEvents:UIControlEventTouchUpInside];
     [self.headView addSubview:self.collectbtn];
     
     self.verticalLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, HEIGHT5S(210), WIDTH5S(1), HEIGHT5S(40))];
     self.verticalLineLabel.backgroundColor = COLOR(228, 228, 228, 1);
     [self.goodsDetail.tableHeaderView addSubview:self.verticalLineLabel];
     
     self.transervseLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(257), SCREEN_WIDTH, HEIGHT5S(1))];
     self.transervseLineLabel.backgroundColor = COLOR(228, 228, 228, 1);
     [self.headView addSubview:self.transervseLineLabel];
     
     self.goodsPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(267), WIDTH5S(100), HEIGHT5S(23))];
     self.goodsPriceLabel.textAlignment = NSTextAlignmentLeft;
     self.goodsPriceLabel.textColor = COLOR(150, 150, 150, 1);
     self.goodsPriceLabel.font = FONT(15);
     self.goodsPriceLabel.text = @"￥998";
     [self.headView addSubview:self.goodsPriceLabel];
     
     self.goodsOldPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(291), WIDTH5S(81), HEIGHT5S(18))];
     self.goodsOldPriceLabel.textAlignment = NSTextAlignmentLeft;
     self.goodsOldPriceLabel.textColor = COLOR(148, 148, 148, 1);
     self.goodsOldPriceLabel.text = @"价格：￥1099";
     self.goodsOldPriceLabel.font = FONT(12);
     [self.headView addSubview:self.goodsOldPriceLabel];
     
     self.expressFeeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(312), WIDTH5S(60), HEIGHT5S(18))];
     self.expressFeeLabel.textAlignment = NSTextAlignmentLeft;
     self.expressFeeLabel.textColor = COLOR(148, 148, 148, 1);
     self.expressFeeLabel.text = @"快递：0";
     self.expressFeeLabel.font = FONT(12);
     [self.headView addSubview:self.expressFeeLabel];
     
     self.saleLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(120), HEIGHT5S(312), WIDTH5S(110), HEIGHT5S(18))];
     self.saleLabel.textAlignment = NSTextAlignmentCenter;
     self.saleLabel.textColor = COLOR(148, 148, 148, 1);
     self.saleLabel.text = @"月销售量265件";
     self.saleLabel.font = FONT(12);
     [self.headView addSubview:self.saleLabel];
     
     self.shopAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(247), HEIGHT5S(312), WIDTH5S(63), HEIGHT5S(18))];
     self.shopAddressLabel.textAlignment = NSTextAlignmentCenter;
     self.shopAddressLabel.textColor = COLOR(148, 148, 148, 1);
     self.shopAddressLabel.text = @"河北 保定";
     self.shopAddressLabel.font = FONT(12);
     [self.headView addSubview:self.shopAddressLabel];
     
     self.sizeSelectLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(340), SCREEN_WIDTH, HEIGHT5S(40))];
     self.sizeSelectLabel.textColor = COLOR(188, 188, 188, 1);
     self.sizeSelectLabel.font = FONT(12);
     self.sizeSelectLabel.text = @"    点击选择商品款型、颜色";
     self.sizeSelectLabel.textAlignment = NSTextAlignmentLeft;
     [self.headView addSubview:self.sizeSelectLabel];
     
     UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
     line.backgroundColor = COLOR(228, 228, 228, 1);
     [self.sizeSelectLabel addSubview:line];
     
     self.sellerPromiseLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(380), SCREEN_WIDTH, HEIGHT5S(40))];
     self.sellerPromiseLabel.textAlignment = NSTextAlignmentLeft;
     self.sellerPromiseLabel.backgroundColor = COLOR(228, 228, 228, 1);
     self.sellerPromiseLabel.textColor = COLOR(188, 188, 188, 1);
     self.sellerPromiseLabel.font = FONT(12);
     self.sellerPromiseLabel.text = @"    卖家承诺20小时内发货";
     [self.headView addSubview:self.sellerPromiseLabel];
     
     self.separateLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(420), SCREEN_WIDTH, HEIGHT5S(20))];
     self.separateLineLabel.backgroundColor = COLOR(201, 201, 201, 1);
     [self.headView addSubview:self.separateLineLabel];
     
     //获取6种评价次数
     NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
     NSArray *typeArr = [user objectForKey:@"typeComment"];
     self.evaluateLabel =[[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(441), WIDTH5S(110), HEIGHT5S(30))];
     self.evaluateLabel.textColor = COLOR(150, 150, 150, 1);
     self.evaluateLabel.font = FONT(12);
     self.evaluateLabel.textAlignment = NSTextAlignmentLeft;
     self.evaluateLabel.text = @"宝贝评价(999)";
     [self.headView addSubview:self.evaluateLabel];
     
     self.assess1 = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(481), WIDTH5S(90), HEIGHT5S(30))];
     self.assess1.font = FONT(12);
     self.assess1.layer.cornerRadius = 5;
     self.assess1.layer.masksToBounds = YES;
     self.assess1.backgroundColor = COLOR(100, 255, 255, 1);
     self.assess1.textColor = COLOR(150, 150, 150, 1);
     self.assess1.text = [NSString stringWithFormat:@"质量好(%@)",typeArr[0]];
     self.assess1.textAlignment = NSTextAlignmentCenter;
     [self.headView addSubview:self.assess1];
     
     self.assess2 = [[UILabel alloc]initWithFrame:CGRectMake(115, HEIGHT5S(481), WIDTH5S(80), HEIGHT5S(30))];
     self.assess2.font = FONT(12);
     self.assess2.layer.cornerRadius = 5;
     self.assess2.layer.masksToBounds = YES;
     self.assess2.backgroundColor = COLOR(150, 255, 255, 1);
     self.assess2.textColor = COLOR(150, 150, 150, 1);
     self.assess2.text = [NSString stringWithFormat:@"便宜(%@)",typeArr[1]];
     self.assess2.textAlignment = NSTextAlignmentCenter;
     [self.headView addSubview:self.assess2];
     
     self.assess3 = [[UILabel alloc]initWithFrame:CGRectMake(205, HEIGHT5S(481), WIDTH5S(100), HEIGHT5S(30))];
     self.assess3.font = FONT(12);
     self.assess3.layer.cornerRadius = 5;
     self.assess3.layer.masksToBounds = YES;
     self.assess3.backgroundColor = COLOR(150, 255, 255, 1);
     self.assess3.textColor = COLOR(150, 150, 150, 1);
     self.assess3.text = [NSString stringWithFormat:@"快递不错(%@)",typeArr[2]];
     self.assess3.textAlignment = NSTextAlignmentCenter;
     [self.headView addSubview:self.assess3];
     
     self.assess4 = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(521), WIDTH5S(90), HEIGHT5S(30))];
     self.assess4.font = FONT(12);
     self.assess4.layer.cornerRadius = 5;
     self.assess4.layer.masksToBounds = YES;
     self.assess4.backgroundColor = COLOR(150, 255, 255, 1);
     self.assess4.textColor = COLOR(150, 150, 150, 1);
     self.assess4.text = [NSString stringWithFormat:@"款式新(%@)",typeArr[3]];
     self.assess4.textAlignment = NSTextAlignmentCenter;
     [self.headView addSubview:self.assess4];
     
     self.assess5 = [[UILabel alloc]initWithFrame:CGRectMake(115, HEIGHT5S(521), WIDTH5S(90), HEIGHT5S(30))];
     self.assess5.font = FONT(12);
     self.assess5.layer.cornerRadius = 5;
     self.assess5.layer.masksToBounds = YES;
     self.assess5.backgroundColor = COLOR(150, 255, 255, 1);
     self.assess5.textColor = COLOR(150, 150, 150, 1);
     self.assess5.text = [NSString stringWithFormat:@"态度好(%@)",typeArr[4]];
     self.assess5.textAlignment = NSTextAlignmentCenter;
     [self.headView addSubview:self.assess5];
     
     self.assess6 = [[UILabel alloc]initWithFrame:CGRectMake(215, HEIGHT5S(521), WIDTH5S(90), HEIGHT5S(30))];
     self.assess6.font = FONT(12);
     self.assess6.layer.cornerRadius = 5;
     self.assess6.layer.masksToBounds = YES;
     self.assess6.backgroundColor = COLOR(150, 255, 255, 1);
     self.assess6.textColor = COLOR(150, 150, 150, 1);
     self.assess6.text = [NSString stringWithFormat:@"大小合适(%@)",typeArr[5]];
     self.assess6.textAlignment = NSTextAlignmentCenter;
     [self.headView addSubview:self.assess6];
     
}

-  (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return self.i;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     return self.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     static NSString *pic;
     GoodsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pic];
     
     if (self.picArr.count == 0) {
          pic = @"nilPic";
          
          if (cell == nil) {
               cell = [[GoodsDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pic];
          }
          cell.userImage.image = IMAGE(@"1.0.jpg");
          cell.userName.text = @"xxx";
          cell.dateLabel.text = @"2016-04-05";
          cell.commentLabel.text = @"不错";
          [cell setIntroductionText:cell.commentLabel.text];
          self.height=cell.frame.size.height;
          return cell;
          
     }
     
     if (self.picArr.count > 0){
          
          pic = @"havePic";
          
          if (cell == nil) {
               cell = [[GoodsDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pic];
          }
          cell.userImage.image = [UIImage imageNamed:@"1.0.jpg"];
          cell.userName.text = @"xxx";
          cell.dateLabel1.text = @"2016-04-05";
          cell.commentLabel.text = @"不错";
          cell.imageOne.image = [UIImage imageNamed:self.picArr[0]];
          cell.imageTwo.image = [UIImage imageNamed:self.picArr[1]];
          cell.imageThree.image = [UIImage imageNamed:self.picArr[2]];
          self.height=cell.frame.size.height;
          return cell;
          
     }

     
     return cell;
}

- (void)createShop{
     
}

//购买弹出页面控件创建
- (void)createShopBuy{
     
     self.buyView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, HEIGHT5S(300))];
     self.buyView.backgroundColor = [UIColor whiteColor];
     [self.view addSubview:self.buyView];
     
     UIImageView *goodsImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(170))];
     goodsImg.backgroundColor = COLOR(228, 228, 228, 1);
     [self.buyView addSubview:goodsImg];
     
     UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(180), WIDTH5S(40), HEIGHT5S(20))];
     numLabel.text = @"库存:";
     numLabel.font = FONT(12);
     [self.buyView addSubview:numLabel];
     
     UILabel *numData = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(60), HEIGHT5S(180), WIDTH5S(40), HEIGHT5S(20))];
     self.numberHave = 1500;
     numData.text = [NSString stringWithFormat:@"%d",self.numberHave];
     numData.font = FONT(12);
     [self.buyView addSubview:numData];
     
     UILabel *lines = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(209), SCREEN_WIDTH, HEIGHT5S(1))];
     lines.backgroundColor = COLOR(228, 228, 228, 1);
     [self.buyView addSubview:lines];
     
     UILabel *buyNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(220), WIDTH5S(60), HEIGHT5S(20))];
     buyNumLabel.text = @"购买数量";
     buyNumLabel.font = FONT(12);
     [self.buyView addSubview:buyNumLabel];
     
     UIButton *reduceBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(225), HEIGHT5S(220), WIDTH5S(20), HEIGHT5S(20))];
     [reduceBtn setTitle:@"-" forState:UIControlStateNormal];
     [reduceBtn setBackgroundColor:COLOR(228, 228, 228, 1)];
     [self.buyView addSubview:reduceBtn];
     
     UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(285), HEIGHT5S(220), WIDTH5S(20), HEIGHT5S(20))];
     [addBtn setBackgroundColor:COLOR(228, 228, 228, 1)];
     [addBtn setTitle:@"+" forState:UIControlStateNormal];
     [self.buyView addSubview:addBtn];
     
     self.buyNum = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(245), HEIGHT5S(220), WIDTH5S(60), HEIGHT5S(20))];
     self.buyNum.textAlignment = 1;
     self.number = 0;
     self.buyNum.text = [NSString stringWithFormat:@"%d",self.number];
     self.buyNum.font = FONT(12);
     [self.buyView addSubview:self.buyNum];
     
     UIButton *goCart = [[UIButton alloc]initWithFrame:CGRectMake(0, HEIGHT5S(250), SCREEN_WIDTH, HEIGHT5S(50))];
     [goCart setBackgroundColor:COLOR(0, 210, 210, 1)];
     [goCart setTitle:@"确认添加" forState:UIControlStateNormal];
     [goCart setTitleColor:COLOR(255, 255, 255, 1) forState:UIControlStateNormal];
     [self.buyView addSubview:goCart];
     
     UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(15, 15, WIDTH5S(20), HEIGHT5S(20))];
     [back setBackgroundImage:[UIImage imageNamed:@"back_48px_1125197_easyicon.net"] forState:UIControlStateNormal];
     [self.buyView addSubview:back];
     
     //点击事件
     [reduceBtn addTarget:self action:@selector(reduce) forControlEvents:UIControlEventTouchUpInside];
     [addBtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
     [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
     [goCart addTarget:self action:@selector(goCart) forControlEvents:UIControlEventTouchUpInside];
}

//选择颜色、款型
- (void)createClass{
     
     
}

- (void)reduce{
     if (self.number > 0) {
          self.number--;
          self.buyNum.text = [NSString stringWithFormat:@"%d",self.number];
     }else{
          
     }
     
}

- (void)add{
     
     self.number++;
     self.buyNum.text = [NSString stringWithFormat:@"%d",self.number];
     [self.goodsDic setObject:self.buyNum.text forKey:@"buyNumber"];
     NSLog(@"++");
}

//返回商品详情
- (void)back{
     
     [UIView animateWithDuration:0.5 animations:^{
          
          self.buyView.frame = CGRectMake(0, HEIGHT5S(568), SCREEN_WIDTH, HEIGHT5S(300));
          self.backGroundView.alpha = 0;
     }];
}

//去支付
- (void)goCart{
     
     //存入购买数量
     [self.goodsDic setObject:self.buyNum.text forKey:@"buyNumber"];
     [self.goodsDic setObject:@"1.0.jpg" forKey:@"goodsImg"];
     [self.goodsDic setObject:@"2016-04-06" forKey:@"buyDate"];
     
     self.buyView.frame = CGRectMake(0, HEIGHT5S(568), SCREEN_WIDTH, HEIGHT5S(300));
     self.backGroundView.alpha = 0;

     [GoodsServerceViewController saveData:self.goodsDic and:^(NSMutableArray *dataArr) {
          NSLog(@"seccess");
          NSLog(@"%@",dataArr);
     }];
     
     //去支付或者保留订单继续购买
     UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"订单结果" message:self.buyNum.text preferredStyle:UIAlertControllerStyleActionSheet];
     
     UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"再看看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          
          [self.navigationController popViewControllerAnimated:YES];
     }];
     
     UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"去付款" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          
          NSLog(@"跳至付款界面");
     }];
     
     [alert addAction:action1];
     [alert addAction:action2];
     [self presentViewController:alert animated:YES completion:nil];

     
}
#pragma mark - 底部四个按钮执行方法
-(void)test:(UIButton *)sender{
     NSLog(@"%ld",sender.tag);
     
     if (sender.tag == 1) {
          
          RCConversationViewController *chat = [[RCConversationViewController alloc]init];
          //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
          chat.conversationType = ConversationType_PRIVATE;
          //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
          chat.targetId = @"123456789";
          //设置聊天会话界面要显示的标题
          chat.title = @"与xxx聊天";
          //显示聊天会话界面
          [self.navigationController pushViewController:chat animated:YES];
          
     }else if (sender.tag == 2){
          
     }else{
          self.number = 0;
          
          [UIView animateWithDuration:0.5 animations:^{
               self.buyView.frame = CGRectMake(0, HEIGHT5S(268), SCREEN_WIDTH, HEIGHT5S(300));
               self.backGroundView.alpha = 0.4;
          }];
          
     }
}

#pragma mark - collectbtn点击事件
-(void)collectbtnClick{
     NSLog(@"已收藏");
}


@end
