//
//  NewsListViewController.m
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "NewsListViewController.h"
#import "NewsTableViewCell.h"
#import "NewsDetailViewController.h"
#import "Header.h"
#import "myNavigation.h"
#import "newsServerceViewController.h"
#import "NewsSearchViewController.h"

@interface NewsListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)UIButton *typeSearchBtn;

@property (strong, nonatomic)UIButton *titleBtn;

@property (strong, nonatomic)NSTimer *imageTimer;

@property (assign, nonatomic)int num;

@property (assign, nonatomic)int i;

@property (strong, nonatomic)UIButton *tmpBtn;

@property (strong, nonatomic)NSArray *arr;

@property (strong, nonatomic)myNavigation *navigation;

@property (copy,nonatomic)NSString *str;

@property (strong, nonatomic)UIPageControl *page;


@end

@implementation NewsListViewController

- (void)viewWillAppear:(BOOL)animated{
     [self timerStop];
     self.view=[[UIView alloc]init];
     [self setupobject];
     self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
     [super viewDidLoad];
     //关闭系统自动排布
     self.automaticallyAdjustsScrollViewInsets = NO;
     
     //设置导航栏标题字体大小和颜色
     [self.navigationController.navigationBar setTitleTextAttributes:
      @{NSFontAttributeName:FONT(18),
        NSForegroundColorAttributeName:COLOR(255, 255, 255, 1)}];
     
     self.newsTypeArr = [NSMutableArray arrayWithCapacity:0];
     self.num = 0;
     self.i=0;
     self.tmpBtn = nil;
     self.navigation=[[myNavigation alloc]initWithBgImg:nil andTitleLabel:@"sh" andTitleImg:nil andleftBtn:@"返回" andRightBtn:@"分享"];
     self.arr = @[@"1.2.jpg"];
     
     [self.newsTypeArr addObject:@"推荐"];
     [self.newsTypeArr addObject:@"健康"];
     [self.newsTypeArr addObject:@"养生"];
     
     //创建控件
     [self setupobject];
     
     //获取新闻
     [newsServerceViewController newsServerce:^(NSDictionary *newsDic) {
          NSDictionary *dic = newsDic;
          self.newsDataDic = dic;
          [self.newsListTable reloadData];
          NSLog(@"初始请求1111");
     }];
     
     
}

#pragma mark -创建对象
-(void)setupobject{
     
     //初始化titleScrollView（添加在View上）
     self.titleScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(64), WIDTH5S(270), HEIGHT5S(36))];
     self.titleScroll.contentSize = CGSizeMake(90*self.newsTypeArr.count, HEIGHT5S(36));
     self.titleScroll.backgroundColor = COLOR(255, 255, 255, 1);
     [self.view addSubview:self.titleScroll];
     
     [self button];
     
     //初始化新闻类别选择按钮（添加在View上）
     self.typeSearchBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(270), HEIGHT5S(64), WIDTH5S(50), HEIGHT5S(36))];
     [self.view addSubview:self.typeSearchBtn];
     self.typeSearchBtn.backgroundColor = COLOR(255, 255, 255, 1);
     [self.typeSearchBtn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
     UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 8, WIDTH5S(20), HEIGHT5S(20))];
     image.image = [UIImage imageNamed:@"Add_48px_1166404_easyicon.net"];
     [self.typeSearchBtn addSubview:image];
     
     UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(99), SCREEN_WIDTH, HEIGHT5S(1))];
     line.backgroundColor = COLOR(228, 228, 228, 1);
     [self.view addSubview:line];
     
     //初始化newsTabel（添加在newsScroll上）
     self.newsListTable = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(100), WIDTH5S(320), HEIGHT5S(420)) style:UITableViewStyleGrouped];
     self.newsListTable.dataSource = self;
     self.newsListTable.delegate = self;
     self.newsListTable.tag = 0;
     [self.view addSubview:self.newsListTable];
     
     
     //newsTable--headerView
     self.newsListTable.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(320), HEIGHT5S(150))];
     [self.newsListTable addSubview:self.newsListTable.tableHeaderView];
     
     //初始化新闻图片ScrollView(添加在tableHeaderView上)
     self.imageScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(320), HEIGHT5S(150))];
     self.imageScroll.contentSize = CGSizeMake(320*5, 150);
     self.imageScroll.delegate = self;
     self.imageScroll.pagingEnabled = YES;
     self.imageScroll.contentOffset = CGPointMake(0, 0);
     [self.newsListTable.tableHeaderView addSubview:self.imageScroll];
     for (int j = 0; j < 5; j++) {
          UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH5S(320)*j, 0, WIDTH5S(320), HEIGHT5S(150))];
          image.image = [UIImage imageNamed:self.arr[0]];
          [self.imageScroll addSubview:image];
     }
     
     //imagescroll上小圆点
     self.page = [[UIPageControl alloc]initWithFrame:CGRectMake(150, 140, 10, 10)];
     self.page.alpha = 0.5;
     self.page.numberOfPages = 4;
     self.page.pageIndicatorTintColor = COLOR(255, 255, 255, 1);//正常色
     self.page.currentPageIndicatorTintColor = COLOR(0, 210, 210, 1);//选中色
     [self.newsListTable.tableHeaderView addSubview:self.page];
     
     [self timerStart];
     
}


