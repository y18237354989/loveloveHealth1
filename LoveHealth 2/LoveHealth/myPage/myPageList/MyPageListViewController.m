//
//  MyPageListViewController.m
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "MyPageListViewController.h"
#import "Header.h"
#import "nearlistViewController.h"
#import "newsServerceViewController.h"
#import "MyOrderViewController.h"
#import "RegisterViewController.h"
#import "LogInViewController.h"
#import "ShoppingCartViewController.h"

@interface MyPageListViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MyPageListViewController

-(void)viewWillAppear:(BOOL)animated{
     
     self.navigationController.navigationBar.hidden=YES;
     
}

- (void)viewDidLoad {
     [super viewDidLoad];
     
     self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(320), HEIGHT5S(520)) style:UITableViewStyleGrouped];
     self.myTable.dataSource = self;
     self.myTable.delegate = self;
     self.myTable.scrollEnabled = YES;
     self.automaticallyAdjustsScrollViewInsets = NO; //table填充状态栏20
     [self.view addSubview:self.myTable];
     
     self.myTable.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(200))];
     [self.myTable addSubview:self.myTable.tableHeaderView];
     
     [self createControl];
}

//创建控件
- (void)createControl{
     
     self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(320), HEIGHT5S(200))];
     self.bgView.backgroundColor = [UIColor grayColor];
     [self.myTable.tableHeaderView addSubview:self.bgView];
     
     self.userHeadImage = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH5S(120), HEIGHT5S(60), WIDTH5S(80), HEIGHT5S(80))];
     self.userHeadImage.image = IMAGE(@"1.1.jpg");
     self.userHeadImage.layer.cornerRadius = 40;
     self.userHeadImage.layer.masksToBounds = YES;
     [self.bgView addSubview:self.userHeadImage];
     
     self.registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(115), HEIGHT5S(150), WIDTH5S(40), HEIGHT5S(30))];
     [self.registerBtn setTitle:@"登录" forState:UIControlStateNormal];
     [self.registerBtn setTitleColor:COLOR(255, 255, 255, 1) forState:UIControlStateNormal];
     [self.bgView addSubview:self.registerBtn];
     [self.registerBtn addTarget:self action:@selector(LogIn) forControlEvents:UIControlEventTouchUpInside];
     
     self.logInBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(165), HEIGHT5S(150), WIDTH5S(40), HEIGHT5S(30))];
     [self.logInBtn setTitle:@"注册" forState:UIControlStateNormal];
     [self.logInBtn setTitleColor:COLOR(255, 255, 255, 1) forState:UIControlStateNormal];
     [self.bgView addSubview:self.logInBtn];
     [self.logInBtn addTarget:self action:@selector(Register) forControlEvents:UIControlEventTouchUpInside];
     
}
//注册
- (void)Register{
     
     RegisterViewController *rvc = [[RegisterViewController alloc]init];
     rvc.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:rvc animated:YES];
}
//登录
- (void)LogIn{
     
     LogInViewController *lvc = [[LogInViewController alloc]init];
     lvc.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:lvc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     
     return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     if (section == 0) {
          return 20;
     }else{
          return 0.1+5;
     }
     
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     
     int num;
     
     if (section == 0) {
          num = 5;
     }else if (section == 1){
          num = 2;
     }
     
     return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     static NSString *Identifier = @"myTable";
     
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
     
     if (cell == nil) {
          cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
     }
     
     NSArray *arr = @[@"我的收藏", @"我的消息",@"我的贴子", @"我的订单", @"我的购物车", @"意见反馈", @"设置"];
     
     UILabel *textLab = [[UILabel alloc]initWithFrame:CGRectMake(52, 10, WIDTH5S(100), HEIGHT5S(22))];
     
     [cell addSubview:textLab];
     if (indexPath.section == 0) {
          textLab.text = arr[indexPath.row];
     }else{
          textLab.text = arr[indexPath.row + 5];
     }
     
     
     return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     
     //     [newsServerceViewController newsServerce1:^(NSDictionary *dic) {
     //
     //          NSLog(@"%@",dic);
     //     }];
     
     if (indexPath.section==0) {
          
          if (indexPath.row==0) {
               
          }else if (indexPath.row == 1){
               
               nearlistViewController *ner=[[nearlistViewController alloc]init];
               [self.navigationController pushViewController:ner animated:YES];
               
          }else if (indexPath.row == 2){
               
          }else if (indexPath.row == 3){
               
               MyOrderViewController *mvc = [[MyOrderViewController alloc]init];
               [self.navigationController pushViewController:mvc animated:YES];
               
          }else if (indexPath.row == 4){
               
               ShoppingCartViewController *svc = [[ShoppingCartViewController alloc]init];
               svc.hidesBottomBarWhenPushed = YES;
               [self.navigationController pushViewController:svc animated:YES];
          }
          
     }else if (indexPath.section == 1){
          
          if (indexPath.row == 0) {
               
          }else if (indexPath.row == 1){
               
          }
     }
     
     
}


- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
