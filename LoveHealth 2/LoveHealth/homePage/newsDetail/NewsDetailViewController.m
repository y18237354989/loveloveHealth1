//
//  NewsDetailViewController.m
//  爱健康
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "Header.h"
#import "myNavigation.h"
#import "TableViewCell.h"
#import "ReCommentViewController.h"



@interface NewsDetailViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UMSocialUIDelegate>
@property (strong, nonatomic) UIScrollView *sview;
@property (strong, nonatomic) UIImageView  *images;
@property (strong, nonatomic) UITextView  *newsDetail;

@property (assign, nonatomic) NSString *str;
@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) myNavigation * navigation;
@property (strong, nonatomic) UIView *commentView;
@property (assign, nonatomic) double  f; //评论内容label高
@property (strong, nonatomic) UITextField *text1;
@property (strong, nonatomic) UIView *view1;
@property (strong, nonatomic) UITableView *tableview;
@property (strong, nonatomic) NSMutableArray *commentArr;
@property (assign, nonatomic) float h;  //监控键盘高度

//cell的tag
@property (assign, nonatomic)long int number;
//接收评论回复总条数
@property (copy, nonatomic)NSString *replyNumber;
//评论返回条数匹配
@property (assign, nonatomic)long int commentID;

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     self.view.backgroundColor=[UIColor whiteColor];
     self.commentArr=[NSMutableArray arrayWithCapacity:0];
     self.navigationController.navigationBar.hidden = YES;
     
     self.navigation=[[myNavigation alloc]initWithBgImg:nil andTitleLabel:@"新闻十分" andTitleImg:nil andleftBtn:@"back_48px_1125197_easyicon.net.png" andRightBtn:@"share_48px_1182213_easyicon.net"];
     [self.navigation.leftBtn addTarget:self action:@selector(toox) forControlEvents:UIControlEventTouchUpInside];
     [self.navigation.rightBtn addTarget:self action:@selector(toox1) forControlEvents:UIControlEventTouchUpInside];
     
     self.navigation.backgroundColor=COLOR(0, 210, 210, 1);
     [self.view addSubview:self.navigation];
     
     
     self.str=@"  中新网南京5月21日电 (田雯)21日下午，江苏省国家安全厅通报了近期破获的三起通过网络勾联策反间谍案例的相关情况。其中涉及机密级文件六件，多起案件涉及军事设施和政府内部期刊、文件。　　三起案件中，判处刑期最高的是1985年出生的吴某涉密案。他在苏州打工期间，曾在国内各大兼职、招聘网站上发布求职简历，2013年7月被境外人员勾联策反，开始对我军用机场、部队驻地和训练场等军事目标开展预警观测情报的搜集，先后将120多张图片及相关描述文字材料经过压缩加密后报送给境外间谍情报机关，并获取间谍活动经费3800元。经鉴定，其报送的情资中有机密级文件5份，秘密级文件6份，对我军事安全造成严重危害。2014年6月，苏州市中级人民法院以“为境外刺探国家秘密罪”判处吴某有期徒刑十年，剥夺政治权利三年。　　1962年出生的赵某，是连云港某县文广局聘用人员，曾担任县文广局记者记通讯员近30年。2013年10月，被境外人员网上勾联策反。赵某通过向我党政机关内部关系人索要以及在当地县委文件分发室窃取等方式，半年内搜集并报送了我大量涉密内部期刊、文件资料。同时，赵某积极向我军事院校渗透，搜集报送多份军事报刊及军事报告，先后获取间谍活动经费74500元。经鉴定，其报送的情资中有秘密级文件11份。";
     
     self.commentArr = [NSMutableArray arrayWithCapacity:0];
     [self.commentArr addObject:@"1"];
     [self.commentArr addObject:@"2"];
     [self.commentArr addObject:@"3"];
     
     [self setTable];
     [self footview];
     
     //开启键盘位置监听
     [self regNotification];
     
}

