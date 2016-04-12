//
//  PostListViewController.m
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "PostListViewController.h"
#import "Header.h"
#import "PostListTableViewCell.h"
#import "PostDetailViewController.h"
#import "SendPostViewController.h"
#import "PostServerce.h"
#import "MJRefresh.h"
#import "YCXMenu.h"


@interface PostListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic)NSMutableArray *result;

@property (assign,nonatomic)long int i;

@property (assign, nonatomic)int n;

@property (assign, nonatomic)long a, b;

@property (copy, nonatomic)NSString *typeNumStr; //标签号

@property (strong, nonatomic)UIButton *btn1,*btn2,*btn3,*btn4,*btn5,*btn6;

@end

@implementation PostListViewController

//返回取消系统导航隐藏
- (void)viewWillAppear:(BOOL)animated{
     
     self.navigationController.navigationBar.hidden = NO;
     
}

- (void)viewDidLoad {
     [super viewDidLoad];
     self.i = 0;
     
     //设置导航栏标题字体大小和颜色
     [self.navigationController.navigationBar setTitleTextAttributes:
      @{NSFontAttributeName:FONT(18),
        NSForegroundColorAttributeName:COLOR(255, 255, 255, 1)}];
     self.view.backgroundColor = [UIColor blueColor];
     
     UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"发帖" style:UIBarButtonItemStylePlain target:self action:@selector(sendPost)];
     [rightItem setTintColor:COLOR(255, 255, 255, 1)];
     self.navigationItem.rightBarButtonItem = rightItem;
     
     self.postTable = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(40), SCREEN_WIDTH, HEIGHT5S(480)) style:UITableViewStylePlain];
     self.postTable.dataSource = self;
     self.postTable.delegate = self;
     self.postTable.separatorStyle = NO;  //隐藏cell自带的分割线
     [self.view addSubview:self.postTable];
     
     self.result = [NSMutableArray arrayWithCapacity:0];
     self.picArr = [NSMutableArray arrayWithCapacity:0];
     [self.picArr addObject:@"1.1.jpg"];
     
     self.n = 1;
     self.typeNumStr = @"1";
     
     [self createBtn];
     [self getpostdata];
     //下拉刷新
     //     [self DropDownRefresh];
     //上拉刷新
     [self PullRefresh];
     
}

//请求数据
-(void)getpostdata{
     
     if ([self.typeNumStr isEqualToString:@"0"]) {
          self.typeNumStr = @"1";
     }
     
     NSString *str  = [NSString stringWithFormat:@"%d",self.n];
     NSDictionary *dic =@{@"postType":self.typeNumStr,
                          @"pageindex":str
                          };
     [PostServerce getPostWithDic:dic andWith:^(NSDictionary *dics) {
          
          
          if ([[dics objectForKey:@"message"] isEqualToString:@"查询失败"] ) {
               self.a= 1;
               if (_result.count == 0) {
                    
                    self.i = 0;
               }
               
          }else{
               if ([[dics objectForKey:@"message"]isEqualToString:@"查询成功"]) {
                    self.a = 0;
                    NSMutableArray *arr = [dics objectForKey:@"result"];
                    [self.result addObjectsFromArray:arr];
                    
                    self.i = _result.count;
                    
                    
                    
               }
          }
          [self.postTable reloadData];
     }];
}


//下拉刷新
//-(void)DropDownRefresh{
//     self.postTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//          self.n++;
//          [self getpostdata];
//          [self.postTable.mj_footer endRefreshing];



//          NSString *str  = [NSString stringWithFormat:@"%d",self.n];
//          NSDictionary *dic =@{@"postType":@"1",
//                                         @"pageindex":str
//                                         };
//          [PostServerce getPostWithDic:dic andWith:^(NSDictionary *dics) {
//               NSDictionary *newdic1 = dics;
//               self.result = [newdic1 objectForKey:@"result"];
//               NSLog(@"%@",self.result);
//               [self.postTable reloadData];
//
//               self.i = self.i + 3;
//               [self.postTable reloadData];
//               [self.postTable.mj_header endRefreshing];
//               if (self.result == nil) {
//                    self.i=0;
//                    [self.postTable.mj_header endRefreshing];
//               }else{
//                    if (self.i>self.result.count) {
//                         self.i = _result.count;
//                         [self.postTable reloadData];
//                         [self.postTable.mj_header endRefreshing];
//                    }
//               }
//
//          }];
//     }];
//}

//上拉刷新
-(void)PullRefresh{
     self.postTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
          
          self.n++;
          [self getpostdata];
          [self.postTable.mj_footer endRefreshing];
          
          if (self.a == 1) {
               [self.postTable.mj_footer endRefreshingWithNoMoreData];
//               self.postTable.mj_footer.hidden = YES;
          }
          
     }];
}


//发帖
- (void)sendPost{
     
     SendPostViewController *spv = [[SendPostViewController alloc]init];
     spv.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:spv animated:YES];
}

//选择标签并刷新table
- (void)selectType:(UIButton *)sender{
     
     //改变索引颜色
     for (int i = 0; i < 6; i++) {
          UIButton *btn = (UIButton *)[self.view viewWithTag:i+100];
          if (btn.tag == sender.tag) {
               
               btn.selected = YES;
          }else{
               btn.selected = NO;
          }
     }
     
     //清空数据数组
     self.result = [NSMutableArray arrayWithCapacity:0];
     self.n = 1;
     self.typeNumStr = [NSString stringWithFormat:@"%ld",(sender.tag -100)];
     
     //重新请求数据
     [self getpostdata];
     [self.postTable.mj_footer beginRefreshing];
}