#pragma mark - 点击+号跳转事件
- (void)test{
     NewsSearchViewController *search = [[NewsSearchViewController alloc]init];
     search.delegate=self;
     search.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:search animated:YES];
}

-(void)button{
     
     for (int i = 0; i < self.newsTypeArr.count; i++) {
          self.titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(90*i, HEIGHT5S(0), WIDTH5S(90), HEIGHT5S(36))];
          self.titleBtn.titleLabel.font = FONT(15);
          self.titleBtn.backgroundColor = COLOR(255, 255, 255, 1);
          [self.titleBtn setTitle:self.newsTypeArr[i] forState:UIControlStateNormal];
          [self.titleBtn setTitleColor:COLOR(0, 0, 0, 1) forState:UIControlStateNormal];
          [self.titleBtn setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
          if (i == 0) {
               
               self.titleBtn.selected = YES;
          }
          
          self.titleBtn.tag = i+100;
          [self.titleScroll addSubview:self.titleBtn];
          [self.titleBtn addTarget:self action:@selector(typeSelect:) forControlEvents:UIControlEventTouchUpInside];
     }
     
}

//新闻分类索引button点击事件
- (void)typeSelect:(UIButton *)sender{
     
     long int x = sender.tag;
     
     for (int i=0; i<self.newsTypeArr.count; i++) {
          UIButton *btn = (UIButton *)[self.view viewWithTag:i+100];
          if (btn.tag ==x) {
               btn.selected = YES;
          }else{
               btn.selected = NO;
          }
          
     }
     
     //请求数据
     [self respondsNewsData];
     
}

//请求新闻数据
- (void)respondsNewsData{
     
     [newsServerceViewController newsServerce:^(NSDictionary *newsDic) {
          NSDictionary *dic = newsDic;
          self.newsDataDic = dic;
          [self.newsListTable reloadData];
          NSLog(@"索引请求2222");
     }];
     
}

- (void)timerStart{
     
     self.imageTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(switchImage) userInfo:nil repeats:YES];
}

- (void)timerStop{
     
     [self.imageTimer invalidate];
     self.imageTimer = nil;
     
}

