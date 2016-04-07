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

@interface PostDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UMSocialUIDelegate>

@property (strong, nonatomic)myNavigation * navigation;

@property (strong,nonatomic)NSDictionary *dic;

@end

@implementation PostDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"dic--->%@",_dic);
     //使用自定义导航栏
     self.navigationController.navigationBar.hidden = YES;
     self.navigation=[[myNavigation alloc]initWithBgImg:nil andTitleLabel:@"热帖详情" andTitleImg:nil andleftBtn:@"back_48px_1125197_easyicon.net.png" andRightBtn:@"share_48px_1182213_easyicon.net"];
     [self.navigation.leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
     [self.navigation.rightBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
     
     self.navigation.backgroundColor=COLOR(0, 210, 210, 1);
     [self.view addSubview:self.navigation];
     
     self.postDetailTable = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(64), SCREEN_WIDTH, HEIGHT5S(504)) style:UITableViewStylePlain];
     self.postDetailTable.dataSource = self;
     self.postDetailTable.delegate = self;
     [self.view addSubview:self.postDetailTable];
     
     [self createTableHead];
     [self createCommentView];
    [self DropDownRefresh];
}
//下拉刷新
-(void)DropDownRefresh{
    NSDictionary *dic = @{@"postid":_str};
    [PostServerce getPostContentWithDic:dic andWith:^(NSDictionary *dics) {
        NSDictionary *dic1=dics;
        NSArray *arr=[dic1 objectForKey:@"result"];
        self.dic =arr[0];
        [self createTableHead];
        [self createCommentView];
    }];
    
    self.postDetailTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.postDetailTable.mj_header endRefreshing];
    }];
}

//页面布局(tableHead)
- (void)createTableHead{
     
     self.postDetailTable.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, HEIGHT5S(400))];
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
     
     self.postText = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(100), WIDTH5S(290), HEIGHT5S(200))];
     self.postText.font = FONT(15);
     self.postText.textColor = COLOR(100, 100, 100, 1);
     self.postText.text = [self.dic objectForKey:@"post_text"];
     [self.postDetailTable.tableHeaderView addSubview:self.postText];
     
}

//评论栏
- (void)createCommentView{
     
     self.commentView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(520), SCREEN_WIDTH, HEIGHT5S(48))];
     self.commentView.backgroundColor = COLOR(228, 228, 228, 1);
     [self.view addSubview:self.commentView];
     
     self.text = [[UITextField alloc]initWithFrame:CGRectMake(15, 10, WIDTH5S(220), HEIGHT5S(28))];
     self.text.layer.cornerRadius = 14;
     self.text.placeholder = @"  评论";
     [self.commentView addSubview:self.text];
     
     self.send = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(245), 10, WIDTH5S(50), HEIGHT5S(28))];
     [self.send setTitle:@"发送" forState:UIControlStateNormal];
     [self.send setTitleColor:COLOR(150, 150, 150, 1) forState:UIControlStateNormal];
     [self.commentView addSubview:self.send];
     
     self.collect = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(285), HEIGHT5S(14), WIDTH5S(20), HEIGHT5S(20))];
     self.collect.layer.cornerRadius = 10;
     self.collect.layer.masksToBounds = YES;
     [self.collect setBackgroundImage:IMAGE(@"collect.png") forState:UIControlStateNormal];
     [self.commentView addSubview:self.collect];
     
     
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     return 80;
     
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"11"];
     
     if (cell == nil) {
          cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"11"];
     }
     
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
