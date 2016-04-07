//
//  MyOrderViewController.m
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "MyOrderViewController.h"
#import "Header.h"
#import "OrderTableViewCell.h"
#import "GoodsServerceViewController.h"
#import "myNavigation.h"
#import "GoodsServerceViewController.h"

@interface MyOrderViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property (strong, nonatomic)myNavigation *navigation;

//6种评价字符串
@property (copy, nonatomic)NSString *typeNum1, *typeNum2, *typeNum3, *typeNum4, *typeNum5, *typeNum6;
//6种评价次数
@property (assign, nonatomic)int num1, num2, num3, num4, num5, num6;
//评价存放数组
@property (strong, nonatomic)NSArray *typeArr;

@property (assign, nonatomic)long int tags;
@end

@implementation MyOrderViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     
     self.num1 = 0;
     self.num2 = 0;
     self.num3 = 0;
     self.num4 = 0;
     self.num5 = 0;
     self.num6 = 0;
     
     
     //获取plist数据
     [GoodsServerceViewController getData:^(NSMutableArray *dataArr) {
          
          self.orderArr = [NSMutableArray arrayWithArray:dataArr];
          NSLog(@"%@",self.orderArr);
     }];
     
     self.navigation = [[myNavigation alloc]initWithBgImg:nil andTitleLabel:@"我的订单" andTitleImg:nil andleftBtn:@"back_48px_1125197_easyicon.net.png" andRightBtn:@"back_48px_1125197_easyicon.net.png"];
     self.navigation.backgroundColor = COLOR(0, 210, 210, 1);
     [self.view addSubview:self.navigation];
     [self.navigation.leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
     [self.navigation.rightBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
     
     self.orderTable = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(64), SCREEN_WIDTH, HEIGHT5S(504)) style:UITableViewStylePlain];
     self.orderTable.dataSource = self;
     self.orderTable.delegate = self;
     [self.view addSubview:self.orderTable];
     
     self.commentBackView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(64), SCREEN_WIDTH, HEIGHT5S(504))];
     self.commentBackView.backgroundColor = [UIColor grayColor];
     self.commentBackView.alpha = 0;
     [self.view addSubview:self.commentBackView];
     
     [self createCommentView];
     
}