- (void)switchImage{
     
     if (self.num == 4) {
          self.num = 0;
          [self.imageScroll setContentOffset:CGPointMake(0, 0) animated:NO];
          self.num++;
          [self.imageScroll setContentOffset:CGPointMake(WIDTH5S(320)*self.num, 0) animated:YES];
          
     }else{
          
          self.num++;
          [self.imageScroll setContentOffset:CGPointMake(self.num*WIDTH5S(320), 0) animated:YES];
     }
     
     if (self.num == 4) {
          self.page.currentPage = 0;
     }else{
          self.page.currentPage = self.num;
     }
     
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
     
     [self timerStop];
     
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
     
     self.num = 0;
     [self timerStart];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     
     NSArray *arr = [[self.newsDataDic objectForKey:@"result"]objectForKey:@"data"];
     
     return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     int height;
     
     NSArray *picArr = [[[self.newsDataDic objectForKey:@"result"]objectForKey:@"data"][indexPath.row] objectForKey:@"image"];
     
     if (picArr.count > 1) {
          height = 133;
     } else{
          height = 80;
     }
     return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     static NSString *isPic;
     
     NSDictionary *dataDic = [[self.newsDataDic objectForKey:@"result"]objectForKey:@"data"][indexPath.row];
     NSArray *dataArr = [dataDic objectForKey:@"image"];
     
     if (dataArr.count == 0) {
          isPic = @"nilPic";
          NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:isPic];
          if (cell == nil) {
               cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:isPic];
          }
          cell.newsTitleLabel.text = [dataDic objectForKey:@"title"];
          cell.dateLabel.text = [dataDic objectForKey:@"date"];
          cell.collectNumLabel.text = [dataDic objectForKey:@"collectNum"];
          cell.commentNumLabel.text = [dataDic objectForKey:@"commentNum"];
          cell.collectImage.image = [UIImage imageNamed:@"star"];
          cell.commentImage.image = [UIImage imageNamed:@"talk"];
          return cell;
          
     }else if (dataArr.count == 1){
          isPic = @"onePic";
          NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:isPic];
          if (cell == nil) {
               cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:isPic];
          }
          cell.newsTitleLabel.text = [dataDic objectForKey:@"title"];
          cell.dateLabel1.text = [dataDic objectForKey:@"date"];
          cell.collectNumLabel1.text = [dataDic objectForKey:@"collectNum"];
          cell.commentNumLabel1.text = [dataDic objectForKey:@"commentNum"];
          cell.collectImage1.image = [UIImage imageNamed:@"star"];
          cell.commentImage1.image = [UIImage imageNamed:@"talk"];
          cell.newsImage1.image = [UIImage imageNamed:[dataDic objectForKey:@"image"][0]];
          return cell;
          
     }else{
          isPic = @"manyPic";
          NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:isPic];
          if (cell == nil) {
               cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:isPic];
          }
          cell.newsTitleLabel.text = [dataDic objectForKey:@"title"];
          cell.dateLabel2.text = [dataDic objectForKey:@"date"];
          cell.collectNumLabel2.text = [dataDic objectForKey:@"collectNum"];
          cell.commentNumLabel2.text = [dataDic objectForKey:@"commentNum"];
          cell.collectImage2.image = [UIImage imageNamed:@"star"];
          cell.commentImage2.image = [UIImage imageNamed:@"talk"];
          cell.newsImage2.image = cell.newsImage1.image = [UIImage imageNamed:[dataDic objectForKey:@"image"][0]];;
          cell.newsImage3.image = cell.newsImage1.image = [UIImage imageNamed:[dataDic objectForKey:@"image"][1]];;
          cell.newsImage4.image = cell.newsImage1.image = [UIImage imageNamed:[dataDic objectForKey:@"image"][2]];;
          return cell;
     }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     
     [self.newsListTable deselectRowAtIndexPath:indexPath animated:YES];
     
     NewsDetailViewController *ndv = [[NewsDetailViewController alloc]init];
     
     if (indexPath.row %3 == 0) {
          
     }else{
          ndv.imgarr = self.arr;
          
     }
     
     
     ndv.hidesBottomBarWhenPushed = YES;
     
     [self.navigationController pushViewController:ndv animated:YES];
}

- (void)receiveValue:(NSString *)value{
     
     self.str=value;
     int a=0;
     for (int i=0; i<_newsTypeArr.count; i++) {
          if ([self.str isEqualToString:_newsTypeArr[i]]) {
               a++;
          }
          
     }
     if (a==0) {
          [self.newsTypeArr addObject:self.str];
     }
     
     
}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     
}

@end
