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


@interface PostListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic)NSArray *result;

@property (assign,nonatomic)long int i;

@end

@implementation PostListViewController

//返回取消系统导航隐藏
- (void)viewWillAppear:(BOOL)animated{
     
     self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     //设置导航栏标题字体大小和颜色
     [self.navigationController.navigationBar setTitleTextAttributes:
      @{NSFontAttributeName:FONT(18),
        NSForegroundColorAttributeName:COLOR(255, 255, 255, 1)}];
    self.view.backgroundColor = [UIColor blueColor];
     
     UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"发帖" style:UIBarButtonItemStylePlain target:self action:@selector(sendPost)];
     [rightItem setTintColor:COLOR(255, 255, 255, 1)];
     self.navigationItem.rightBarButtonItem = rightItem;
     
     self.postTable = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(0), SCREEN_WIDTH, HEIGHT5S(568)) style:UITableViewStylePlain];
     self.postTable.dataSource = self;
     self.postTable.delegate = self;
     self.postTable.separatorStyle = NO;  //隐藏cell自带的分割线
     [self.view addSubview:self.postTable];
     
     self.picArr = [NSMutableArray arrayWithCapacity:0];
     [self.picArr addObject:@"1.1.jpg"];
    
    //判断请求数据是否为空
    if (self.result == nil) {
        self.i =0;
    }else{
        if (self.result.count<5) {
            self.i = self.result.count;
        }else{
            self.i = 5;
        }
    }
   
    
    NSDictionary *dic =@{@"postType":@"1",
                         @"pageindex":@"1"
                         };
    [PostServerce getPostWithDic:dic andWith:^(NSDictionary *dics) {
        NSDictionary *newdic1 = dics;
        self.result = [newdic1 objectForKey:@"result"];
        NSLog(@"%@",self.result);
    }];
    //下拉刷新
    [self DropDownRefresh];
    //上拉刷新
    [self PullRefresh];

}
//下拉刷新
-(void)DropDownRefresh{
    self.postTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSDictionary *dic =@{@"postType":@"1",
                             @"pageindex":@"1"
                             };
        [PostServerce getPostWithDic:dic andWith:^(NSDictionary *dics) {
            NSDictionary *newdic1 = dics;
            self.result = [newdic1 objectForKey:@"result"];
            NSLog(@"%@",self.result);
            [self.postTable reloadData];
            
            self.i = self.i + 3;
            [self.postTable reloadData];
            [self.postTable.mj_header endRefreshing];
            if (self.result == nil) {
                self.i=0;
                [self.postTable.mj_header endRefreshing];
            }else{
                if (self.i>self.result.count) {
                    self.i = _result.count;
                    [self.postTable reloadData];
                    [self.postTable.mj_header endRefreshing];
                }
            }
            
        }];
    }];
}
//上拉刷新
-(void)PullRefresh{
    self.postTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        NSDictionary *dic =@{@"postType":@"1",
                             @"pageindex":@"1"
                             };
        [PostServerce getPostWithDic:dic andWith:^(NSDictionary *dics) {
            NSDictionary *newdic1 = dics;
            self.result = [newdic1 objectForKey:@"result"];
            NSLog(@"%@",self.result);
            
            self.i = self.i + 3;
            [self.postTable reloadData];
            [self.postTable.mj_footer endRefreshing];
            if (self.result == nil) {
                self.i = 0;
            }else{
                if (self.i>self.result.count) {
                    self.i = _result.count;
                    [self.postTable reloadData];
                    [self.postTable.mj_footer endRefreshingWithNoMoreData];
                    self.postTable.mj_footer.hidden = YES;
                }
            }
            
        }];
    }];
}

//发帖
- (void)sendPost{
     
     SendPostViewController *spv = [[SendPostViewController alloc]init];
     spv.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:spv animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     
     return self.i;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     CGFloat h;
     
     if (self.picArr.count == 0) {
          h = 80;
     }else if (self.picArr.count > 0){
          h = 130;
     }
     
     return h;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     static NSString *Identifier;
     
     PostListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
     
     if (self.picArr.count == 0) {
          Identifier = @"nilPic";
          if (cell == nil) {
               cell = [[PostListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
          }
          cell.userImg.image = IMAGE(@"cat");
          cell.userName.text = @"iphone";
          cell.tagLabel.text = @"养生";
          cell.postTitle.text =  [self.result[indexPath.row] objectForKey:@"post_title"];
          cell.date.text = [self.result[indexPath.row] objectForKey:@"post_time"];
          cell.commentImg.image = IMAGE(@"talk");
          cell.comNum.text = @"9999";
          cell.collectImg.image = IMAGE(@"star");
          cell.colNum.text = @"998";
     }else if (self.picArr.count > 0){
          
          Identifier = @"havePic";
          if (cell == nil) {
               cell = [[PostListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
          }
          cell.userImg.image = IMAGE(@"cat");
          cell.userName.text = @"iphone";
          cell.tagLabel1.text = @"养生";
          cell.postTitle1.text = [self.result[indexPath.row] objectForKey:@"post_title"];
          cell.date.text = [self.result[indexPath.row] objectForKey:@"post_time"];
          cell.commentImg1.image = IMAGE(@"talk");
          cell.comNum1.text = @"9999";
          cell.collectImg1.image = IMAGE(@"star");
          cell.colNum1.text = @"998";
          cell.img.image = IMAGE(self.picArr[0]);
     }
     
     return cell;
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
