//
//  PostDetailViewController.m
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "PostDetailViewController.h"
#import "myNavigation.h"
#import "Header.h"
#import "PostServerce.h"
#import "MJRefresh.h"
#import "PostCommentServerceViewController.h"
#import "CommentTableViewCell.h"
#import "ResendViewController.h"

@interface PostDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UMSocialUIDelegate>

@property (strong, nonatomic)myNavigation * navigation;

@property (strong,nonatomic)NSDictionary *dic;//帖子详情

@property (strong,nonatomic)NSDictionary *dic1; //评论内容

@property (strong,nonatomic)NSMutableArray *commentCountArr;//评论个数

@property (assign,nonatomic)double height; // cell高度

@property (assign,nonatomic)long int a;

@property (strong,nonatomic)NSString *dateStr;

//button的tag
@property (assign, nonatomic)long int number;
//接收评论回复总条数
@property (copy, nonatomic)NSString *replyNumber;
//评论返回条数匹配
@property (assign, nonatomic)long int commentID;

@end

@implementation PostDetailViewController

- (void)viewWillAppear:(BOOL)animated{
     
     self.navigationController.navigationBar.hidden = YES;
     
}

- (void)viewDidLoad {
     [super viewDidLoad];
     
     self.commentCountArr = [NSMutableArray arrayWithCapacity:0];
     
     self.a=0;
     //使用自定义导航栏
     self.navigationController.navigationBar.hidden = YES;
     self.navigation=[[myNavigation alloc]initWithBgImg:nil andTitleLabel:@"热帖详情" andTitleImg:nil andleftBtn:@"back_48px_1125197_easyicon.net.png" andRightBtn:@"share_48px_1182213_easyicon.net"];
     [self.navigation.leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
     [self.navigation.rightBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
     
     self.navigation.backgroundColor=COLOR(0, 210, 210, 1);
     [self.view addSubview:self.navigation];
     
     self.postDetailTable = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(64), SCREEN_WIDTH, HEIGHT5S(456)) style:UITableViewStylePlain];
     self.postDetailTable.dataSource = self;
     self.postDetailTable.delegate = self;
     self.postDetailTable.tableFooterView = [[UIView alloc]init];
     [self.view addSubview:self.postDetailTable];
     
     [self createTableHead];
     [self createCommentView];
     //获取帖子详情（请求数据）
     [self requestdetail];
     // 获取评论内容（请求数据）
     [self requestdata];
     
     
     //获取当前时间
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
     [dateFormatter setDateStyle:NSDateFormatterFullStyle];
     [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     
     self.dateStr = [dateFormatter stringFromDate:[NSDate date]];
     
     [self DownFresh];
     
     //开启键盘位置监听
     [self regNotification];
}

- (void)requestdetail{
     
     NSDictionary *dic = @{@"postid":_str};
     [PostServerce getPostContentWithDic:dic andWith:^(NSDictionary *dics) {
          NSDictionary *dic1=dics;
          NSArray *arr=[dic1 objectForKey:@"result"];
          self.dic =arr[0];
          
     }];
     
}

//请求评论
- (void)requestdata{
     
     [PostCommentServerceViewController postCommentRequerst:_str and:^(NSMutableDictionary *postCommentDic) {
          
          self.dic = postCommentDic;
          NSLog(@"++++++%@",self.dic);
          if ([[self.dic objectForKey:@"message"] isEqualToString:@"查询失败"]) {
               NSLog(@"null data");
               self.a = 0;
               
          }else{
               
               self.commentCountArr = [self.dic objectForKey:@"result"];
               self.a   = self.commentCountArr.count;
               
          }
          [self.postDetailTable reloadData];
     }];
}
#pragma mark - 下拉刷新评论
-(void)DownFresh{
     
     self.postDetailTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
          [self requestdata];
          [self.postDetailTable.mj_header endRefreshing];
          
     }];
     
}

//页面布局(tableHead)
- (void)createTableHead{
     
     CGRect textSize = [[_dic objectForKey:@"post_text"] boundingRectWithSize:CGSizeMake(WIDTH5S(290), 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
     
     self.postDetailTable.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT,textSize.size.height+HEIGHT5S(140)) ];
     [self.postDetailTable addSubview:self.postDetailTable.tableHeaderView];
     
     self.postTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, WIDTH5S(290), HEIGHT5S(20))];
     self.postTitle.text = [self.dic objectForKey:@"post_title"];
     self.postTitle.textAlignment = 0;
     self.postTitle.font = FONT(15);
     [self.postDetailTable.tableHeaderView addSubview:self.postTitle];
     
     self.userImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, HEIGHT5S(40), WIDTH5S(40), HEIGHT5S(40))];
     self.userImg.layer.cornerRadius = 20;
     self.userImg.layer.masksToBounds = YES;
     self.userImg.image = IMAGE(@"1.1.jpg");
     [self.postDetailTable.tableHeaderView addSubview:self.userImg];
     
     self.userName = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(65), HEIGHT5S(40), WIDTH5S(150), HEIGHT5S(15))];
     self.userName.text = @"xxxxxx";
     self.userName.textAlignment = 0;
     self.userName.font = FONT(12);
     [self.postDetailTable.tableHeaderView addSubview:self.userName];
     
     self.date = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(65), HEIGHT5S(65), WIDTH5S(150), HEIGHT5S(15))];
     self.date.textAlignment = 0;
     self.date.text = [self.dic objectForKey:@"post_time"];
     self.date.font = FONT(12);
     [self.postDetailTable.tableHeaderView addSubview:self.date];
     
     self.tagLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(275), HEIGHT5S(40), WIDTH5S(30), HEIGHT5S(20))];
     self.tagLabel.backgroundColor = COLOR(204, 255, 255, 1);
     self.tagLabel.font = FONT(12);
     self.tagLabel.textAlignment = 1;
     self.tagLabel.text = @"养生";
     [self.postDetailTable.tableHeaderView addSubview:self.tagLabel];
     
     self.line = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(89), WIDTH5S(290), HEIGHT5S(1))];
     self.line.backgroundColor = COLOR(228, 228, 228, 1);
     [self.postDetailTable.tableHeaderView addSubview:self.line];
     
     self.postText = [[UITextView alloc]initWithFrame:CGRectMake(15, HEIGHT5S(100), WIDTH5S(290), textSize.size.height+20)];
     self.postText.text=[_dic objectForKey:@"post_text"];
     [self.postText setEditable:NO];
     self.postText.scrollEnabled = YES;
     self.postText.font=[UIFont systemFontOfSize:12];
     self.postText.autoresizingMask = UIViewAutoresizingFlexibleHeight;
     
     [self.postDetailTable.tableHeaderView addSubview:self.postText];
     
}

