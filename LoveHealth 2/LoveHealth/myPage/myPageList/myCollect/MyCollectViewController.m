//
//  MyCollectViewController.m
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "MyCollectViewController.h"
#import "Header.h"
#import "collectServerce.h"
#import "PostDetailViewController.h"
#import "NewsDetailViewController.h"

@interface MyCollectViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)UIButton *newsBtn;

@property (strong, nonatomic)UIButton *postBtn;

@property (strong, nonatomic)UIButton *shopBtn;

@property(assign,nonatomic)long int a;

@property(strong,nonatomic)NSDictionary *dic;

@property(strong,nonatomic)NSArray *collectArr;

@property(copy,nonatomic)NSString  *userid;

@property(assign,nonatomic)int i;

@end

@implementation MyCollectViewController

- (void)viewWillAppear:(BOOL)animated{
     
     self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = COLOR(242, 242, 242, 1);
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    
    self.userid=[user objectForKey:@"userid"];
    
    
     self.navigationItem.title = @"我的收藏";
     self.navigationController.navigationBar.tintColor = COLOR(255, 255, 255, 1);
     
     self.myCollectTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(520)) style:UITableViewStylePlain];
     self.myCollectTable.dataSource = self;
     self.myCollectTable.delegate = self;
     [self.view addSubview:self.myCollectTable];
     
     self.myCollectTable.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(40))];
     [self.myCollectTable addSubview:self.myCollectTable.tableHeaderView];
    
    self.myCollectTable.tableFooterView=[[UIView alloc]init];
    
     [self getnews];
    
     [self createControl];
}

//创建控件
- (void)createControl{
   
     self.newsBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(106), HEIGHT5S(40))];
     [self.newsBtn setTitle:@"新闻收藏" forState:UIControlStateNormal];
     [self.newsBtn setTitleColor:COLOR(100, 100, 100, 1) forState:UIControlStateNormal];
     [self.newsBtn setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
    [self.newsBtn addTarget:self action:@selector(getnews) forControlEvents:UIControlEventTouchUpInside];
     [self.myCollectTable.tableHeaderView addSubview:self.newsBtn];
     
     self.postBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(107), 0, WIDTH5S(107), HEIGHT5S(40))];
     [self.postBtn setTitle:@"热帖收藏" forState:UIControlStateNormal];
     [self.postBtn setTitleColor:COLOR(100, 100, 100, 1) forState:UIControlStateNormal];
     [self.postBtn setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
    [self.postBtn addTarget:self action:@selector(getpost) forControlEvents:UIControlEventTouchUpInside];
     [self.myCollectTable.tableHeaderView addSubview:self.postBtn];
     
     self.shopBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(214), 0, WIDTH5S(106), HEIGHT5S(40))];
     [self.shopBtn setTitle:@"店铺收藏" forState:UIControlStateNormal];
     [self.shopBtn setTitleColor:COLOR(100, 100, 100, 1) forState:UIControlStateNormal];
     [self.shopBtn setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
    [self.shopBtn addTarget:self action:@selector(getshop) forControlEvents:UIControlEventTouchUpInside];
     [self.myCollectTable.tableHeaderView addSubview:self.shopBtn];
     
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     
     return _a;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (_i==1) {
        NewsDetailViewController *news=[[NewsDetailViewController alloc]init];
        news.hidesBottomBarWhenPushed = YES;
        news.newsid=[self.collectArr[indexPath.row]objectForKey:@"news_id"];
        [self.navigationController pushViewController:news animated:YES];
    }else if (_i==2){
        
        
        
    }else{
        
        PostDetailViewController *pdv = [[PostDetailViewController alloc]init];
        pdv.hidesBottomBarWhenPushed = YES;
        pdv.str=[self.collectArr[indexPath.row]objectForKey:@"post_id"];
        [self.navigationController pushViewController:pdv animated:YES];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     static NSString *str = @"collect";
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
     if (cell == nil) {
          cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
     }
    NSString *strs;
    if (_i==1) {
        strs=[_collectArr[indexPath.row] objectForKey:@"news_title"];
    }else if(_i==2){
        strs=[_collectArr[indexPath.row] objectForKey:@"shop_name"];
   
    }else{
        strs=[_collectArr[indexPath.row] objectForKey:@"post_title"];
    }
    cell.textLabel.text=strs;
     return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getnews{
    self.i=1;
   [collectServerce newscollect:_userid and:^(NSMutableDictionary *dic) {
       self.dic =dic;
       NSLog(@"++++++%@",self.dic);
       if ([[self.dic objectForKey:@"message"] isEqualToString:@"查询失败"]) {
           NSLog(@"null data");
           self.a = 0;
           
       }else{
           
           self.collectArr = [self.dic objectForKey:@"result"];
           self.a   = self.collectArr.count;
           
       }
       [self.myCollectTable reloadData];
       
   }];
    
    
}
-(void)getshop{
    self.i=2;
    [collectServerce shopcollect:_userid and:^(NSMutableDictionary *dic) {
        self.dic =dic;
        NSLog(@"++++++%@",self.dic);
        if ([[self.dic objectForKey:@"message"] isEqualToString:@"查询失败"]) {
            NSLog(@"null data");
            self.a = 0;
            
        }else{
            
            self.collectArr = [self.dic objectForKey:@"result"];
            self.a   = self.collectArr.count;
            
        }
        [self.myCollectTable reloadData];
        
    }];
 
    
}
-(void)getpost{
    self.i=3;
    [collectServerce shopcollect:_userid and:^(NSMutableDictionary *dic) {
        self.dic =dic;
        NSLog(@"++++++%@",self.dic);
        if ([[self.dic objectForKey:@"message"] isEqualToString:@"查询失败"]) {
            NSLog(@"null data");
            self.a = 0;
            
        }else{
            
            self.collectArr = [self.dic objectForKey:@"result"];
            self.a   = self.collectArr.count;
            
        }
        [self.myCollectTable reloadData];
        
    }];
 
    
    
}




@end
