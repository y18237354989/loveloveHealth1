//
//  MyCollectViewController.m
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "MyCollectViewController.h"
#import "Header.h"

@interface MyCollectViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)UIButton *newsBtn;

@property (strong, nonatomic)UIButton *postBtn;

@property (strong, nonatomic)UIButton *shopBtn;

@end

@implementation MyCollectViewController

- (void)viewWillAppear:(BOOL)animated{
     
     self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = COLOR(242, 242, 242, 1);
     
     self.navigationItem.title = @"我的收藏";
     self.navigationController.navigationBar.tintColor = COLOR(255, 255, 255, 1);
     
     self.myCollectTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(520)) style:UITableViewStylePlain];
     self.myCollectTable.dataSource = self;
     self.myCollectTable.delegate = self;
     [self.view addSubview:self.myCollectTable];
     
     self.myCollectTable.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(40))];
     [self.myCollectTable addSubview:self.myCollectTable.tableHeaderView];
     
     [self createControl];
}

//创建控件
- (void)createControl{
   
     self.newsBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(106), HEIGHT5S(40))];
     [self.newsBtn setTitle:@"新闻收藏" forState:UIControlStateNormal];
     [self.newsBtn setTitleColor:COLOR(100, 100, 100, 1) forState:UIControlStateNormal];
     [self.newsBtn setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     [self.myCollectTable.tableHeaderView addSubview:self.newsBtn];
     
     self.postBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(107), 0, WIDTH5S(107), HEIGHT5S(40))];
     [self.postBtn setTitle:@"热帖收藏" forState:UIControlStateNormal];
     [self.postBtn setTitleColor:COLOR(100, 100, 100, 1) forState:UIControlStateNormal];
     [self.postBtn setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     [self.myCollectTable.tableHeaderView addSubview:self.postBtn];
     
     self.shopBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(214), 0, WIDTH5S(106), HEIGHT5S(40))];
     [self.shopBtn setTitle:@"店铺收藏" forState:UIControlStateNormal];
     [self.shopBtn setTitleColor:COLOR(100, 100, 100, 1) forState:UIControlStateNormal];
     [self.shopBtn setTitleColor:COLOR(0, 210, 210, 1) forState:UIControlStateSelected];
     [self.myCollectTable.tableHeaderView addSubview:self.shopBtn];
     
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     
     return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     static NSString *str = @"collect";
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
     if (cell == nil) {
          cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
     }
     
     return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
