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
     
     self.state1 = [[UIButton alloc]initWithFrame:CGRectMake(0, HEIGHT5S(64), WIDTH5S(64), HEIGHT5S(40))];
     self.state1.titleLabel.font = FONT(15);
     [self.state1 setTitle:@"全部" forState:UIControlStateNormal];
     [self.state1 setTitleColor:COLOR(0, 0, 0, 1) forState:UIControlStateNormal];
     [self.state1 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.state1.selected = YES;
     self.state1.backgroundColor = COLOR(255, 255, 255, 1);
     [self.view addSubview:self.state1];
     
     self.state2 = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(64), HEIGHT5S(64), WIDTH5S(64), HEIGHT5S(40))];
     self.state2.titleLabel.font = FONT(15);
     [self.state2 setTitle:@"已付款" forState:UIControlStateNormal];
     [self.state2 setTitleColor:COLOR(0, 0, 0, 1) forState:UIControlStateNormal];
     [self.state2 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.state2.backgroundColor = COLOR(255, 255, 255, 1);
     [self.view addSubview:self.state2];
     
     self.state3 = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(128), HEIGHT5S(64), WIDTH5S(64), HEIGHT5S(40))];
     self.state3.titleLabel.font = FONT(15);
     [self.state3 setTitle:@"未付款" forState:UIControlStateNormal];
     [self.state3 setTitleColor:COLOR(0, 0, 0, 1) forState:UIControlStateNormal];
     [self.state3 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.state3.backgroundColor = COLOR(255, 255, 255, 1);
     [self.view addSubview:self.state3];
     
     self.state4 = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(192), HEIGHT5S(64), WIDTH5S(64), HEIGHT5S(40))];
     self.state4.titleLabel.font = FONT(15);
     [self.state4 setTitle:@"已评价" forState:UIControlStateNormal];
     [self.state4 setTitleColor:COLOR(0, 0, 0, 1) forState:UIControlStateNormal];
     [self.state4 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.state4.backgroundColor = COLOR(255, 255, 255, 1);
     [self.view addSubview:self.state4];
     
     self.state5 = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(256), HEIGHT5S(64), WIDTH5S(64), HEIGHT5S(40))];
     self.state5.titleLabel.font = FONT(15);
     [self.state5 setTitle:@"未评价" forState:UIControlStateNormal];
     [self.state5 setTitleColor:COLOR(0, 0, 0, 1) forState:UIControlStateNormal];
     [self.state5 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.state5.backgroundColor = COLOR(255, 255, 255, 1);
     [self.view addSubview:self.state5];
     
     UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(103), SCREEN_WIDTH, HEIGHT5S(1))];
     line.backgroundColor = COLOR(228, 228, 228, 1);
     [self.view addSubview:line];
     
     self.orderTable = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(104), SCREEN_WIDTH, HEIGHT5S(416)) style:UITableViewStylePlain];
     self.orderTable.dataSource = self;
     self.orderTable.delegate = self;
     [self.view addSubview:self.orderTable];
     
     self.commentBackView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(64), SCREEN_WIDTH, HEIGHT5S(504))];
     self.commentBackView.backgroundColor = [UIColor grayColor];
     self.commentBackView.alpha = 0;
     [self.view addSubview:self.commentBackView];
     
     [self createCommentView];
     
     
     //监听键盘状态
     [self regNotification];
     
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
     cell.isPay.titleLabel.text = @"已付款";
     [cell.comment addTarget:self action:@selector(goComment) forControlEvents:UIControlEventTouchUpInside];
     
     return cell;
}

- (void)goComment{
     
     
     [UIView animateWithDuration:0.3 animations:^{
          self.sendCommentView.frame = CGRectMake(0, HEIGHT5S(280), SCREEN_WIDTH, HEIGHT5S(240));
          self.commentBackView.alpha = 0.4;
     }];
     
}

