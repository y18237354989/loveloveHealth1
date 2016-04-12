//
//  ResendViewController.m
//  LoveHealth
//
//  Created by administrator on 16/4/9.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "ResendViewController.h"
#import "Header.h"
#import "ResendTableViewCell.h"
#import "PostCommentServerceViewController.h"

@interface ResendViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property (strong, nonatomic)NSMutableArray *wordArr; //回复数据数组

@property (strong, nonatomic)NSMutableDictionary *recommentDic; //回复data

@property (assign, nonatomic)long int num;

@property(strong,nonatomic)UIView *replyview;

@property(strong,nonatomic)UITextField  *texts;

@property(strong,nonatomic)UIButton   *send;

//自适应label高
@property (assign, nonatomic)double height;

@end

@implementation ResendViewController

- (void)viewWillAppear:(BOOL)animated{
     
     self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
     [super viewDidLoad];
     
     self.num = 0;
     self.navigationItem.title = @"评论回复";
     self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
     
     self.wordArr = [NSMutableArray arrayWithCapacity:0];
     self.recommentDic = [NSMutableDictionary dictionaryWithCapacity:0];
     
     self.resendTable = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH5S(0), HEIGHT5S(0), SCREEN_WIDTH, HEIGHT5S(520)) style:UITableViewStylePlain];
     self.resendTable.delegate = self;
     self.resendTable.dataSource = self;
     [self.view addSubview:self.resendTable];
    self.resendTable.tableFooterView=[[UIView alloc]init];
     
//     self.resendTable.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH5S(0), HEIGHT5S(0), SCREEN_WIDTH, HEIGHT5S(160))];
//     [self.resendTable addSubview:self.resendTable.tableHeaderView];
//     
//     [self createControl];
    [self createReplyView];
     [self requestData];
     

}

//请求回复数据
- (void)requestData{
     
     [PostCommentServerceViewController getReCommData:self.commentId and:^(NSDictionary *dic) {
          
          if ([[dic objectForKey:@"message"]isEqualToString:@"查询失败"]) {
               
               self.num = 0;
               
          }else{
               
               self.wordArr = [dic objectForKey:@"result"];
               NSLog(@"%@",self.wordArr);
               self.num = self.wordArr.count;
               
          }
          
          [self.resendTable reloadData];
     }];
}

//回复
- (void)createReplyView{
    
    self.replyview = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(520), SCREEN_WIDTH, HEIGHT5S(48))];
    self.replyview.backgroundColor = COLOR(228, 228, 228, 1);
    [self.view addSubview:self.replyview];
    
    self.texts = [[UITextField alloc]initWithFrame:CGRectMake(WIDTH5S(15), 10, WIDTH5S(220), HEIGHT5S(28))];
    self.texts.backgroundColor = COLOR(255, 255, 255, 1);
    self.texts.layer.cornerRadius = 10;
    self.texts.placeholder = @"  回复";
    [self.replyview addSubview:self.texts];
    
    self.send = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(240), 10, WIDTH5S(40), HEIGHT5S(28))];
    [self.send setTitle:@"发送" forState:UIControlStateNormal];
    [self.send setTitleColor:COLOR(150, 150, 150, 1) forState:UIControlStateNormal];
    [self.send addTarget:self action:@selector(okBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.replyview addSubview:self.send];
    
}



//取消发送
- (void)cancleBtn{
     
     [self.view endEditing:YES];
     
}
//发送
- (void)okBtn{
    
     //获取当前时间
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
     [dateFormatter setDateStyle:NSDateFormatterFullStyle];
     [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     
     [self.recommentDic setObject:@"1" forKey:@"userid"];
     [self.recommentDic setObject:self.commentId forKey:@"postcommentid"];
     [self.recommentDic setObject:self.texts.text forKey:@"postreplyword"];
     [self.recommentDic setObject:[dateFormatter stringFromDate:[NSDate date]] forKey:@"postreplytime"];
     
     if (self.texts.text.length == 0) {
          
          UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"回复内容不能为空" preferredStyle:UIAlertControllerStyleAlert];
          UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               
          }];
          [alert addAction:action];
          [self presentViewController:alert animated:YES completion:nil];
          
     }else{
        
          //回复录入数据库
          [PostCommentServerceViewController postRecomm:self.recommentDic and:^(NSDictionary *dic) {
               
               NSLog(@"+++%@",dic);
          }];
          
     }
     
     
//     //重新请求恢复数据并刷新table
     [self requestData];
//     [self.resendTable reloadData];
     [self.view endEditing:YES];
     
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return self.num;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     return self.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     static NSString *str = @"resend";
     
     ResendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
     if (cell == nil) {
          cell = [[ResendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
     }
     NSString *str1=[self.wordArr[indexPath.row] objectForKey:@"postreply_word"];
     [cell setIntroductionText:str1];
     cell.username.text = [self.wordArr[indexPath.row] objectForKey:@"user_nickname"];
     cell.time.text = [self.wordArr[indexPath.row] objectForKey:@"postreply_time"];

     self.height=cell.frame.size.height;
     
     return cell;
}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     
}


@end