-(void)setTable{
     
     self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(64), SCREEN_WIDTH, SCREEN_HEIGHT-112)];
     self.tableview.delegate=self;
     self.tableview.dataSource=self;
     
     [self.view  addSubview:self.tableview];
     
     if (_imgarr!=nil) {
          CGRect textSize = [_str boundingRectWithSize:CGSizeMake(300, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
          
          UIView *imgview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(152)+textSize.size.height)];
          self.tableview.tableHeaderView=imgview;
          
          UIScrollView *smallscrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,HEIGHT5S(120) )];
          smallscrollview.contentSize=CGSizeMake(SCREEN_WIDTH*_imgarr.count, HEIGHT5S(120));
          [imgview addSubview:smallscrollview];
          
          for (int i=0; i<_imgarr.count; i++) {
               UIImageView *images=[[UIImageView  alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, HEIGHT5S(120))];
               images.image = [UIImage imageNamed:self.imgarr[0]];
               [smallscrollview addSubview:images];
          }
          self.newsDetail=[[UITextView alloc]initWithFrame:CGRectMake(10, 120, 300, textSize.size.height+32)];
          self.newsDetail.text=_str;
          [self.newsDetail setEditable:NO];
          self.newsDetail.scrollEnabled = YES;
          self.newsDetail.font=[UIFont systemFontOfSize:12];
          self.newsDetail.autoresizingMask = UIViewAutoresizingFlexibleHeight;
          [imgview addSubview:self.newsDetail];
          
     }else{
          CGRect textSize = [_str boundingRectWithSize:CGSizeMake(300, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
          
          UIView *imgview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(32)+textSize.size.height)];
          self.tableview.tableHeaderView=imgview;
          
          
          self.newsDetail=[[UITextView alloc]initWithFrame:CGRectMake(10, 0, 300, textSize.size.height+32)];
          self.newsDetail.text=_str;
          [self.newsDetail setEditable:NO];
          self.newsDetail.scrollEnabled = YES;
          self.newsDetail.font=[UIFont systemFontOfSize:12];
          self.newsDetail.autoresizingMask = UIViewAutoresizingFlexibleHeight;
          [imgview addSubview:self.newsDetail];
          
     }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static NSString *CellIdentifier = @"Cell";
     
     TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (cell == nil) {
          cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
     }
     
     cell.tag = indexPath.row + 10;
     self.number = cell.tag;
     
     cell.namelable.text=@"xxxxxxxx";
     [cell.images setImage:[UIImage imageNamed:@"one@2x.png"]];
     [cell.buttons setTitle:@"回复" forState:UIControlStateNormal];
     if (indexPath.row == self.commentID-10) {
          cell.reCommentNumber.text = self.replyNumber;
     }
     [cell.buttons setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
     [cell setIntroductionText:_commentArr[indexPath.row]];
     [cell.buttons addTarget:self action:@selector(reComment:) forControlEvents:UIControlEventTouchUpInside];
     cell.buttons.tag = self.number;
     
     
     self.f=cell.frame.size.height;
     return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     
     
     return _commentArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     return _f;
}

-(void)footview{
     self.view1=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-48, SCREEN_WIDTH, 48)];
     
     self.view1.backgroundColor=COLOR(242, 242, 242, 1);
     [self.view addSubview:self.view1];
     
     //评论
     self.text1=[[UITextField alloc]initWithFrame:CGRectMake(15, 10, WIDTH5S(220), HEIGHT5S(28))];
     self.text1.backgroundColor =[UIColor whiteColor];
     self.text1.layer.cornerRadius=10;
     self.text1.font=[UIFont systemFontOfSize:12];
     self.text1.delegate=self;
     self.text1.autoresizingMask = UIViewAutoresizingFlexibleHeight;
     [self.view1 addSubview:self.text1];
     
     
     
     UIButton *button1=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(245), 10, WIDTH5S(30), HEIGHT5S(28))];
     [button1 setTitle:@"发送" forState:UIControlStateNormal];
     button1.titleLabel.font=FONT(15);
     [button1 setTitleColor:COLOR(100, 100, 100, 1) forState:UIControlStateNormal];
     [button1 addTarget:self action:@selector(toox3) forControlEvents:UIControlEventTouchUpInside];
     [self.view1 addSubview:button1];
     
     //收藏
     UIButton *button3=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(285), 14, WIDTH5S(20), HEIGHT5S(20))];
     [button3 setImage:[UIImage imageNamed:@"collect.png"] forState:UIControlStateNormal];
     button3.layer.cornerRadius=10;
     button3.layer.masksToBounds = YES;
     [self.view1 addSubview:button3];
     
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
     
     CGFloat yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y;
     CGRect intPutRect = self.view1.frame;
     intPutRect.origin.y += yOffset;
     NSLog(@"----->>%.1f",yOffset);
     [UIView animateWithDuration:duration animations:^{
          self.view1.frame = intPutRect;
     }];
}


- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     
}

//返回按钮
-(void)toox{
     
     [self.navigationController popViewControllerAnimated:YES];
     
}

//分享
-(void)toox1{
     
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
     
     [self.view endEditing:YES];
     
}
//发送评论
-(void)toox3{
     
     if ([_text1.text isEqualToString:@""]) {
          
          
     }else{
          
          [self.commentArr addObject:_text1.text];
          [_tableview reloadData];
          
          _text1.text=nil;
          [self.view endEditing:YES];
     }
}

//回复
- (void)reComment:(UIButton *)sender{
     
     self.commentID = sender.tag;
     ReCommentViewController *rvc = [[ReCommentViewController alloc]init];
     rvc.placeLabel = self.commentArr[sender.tag-10];
     rvc.delegate = self;
     [self.navigationController pushViewController:rvc animated:YES];
}

//协议方法
- (void)printText:(NSString *)str{
     
     self.replyNumber = str;
     [self.tableview reloadData];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//     ReCommentViewController *rvc = (ReCommentViewController *)[segue destinationViewController];
//     rvc.delegate = self;
//}

@end