//创建评价view
- (void)createCommentView{
     
     
     self.sendCommentView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(568), SCREEN_WIDTH, HEIGHT5S(240))];
     self.sendCommentView.backgroundColor = COLOR(228, 228, 228, 1);
     [self.view addSubview:self.sendCommentView];
     
     self.commentView = [[UITextView alloc]initWithFrame:CGRectMake(WIDTH5S(15), 20, WIDTH5S(290), HEIGHT5S(130))];
     self.commentView.layer.cornerRadius = 10;
     self.commentView.backgroundColor = COLOR(255, 255, 255, 1);
     self.commentView.textColor = COLOR(100, 100, 100, 1);
     self.commentView.font = FONT(15);
     self.commentView.delegate = self;
     self.commentView.returnKeyType = UIReturnKeyDefault;
     self.commentView.scrollEnabled = YES;//可拖动
     self.commentView.editable = YES;//可编辑
     self.commentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适高
     [self.sendCommentView addSubview:self.commentView];
     
     self.typebtn1 = [[UIButton alloc]initWithFrame:CGRectMake(15, HEIGHT5S(160), WIDTH5S(38), HEIGHT5S(20))];
     self.typebtn1.layer.cornerRadius = 5;
     self.typebtn1.layer.masksToBounds = YES;
     self.typebtn1.titleLabel.font = FONT(12);
     [self.typebtn1 setTitle:@"质量好" forState:UIControlStateNormal];
     self.typebtn1.backgroundColor = COLOR(204, 255, 255, 1);
     [self.typebtn1 setTitleColor:COLOR(228, 228, 228, 1) forState:UIControlStateNormal];
     [self.typebtn1 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.typebtn1.tag = 101;
     [self.sendCommentView addSubview:self.typebtn1];
     [self.typebtn1 addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
     
     self.typebtn2 = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(63), HEIGHT5S(160), WIDTH5S(26), HEIGHT5S(20))];
     self.typebtn2.layer.cornerRadius = 5;
     self.typebtn2.layer.masksToBounds = YES;
     self.typebtn2.titleLabel.font = FONT(12);
     [self.typebtn2 setTitle:@"便宜" forState:UIControlStateNormal];
     self.typebtn2.backgroundColor = COLOR(204, 255, 255, 1);
     [self.typebtn2 setTitleColor:COLOR(228, 228, 228, 1) forState:UIControlStateNormal];
     [self.typebtn2 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.typebtn2.tag = 102;
     [self.sendCommentView addSubview:self.typebtn2];
     [self.typebtn2 addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
     
     self.typebtn3 = [[UIButton alloc]initWithFrame:CGRectMake(99, HEIGHT5S(160), WIDTH5S(50), HEIGHT5S(20))];
     self.typebtn3.layer.cornerRadius = 5;
     self.typebtn3.layer.masksToBounds = YES;
     self.typebtn3.titleLabel.font = FONT(12);
     [self.typebtn3 setTitle:@"快递不错" forState:UIControlStateNormal];
     self.typebtn3.backgroundColor = COLOR(204, 255, 255, 1);
     [self.typebtn3 setTitleColor:COLOR(228, 228, 228, 1) forState:UIControlStateNormal];
     [self.typebtn3 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.typebtn3.tag = 103;
     [self.sendCommentView addSubview:self.typebtn3];
     [self.typebtn3 addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
     
     self.typebtn4 = [[UIButton alloc]initWithFrame:CGRectMake(159, HEIGHT5S(160), WIDTH5S(38), HEIGHT5S(20))];
     self.typebtn4.layer.cornerRadius = 5;
     self.typebtn4.layer.masksToBounds = YES;
     self.typebtn4.titleLabel.font = FONT(12);
     [self.typebtn4 setTitle:@"款式新" forState:UIControlStateNormal];
     self.typebtn4.backgroundColor = COLOR(204, 255, 255, 1);
     [self.typebtn4 setTitleColor:COLOR(228, 228, 228, 1) forState:UIControlStateNormal];
     [self.typebtn4 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.typebtn4.tag = 104;
     [self.sendCommentView addSubview:self.typebtn4];
     [self.typebtn4 addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
     
     self.typebtn5 = [[UIButton alloc]initWithFrame:CGRectMake(207, HEIGHT5S(160), WIDTH5S(38), HEIGHT5S(20))];
     self.typebtn5.layer.cornerRadius = 5;
     self.typebtn5.layer.masksToBounds = YES;
     self.typebtn5.titleLabel.font = FONT(12);
     [self.typebtn5 setTitle:@"态度好" forState:UIControlStateNormal];
     self.typebtn5.backgroundColor = COLOR(204, 255, 255, 1);
     [self.typebtn5 setTitleColor:COLOR(228, 228, 228, 1) forState:UIControlStateNormal];
     [self.typebtn5 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.typebtn5.tag = 105;
     [self.sendCommentView addSubview:self.typebtn5];
     [self.typebtn5 addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
     
     self.typebtn6 = [[UIButton alloc]initWithFrame:CGRectMake(255, HEIGHT5S(160), WIDTH5S(50), HEIGHT5S(20))];
     self.typebtn6.layer.cornerRadius = 5;
     self.typebtn6.layer.masksToBounds = YES;
     self.typebtn6.titleLabel.font = FONT(12);
     [self.typebtn6 setTitle:@"大小合适" forState:UIControlStateNormal];
     self.typebtn6.backgroundColor = COLOR(204, 255, 255, 1);
     [self.typebtn6 setTitleColor:COLOR(228, 228, 228, 1) forState:UIControlStateNormal];
     [self.typebtn6 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.typebtn6.tag = 106;
     [self.sendCommentView addSubview:self.typebtn6];
     [self.typebtn6 addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
     
     self.sendComment = [[UIButton alloc]initWithFrame:CGRectMake(165, HEIGHT5S(190), WIDTH5S(140), HEIGHT5S(30))];
     self.sendComment.backgroundColor = COLOR(0, 210, 210, 1);
     [self.sendComment setTitle:@"发送评价" forState:UIControlStateNormal];
     [self.sendComment setTitleColor:COLOR(255, 255, 255, 1) forState:UIControlStateNormal];
     self.sendComment.layer.cornerRadius = 10;
     self.sendComment.layer.masksToBounds = YES;
     [self.sendCommentView addSubview:self.sendComment];
     
     self.cancleComment = [[UIButton alloc]initWithFrame:CGRectMake(15, HEIGHT5S(190), WIDTH5S(140), HEIGHT5S(30))];
     self.cancleComment.backgroundColor = COLOR(255, 255, 255, 1);
     [self.cancleComment setTitle:@"取消评价" forState:UIControlStateNormal];
     [self.cancleComment setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateNormal];
     self.cancleComment.layer.cornerRadius = 10;
     self.cancleComment.layer.masksToBounds = YES;
     [self.sendCommentView addSubview:self.cancleComment];
     
     [self.sendComment addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
     [self.cancleComment addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
}

- (void)add:(UIButton *)sender{

     if (sender) {
          self.tags = [sender tag];
     }
}

- (void)send{
     
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
     
     [self.view endEditing:YES];
     [UIView animateWithDuration:0.3 animations:^{
          self.sendCommentView.frame = CGRectMake(0, HEIGHT5S(568), SCREEN_WIDTH, HEIGHT5S(240));
          self.commentBackView.alpha = 0;
     }];
     
     self.commentView.text = nil;
}

- (void)cancle{
     
     [self.view endEditing:YES];
     [UIView animateWithDuration:0.3 animations:^{
          self.sendCommentView.frame = CGRectMake(0, HEIGHT5S(568), SCREEN_WIDTH, HEIGHT5S(240));
          self.commentBackView.alpha = 0;
     }];
     self.commentView.text = nil;
}

//键盘监听
- (void)regNotification
{
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
     
}


- (void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}
//监听键盘y轴改变量(开始编辑)
#pragma mark - notification handler
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
     
     NSDictionary *info = [notification userInfo];
     CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
     CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
     CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
     
     CGFloat yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y + 48;
     CGRect intPutRect = self.sendCommentView.frame;
     intPutRect.origin.y += yOffset;
     NSLog(@"----->>%.1f",yOffset);
     [UIView animateWithDuration:duration animations:^{
          self.sendCommentView.frame = intPutRect;
     }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     
     [UIView animateWithDuration:0.3 animations:^{
          [self.view endEditing:YES];
          self.sendCommentView.frame = CGRectMake(0, HEIGHT5S(568), SCREEN_WIDTH, HEIGHT5S(290));
          self.commentBackView.alpha = 0;
     }];
     
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