- (void)back{
     
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)delete{
     
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     
     return self.orderArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     static NSString *Identifier = @"orderList";
     
     OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
     if (cell == nil) {
          cell = [[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
     }
     cell.goodsImg.image = IMAGE([self.orderArr[indexPath.row] objectForKey:@"goodsImg"]);
     cell.goodsName.text = [self.orderArr[indexPath.row] objectForKey:@"goodsName"];
     cell.orderNumber.text = @"1111111111";
     cell.date.text = [self.orderArr[indexPath.row] objectForKey:@"buyDate"];
     cell.number.text = [NSString stringWithFormat:@"数量:%@",[self.orderArr[indexPath.row] objectForKey:@"buyNumber"]];
     cell.isSend.text = @"已发货";
     [cell.comment addTarget:self action:@selector(goComment) forControlEvents:UIControlEventTouchUpInside];
     
     return cell;
}

- (void)goComment{
     
     [UIView animateWithDuration:0.3 animations:^{
          self.sendCommentView.frame = CGRectMake(0, HEIGHT5S(152), SCREEN_WIDTH, HEIGHT5S(368));
          self.commentBackView.alpha = 0.4;
     }];
     
}

//创建评价view
- (void)createCommentView{
     
     
     self.sendCommentView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(568), SCREEN_WIDTH, HEIGHT5S(368))];
     self.sendCommentView.backgroundColor = COLOR(228, 228, 228, 1);
     [self.view addSubview:self.sendCommentView];
     
     self.commentView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(320), HEIGHT5S(200))];
     self.commentView.backgroundColor = COLOR(228, 228, 228, 1);
     self.commentView.textColor = COLOR(100, 100, 100, 1);
     self.commentView.font = FONT(15);
     self.commentView.delegate = self;
     self.commentView.returnKeyType = UIReturnKeyDefault;
     self.commentView.scrollEnabled = YES;//可拖动
     self.commentView.editable = YES;//可编辑
     self.commentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适高
     [self.sendCommentView addSubview:self.commentView];
     
     self.typebtn1 = [[UIButton alloc]initWithFrame:CGRectMake(15, HEIGHT5S(210), WIDTH5S(90), HEIGHT5S(30))];
     [self.typebtn1 setTitle:@"质量好" forState:UIControlStateNormal];
     self.typebtn1.backgroundColor = COLOR(204, 255, 255, 1);
     [self.typebtn1 setTitleColor:COLOR(228, 228, 228, 1) forState:UIControlStateNormal];
     [self.typebtn1 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.typebtn1.tag = 101;
     [self.sendCommentView addSubview:self.typebtn1];
     [self.typebtn1 addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
     
     self.typebtn2 = [[UIButton alloc]initWithFrame:CGRectMake(115, HEIGHT5S(210), WIDTH5S(90), HEIGHT5S(30))];
     [self.typebtn2 setTitle:@"便宜" forState:UIControlStateNormal];
     self.typebtn2.backgroundColor = COLOR(204, 255, 255, 1);
     [self.typebtn2 setTitleColor:COLOR(228, 228, 228, 1) forState:UIControlStateNormal];
     [self.typebtn2 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.typebtn2.tag = 102;
     [self.sendCommentView addSubview:self.typebtn2];
     [self.typebtn2 addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
     
     self.typebtn3 = [[UIButton alloc]initWithFrame:CGRectMake(215, HEIGHT5S(210), WIDTH5S(90), HEIGHT5S(30))];
     [self.typebtn3 setTitle:@"快递不错" forState:UIControlStateNormal];
     self.typebtn3.backgroundColor = COLOR(204, 255, 255, 1);
     [self.typebtn3 setTitleColor:COLOR(228, 228, 228, 1) forState:UIControlStateNormal];
     [self.typebtn3 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.typebtn3.tag = 103;
     [self.sendCommentView addSubview:self.typebtn3];
     [self.typebtn3 addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
     
     self.typebtn4 = [[UIButton alloc]initWithFrame:CGRectMake(15, HEIGHT5S(250), WIDTH5S(90), HEIGHT5S(30))];
     [self.typebtn4 setTitle:@"款式新" forState:UIControlStateNormal];
     self.typebtn4.backgroundColor = COLOR(204, 255, 255, 1);
     [self.typebtn4 setTitleColor:COLOR(228, 228, 228, 1) forState:UIControlStateNormal];
     [self.typebtn4 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.typebtn4.tag = 104;
     [self.sendCommentView addSubview:self.typebtn4];
     [self.typebtn4 addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
     
     self.typebtn5 = [[UIButton alloc]initWithFrame:CGRectMake(115, HEIGHT5S(250), WIDTH5S(90), HEIGHT5S(30))];
     [self.typebtn5 setTitle:@"态度好" forState:UIControlStateNormal];
     self.typebtn5.backgroundColor = COLOR(204, 255, 255, 1);
     [self.typebtn5 setTitleColor:COLOR(228, 228, 228, 1) forState:UIControlStateNormal];
     [self.typebtn5 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.typebtn5.tag = 105;
     [self.sendCommentView addSubview:self.typebtn5];
     [self.typebtn5 addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
     
     self.typebtn6 = [[UIButton alloc]initWithFrame:CGRectMake(215, HEIGHT5S(250), WIDTH5S(90), HEIGHT5S(30))];
     [self.typebtn6 setTitle:@"大小合适" forState:UIControlStateNormal];
     self.typebtn6.backgroundColor = COLOR(204, 255, 255, 1);
     [self.typebtn6 setTitleColor:COLOR(228, 228, 228, 1) forState:UIControlStateNormal];
     [self.typebtn6 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.typebtn6.tag = 106;
     [self.sendCommentView addSubview:self.typebtn6];
     [self.typebtn6 addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
     
     self.sendComment = [[UIButton alloc]initWithFrame:CGRectMake(0, HEIGHT5S(320), SCREEN_WIDTH, HEIGHT5S(48))];
     [self.sendComment setTitle:@"发送评价" forState:UIControlStateNormal];
     [self.sendComment setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateNormal];
     [self.sendCommentView addSubview:self.sendComment];
     
     [self.sendComment addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)add:(UIButton *)sender{

     if (sender) {
          self.tags = [sender tag];
     }
}

- (void)send:(UIButton *)sender{
     
     if (self.tags==101) {
          self.num1++;
     }else if (self.tags == 102){
          self.num2++;
     }else if (self.tags == 103){
          self.num3++;
     }else if (self.tags == 104){
          self.num4++;
     }else if (self.tags == 105){
          self.num5++;
     }else{
          self.num6++;
     }
     
     //获取最新评价次数
     self.typeNum1 = [NSString stringWithFormat:@"%d",self.num1];
     self.typeNum2 = [NSString stringWithFormat:@"%d",self.num2];
     self.typeNum3 = [NSString stringWithFormat:@"%d",self.num3];
     self.typeNum4 = [NSString stringWithFormat:@"%d",self.num4];
     self.typeNum5 = [NSString stringWithFormat:@"%d",self.num5];
     self.typeNum6 = [NSString stringWithFormat:@"%d",self.num6];
     self.typeArr = @[self.typeNum1,self.typeNum2,self.typeNum3,self.typeNum4,self.typeNum5,self.typeNum6];
     
     //监听单例
     NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
     [user setObject:self.typeArr forKey:@"typeComment"];
     
     [UIView animateWithDuration:0.3 animations:^{
          self.sendCommentView.frame = CGRectMake(0, HEIGHT5S(568), SCREEN_WIDTH, HEIGHT5S(368));
          self.commentBackView.alpha = 0;
     }];
     
     
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     
     [self.view endEditing:YES];
     self.commentBackView.alpha = 0;
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