//评论栏
- (void)createCommentView{
     
     self.commentView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(520), SCREEN_WIDTH, HEIGHT5S(48))];
     self.commentView.backgroundColor = COLOR(228, 228, 228, 1);
     [self.view addSubview:self.commentView];
     
     self.text = [[UITextField alloc]initWithFrame:CGRectMake(WIDTH5S(15), 10, WIDTH5S(220), HEIGHT5S(28))];
     self.text.backgroundColor = COLOR(255, 255, 255, 1);
     self.text.layer.cornerRadius = 10;
     self.text.placeholder = @"  评论";
     [self.commentView addSubview:self.text];
     
     self.send = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(240), 10, WIDTH5S(40), HEIGHT5S(28))];
     [self.send setTitle:@"发送" forState:UIControlStateNormal];
     [self.send setTitleColor:COLOR(150, 150, 150, 1) forState:UIControlStateNormal];
     [self.send addTarget:self action:@selector(sendComment) forControlEvents:UIControlEventTouchUpInside];
     [self.commentView addSubview:self.send];
     
     self.collect = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(285), HEIGHT5S(14), WIDTH5S(20), HEIGHT5S(20))];
     self.collect.layer.cornerRadius = 10;
     self.collect.layer.masksToBounds = YES;
     [self.collect setBackgroundImage:IMAGE(@"collect.png") forState:UIControlStateNormal];
     [self.commentView addSubview:self.collect];
     
     
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

#pragma mark - notification handler监听键盘y轴改变量(开始编辑)
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
     
     NSDictionary *info = [notification userInfo];
     CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
     CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
     CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
     
     CGFloat yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y;
     CGRect intPutRect = self.commentView.frame;
     intPutRect.origin.y += yOffset;
     NSLog(@"----->>%.1f",yOffset);
     [UIView animateWithDuration:duration animations:^{
          self.commentView.frame = intPutRect;
     }];
}


#pragma mark 发送评论
-(void)sendComment{
     if ([self.text.text isEqualToString:@""]) {
          NSLog(@"评论内容不能为空");
     }else{
          NSDictionary *dic = @{@"userid":@"1",
                                @"postid":_str,
                                @"commentword":self.text.text,
                                @"commenttime":self.dateStr
                                };
          [PostCommentServerceViewController sendCommentWithDic:dic andWith:^(NSDictionary *dics) {
               //            NSDictionary*newDic = dics;
               NSLog(@"评论成功");
               self.text.text = @"";
          }];
     }
     [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     [self.view endEditing:YES];
     self.commentView.frame = CGRectMake(0, HEIGHT5S(520), SCREEN_WIDTH, HEIGHT5S(48));
}

//返回
- (void)back{
     
     [self.navigationController popViewControllerAnimated:YES];
}

//分享
- (void)share{
     
     //分享到微信、朋友圈、新浪微博、QQ、Qzone
     [UMSocialSnsService presentSnsIconSheetView:self
                                          appKey:UMAPPKEY
                                       shareText:@"友盟社会化分享让您快速实现分享等社会化功能，www.umeng.com/social"
                                      shareImage:[UIImage imageNamed:@"icon.png"]
                                 shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
                                        delegate:self];
     
     
}

//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
     //根据`responseCode`得到发送结果,如果分享成功
     if(response.responseCode == UMSResponseCodeSuccess)
     {
          //得到分享到的微博平台名
          NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
     }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
     NSString *str  = @"评论区";
     
     return str;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return _a;
     
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     return self.height;
     
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"11"];
     
     if (cell == nil) {
          cell = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"11"];
     }
     cell.commentlable.text = [self.commentCountArr[indexPath.row] objectForKey:@"postcomment_word"];
     cell.timelable.text = [self.commentCountArr[indexPath.row] objectForKey:@"postcomment_time"];
     [cell setIntroductionText:cell.commentlable.text];
     self.height = cell.frame.size.height;
     cell.buttons.tag = indexPath.row +100;
     [cell.buttons addTarget:self action:@selector(reComment:) forControlEvents:UIControlEventTouchUpInside];
     
     return cell;
}

//回复
- (void)reComment:(UIButton *)sender{
     
     ResendViewController *rvc = [[ResendViewController alloc]init];
     rvc.commentId = [self.commentCountArr[sender.tag -100] objectForKey:@"postcomment_id"];
     NSLog(@"%@",rvc.commentId);
   
     
     [self.navigationController pushViewController:rvc animated:YES];
}

//协议方法
- (void)printText:(NSString *)str{
     
     self.replyNumber = str;
     [self.postDetailTable reloadData];
}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     
}

@end