#pragma mark -索引标签
- (void)createBtn{
     self.btn1 = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(1), HEIGHT5S(64), WIDTH5S(53), HEIGHT5S(40))];
     [self.btn1 setTitle:@"全部" forState:UIControlStateNormal];
     self.btn1.backgroundColor = COLOR(255, 255, 255, 1);
     [self.btn1 setTitleColor:COLOR(0, 0, 0, 1) forState:UIControlStateNormal];
     [self.btn1 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.btn1.selected = YES;
     self.btn1.tag = 100;
     [self.view addSubview:self.btn1];
     [self.btn1 addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
     
     self.btn2 = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(54), HEIGHT5S(64), WIDTH5S(53), HEIGHT5S(40))];
     self.btn2.backgroundColor = COLOR(255, 255, 255, 1);
     [self.btn2 setTitle:@"健身" forState:UIControlStateNormal];
     [self.btn2 setTitleColor:COLOR(0, 0, 0, 1) forState:UIControlStateNormal];
     [self.btn2 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.btn2.tag = 101;
     [self.view addSubview:self.btn2];
     [self.btn2 addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
     
     self.btn3 = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(107), HEIGHT5S(64), WIDTH5S(53), HEIGHT5S(40))];
     self.btn3.backgroundColor = COLOR(255, 255, 255, 1);
     [self.btn3 setTitle:@"心理" forState:UIControlStateNormal];
     [self.btn3 setTitleColor:COLOR(0, 0, 0, 1) forState:UIControlStateNormal];
     [self.btn3 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.btn3.tag = 102;
     [self.view addSubview:self.btn3];
     [self.btn3 addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
     
     self.btn4 = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(160), HEIGHT5S(64), WIDTH5S(53), HEIGHT5S(40))];
     self.btn4.backgroundColor = COLOR(255, 255, 255, 1);
     [self.btn4 setTitle:@"中医" forState:UIControlStateNormal];
     [self.btn4 setTitleColor:COLOR(0, 0, 0, 1) forState:UIControlStateNormal];
     [self.btn4 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.btn4.tag = 103;
     [self.view addSubview:self.btn4];
     [self.btn4 addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
     
     self.btn5 = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(213), HEIGHT5S(64), WIDTH5S(53), HEIGHT5S(40))];
     self.btn5.backgroundColor = COLOR(255, 255, 255, 1);
     [self.btn5 setTitle:@"西医" forState:UIControlStateNormal];
     [self.btn5 setTitleColor:COLOR(0, 0, 0, 1) forState:UIControlStateNormal];
     [self.btn5 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.btn5.tag = 104;
     [self.view addSubview:self.btn5];
     [self.btn5 addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
     
     self.btn6 = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(266), HEIGHT5S(64), WIDTH5S(53), HEIGHT5S(40))];
     self.btn6.backgroundColor = COLOR(255, 255, 255, 1);
     [self.btn6 setTitle:@"饮食" forState:UIControlStateNormal];
     [self.btn6 setTitleColor:COLOR(0, 0, 0, 1) forState:UIControlStateNormal];
     [self.btn6 setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     self.btn6.tag = 105;
     [self.view addSubview:self.btn6];
     [self.btn6 addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
     
     UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(103), SCREEN_WIDTH, HEIGHT5S(1))];
     line.backgroundColor = COLOR(228, 228, 228, 1);
     [self.view addSubview:line];
     
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     
     return self.i;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     CGFloat h;
     
     if (self.picArr.count == 0) {
          h = 80;
     }else if (self.picArr.count > 0){
          h = 270;
     }
     
     return h;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     static NSString *Identifier;
     
     if (self.picArr.count == 0) {
          Identifier = @"nilPic";
          PostListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
          if (cell == nil) {
               cell = [[PostListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
          }
          cell.userImg.image = IMAGE(@"cat");
          cell.userName.text = @"iphone";
          cell.tagLabel.text = @"养生";
          cell.postTitle.text =  [self.result[indexPath.row] objectForKey:@"post_title"];
          cell.date.text = [self.result[indexPath.row] objectForKey:@"post_time"];
          cell.colNum.text = @"998";
          cell.comNum.text = @"325";
          return cell;
     }else{
          
          Identifier = @"havePic";
          PostListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
          if (cell == nil) {
               cell = [[PostListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
          }
          cell.userImg.image = IMAGE(@"cat");
          cell.userName.text = @"iphone";
          cell.tagLabel1.text = @"养生";
          cell.postTitle1.text = [self.result[indexPath.row] objectForKey:@"post_title"];
          //调用label自适高方法
          //          [cell setupLabel:[self.result[indexPath.row] objectForKey:@"post_title"]];
          cell.date.text = [self.result[indexPath.row] objectForKey:@"post_time"];
          cell.colNum1.text = @"325";
          cell.comNum1.text = @"998";
          cell.img.image = IMAGE(self.picArr[0]);
          return cell;
     }
     
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
     
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
     
     PostDetailViewController *pdv = [[PostDetailViewController alloc]init];
     pdv.hidesBottomBarWhenPushed = YES;
     pdv.str=[self.result[indexPath.row]objectForKey:@"post_id"];
     [self.navigationController pushViewController:pdv animated:YES];
     
}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     
}


@end
