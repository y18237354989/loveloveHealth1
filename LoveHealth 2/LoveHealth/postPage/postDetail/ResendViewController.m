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

@property (strong, nonatomic)UITextView *reCommentTextView;//回复输入区

@property (assign, nonatomic)long int num;


//自适应label高
@property (assign, nonatomic)double height;

@end

@implementation ResendViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     
     self.num = 0;
     self.navigationItem.title = @"评论回复";
     self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
     
     self.wordArr = [NSMutableArray arrayWithCapacity:0];
     self.recommentDic = [NSMutableDictionary dictionaryWithCapacity:0];
     
     [self requestData];
     
     [self createControl];
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
          
//          [self.resendTable reloadData];
     }];
}


- (void)createControl{
     
     self.resendTable = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH5S(0), HEIGHT5S(0), SCREEN_WIDTH, HEIGHT5S(504)) style:UITableViewStylePlain];
     self.resendTable.delegate = self;
     self.resendTable.dataSource = self;
     [self.view addSubview:self.resendTable];
     
     self.resendTable.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH5S(0), HEIGHT5S(0), SCREEN_WIDTH, HEIGHT5S(160))];
     [self.resendTable addSubview:self.resendTable.tableHeaderView];
     
     self.woreText = [[UITextView alloc]initWithFrame:CGRectMake(WIDTH5S(0), HEIGHT5S(0), SCREEN_WIDTH, HEIGHT5S(120))];
     self.woreText.textColor = COLOR(100, 100, 100, 1);
     self.woreText.font = FONT(15);
     self.woreText.delegate = self;
     self.woreText.returnKeyType = UIReturnKeyDefault;
     self.woreText.scrollEnabled = YES;//可拖动
     self.woreText.editable = YES;//可编辑
     self.woreText.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适高
     [self.resendTable.tableHeaderView addSubview:self.woreText];
     
     self.cancle = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(130), WIDTH5S(40), HEIGHT5S(20))];
     [self.cancle setTitle:@"取消" forState:UIControlStateNormal];
     [self.cancle setBackgroundColor:COLOR(0, 210, 210, 1)];
     [self.cancle addTarget:self action:@selector(cancleBtn) forControlEvents:UIControlEventTouchUpInside];
     [self.resendTable.tableHeaderView addSubview:self.cancle];
     
     self.ok = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(265), HEIGHT5S(130), WIDTH5S(40), HEIGHT5S(20))];
     [self.ok setTitle:@"确定" forState:UIControlStateNormal];
     [self.ok setBackgroundColor:COLOR(0, 210, 210, 1)];
     [self.ok addTarget:self action:@selector(okBtn) forControlEvents:UIControlEventTouchUpInside];
     [self.resendTable.tableHeaderView addSubview:self.ok];
     
     
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
     [self.recommentDic setObject:self.reCommentTextView.text forKey:@"postreplyword"];
     [self.recommentDic setObject:[dateFormatter stringFromDate:[NSDate date]] forKey:@"postreplytime"];
     
     //回复录入数据库
     [PostCommentServerceViewController postRecomm:self.recommentDic and:^(NSDictionary *dic) {
          
          NSLog(@"+++%@",dic);
     }];
     
//     //重新请求恢复数据并刷新table
//     [self requestData];
     [self.resendTable reloadData];
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
//     cell.sendword.text = [self.wordArr[indexPath.row]objectForKey:@"postreply_word"];
     self.height=cell.frame.size.height;
     
     return cell;
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
