//
//  ShoppingCartViewController.m
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "Header.h"
#import "ShoppingCartTableViewCell.h"

@interface ShoppingCartViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic)UITableView *shopCarTableView;

@property (strong,nonatomic)UIView *shopView;

@property (strong,nonatomic)UIButton *allChooseBtn;//全选按钮

@property (strong,nonatomic)UILabel *allChooseLabel;//全选Label

@property (strong,nonatomic)UILabel *countLabel;//合计

@property (strong,nonatomic)UILabel *countMoneyLabel;//金钱

@property (strong,nonatomic)UIButton *countBtn;//结算

@property (strong,nonatomic)NSMutableArray *mutArr;

@property (assign,nonatomic)int i;

@end

@implementation ShoppingCartViewController

- (void)viewDidAppear:(BOOL)animated{
     self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title = @"购物车";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.i = 0;
    self.mutArr = [NSMutableArray arrayWithCapacity:0];
    // Do any additional setup after loading the view.
    [self CreateTableView];
    [self CreatebottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CreateTableView{
    
    self.shopCarTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(320), HEIGHT5S(528)) style:UITableViewStylePlain];
    self.shopCarTableView.delegate = self;
    self.shopCarTableView.dataSource = self;
    self.shopCarTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.shopCarTableView];
}

- (void)CreatebottomView{
    self.shopView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-HEIGHT5S(48), SCREEN_WIDTH, HEIGHT5S(48))];
    self.shopView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.shopView];
    
    //全选按钮
     self.allChooseBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(14), WIDTH5S(20), HEIGHT5S(20))];
    self.allChooseBtn.layer.cornerRadius = 10;
    self.allChooseBtn.layer.borderWidth = 1.0f;
    self.allChooseBtn.layer.borderColor = [UIColor grayColor].CGColor;
    [self.allChooseBtn addTarget:self action:@selector(AllChoose:) forControlEvents:UIControlEventTouchUpInside];
    [self.shopView addSubview:self.allChooseBtn];
    //全选Label
    UILabel *allChooseLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(40), HEIGHT5S(14), WIDTH5S(50), HEIGHT5S(20))];
    allChooseLabel.text = @"全选";
    allChooseLabel.font = FONT(12);
    allChooseLabel.textAlignment = NSTextAlignmentLeft;
    [self.shopView addSubview:allChooseLabel];
    //合计
    self.countLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(150), HEIGHT5S(14), WIDTH5S(30), HEIGHT5S(20))];
    self.countLabel.text = @"合计:";
    self.countLabel.font = FONT(15);
    self.countLabel.textAlignment = NSTextAlignmentRight;
    [self.shopView addSubview:self.countLabel];
    //countMoney
    self.countMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(185), HEIGHT5S(14), WIDTH5S(60), HEIGHT5S(20))];
    self.countMoneyLabel.text = @"￥:0.00";
    self.countMoneyLabel.font = FONT(15);
    self.countMoneyLabel.textAlignment = NSTextAlignmentLeft;
    [self.shopView addSubview:self.countMoneyLabel];
    //结算
    self.countBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-WIDTH5S(70), 0, WIDTH5S(70), HEIGHT5S(48))];
    [self.countBtn setTitle:@"结算" forState:UIControlStateNormal];
    self.countBtn.backgroundColor = COLOR(0, 210, 210, 1);
    self.countBtn.titleLabel.font = FONT(15);
    [self.countBtn addTarget:self action:@selector(choosePay) forControlEvents:UIControlEventTouchUpInside];
    [self.shopView addSubview:self.countBtn];
    
}
//全选执行方法
-(void)AllChoose:(UIButton *)sender{
    
    if (_i == 0) {
        self.allChooseBtn.layer.borderWidth = 0.0f;
        [self.allChooseBtn setImage:[UIImage imageNamed:@"check3"] forState:UIControlStateNormal];
        self.i =1;
    }else{
        self.allChooseBtn.layer.borderWidth = 1.0f;
        [self.allChooseBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.i =0;
    }
}

//结算执行方法
-(void)choosePay{
    
}

//每组多少个
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
//多少个组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
// section 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 5;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid = @"shopping";
    
    ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        cell = [[ShoppingCartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.goodsImage.image = IMAGE(@"cat");
    cell.goodsNameLabel.text = @"瘦身机瘦身机瘦身机瘦身机瘦身机瘦身机瘦身机";
    cell.goodsNum.text = @"x1";
    cell.goodsPrice.text = @"￥55";

    return cell;
}

//可以选中 包括跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
//划动删除
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.shopCarTableView setEditing:YES animated:YES];
//    [_mutArr removeObjectAtIndex:indexPath.row];
//    [self.shopCarTableView reloadData];
//}
@end
