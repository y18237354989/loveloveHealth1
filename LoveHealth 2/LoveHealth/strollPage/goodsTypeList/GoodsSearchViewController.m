//
//  GoodsSearchViewController.m
//  逛一逛Tableview
//
//  Created by Administrator on 16/3/31.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "GoodsSearchViewController.h"
#import "GoodsTypeListViewController.h"
@interface GoodsSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchControllerDelegate,UISearchBarDelegate>


@property(strong,nonatomic)UISearchController *searchController;

@property (strong,nonatomic)UITableView *mytable;

@property(strong,nonatomic)NSMutableArray *searchList;

@property (strong,nonatomic)NSArray *goodsTypeArr;

@end

@implementation GoodsSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.navigationItem.title = @"商品分类";
     self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self create];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)create{
    self.goodsTypeArr = @[@"常用西药",@"养生中药",@"健身器材",@"癣症",@"抗菌消炎",@"健脾益肾",@"肠胃用药",@"抗病毒类",@"风湿外骨伤",@"白发脱发",@"感冒咳嗽",@"维矿物质",@"鼻",@"肝胆用药",@"解热镇痛",@"补气补血",@"咽喉",@"心胸血管",@"仰卧板",@"哑铃",@"力量训练器",@"拉力器",@"健身车",@"臂力器",@"健腹轮",@"跑步机",@"单双杠",@"甩脂机",@"举重床",@"跳绳",@"杠铃",@"握力器",@"俯卧撑架",@"拳击",@"美腿机",@"扭腰盘",@"倒立机"];
    
     self.searchList = [NSMutableArray arrayWithCapacity:0];
    
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    self.searchController.searchResultsUpdater = self;
    
    self.searchController.delegate = self;
    
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44);
    self.searchController.searchBar.delegate = self;
    
    self.mytable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.mytable.dataSource = self;
    self.mytable.delegate = self;
    self.mytable.tableFooterView = [[UIView alloc]init];
    self.mytable.tableHeaderView = self.searchController.searchBar;
    [self.view addSubview:self.mytable];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchController.active) {
        return self.searchList.count;
    }else{
        return self.goodsTypeArr.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid = @"search";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    if (self.searchController.active) {
        cell.textLabel.text = self.searchList[indexPath.row];
    }else{
        cell.textLabel.text = self.goodsTypeArr[indexPath.row];
    }
    return cell;
}
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSString *str1 = self.searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",str1];
    if (self.searchList!=nil) {
        [self.searchList removeAllObjects];
    }
    self.searchList = [NSMutableArray arrayWithArray:[self.goodsTypeArr filteredArrayUsingPredicate:predicate]];
    [self.mytable reloadData];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.searchController.active){
        NSLog(@"-2-->%@",self.searchList[indexPath.row]);
    }else{
        NSLog(@"-1-->%@",self.goodsTypeArr[indexPath.row]);
    }
    
    GoodsTypeListViewController *typeVC = [[GoodsTypeListViewController alloc]init];
    [self.navigationController pushViewController:typeVC animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.searchController.active) {
        self.searchController.active = NO;
        [self.searchController.searchBar removeFromSuperview];
    }
}

@end
