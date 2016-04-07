//
//  NewsSearchViewController.m
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "NewsSearchViewController.h"
#import "NewsTypeTableViewCell.h"
#import "NewsListViewController.h"

@interface NewsSearchViewController ()

@end

@implementation NewsSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"新闻分类";
     self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self create];
}

- (void)create{
    
    self.newsTypeArr = @[@"推荐",@"健康",@"养生",@"中医",@"高血压",@"糖尿病",@"皮肤病",@"感冒",@"乙肝",@"胃炎",@"结石",@"鼻炎",@"湿疹",@"中风",@"小儿肺炎",@"脂肪肝",@"失眠",@"小儿哮喘",@"阑尾炎",@"抑郁症",@"针灸",@"艾灸",@"刮痧",@"拔火罐",@"抗癌",@"痔疮",@"癌症",@"脚气",@"腹泻",@"狂躁症",@"禽流感",@"自闭症",@"社交恐惧症",@"帕金森氏症",@"视网膜脱落",@"飞蚊症",@"风疹",@"甲沟炎",@"肺栓塞",@"晕动症",@"天麻",@"防治三高",@"痉挛",@"脑瘫",@"听觉障碍",@"腰椎间盘突出",@"冻伤",@"睾丸癌",@"麻疹",@"扁桃体炎",@"口腔溃炎",@"疟疾",@"鼻塞",@"多动症",@"沙眼",@"骨折",@"高山症",@"弱视",@"心脏病",@"心理健康",@"颈椎",@"急救知识",@"亚健康",@"壮阳",@"戒酒",@"太极拳",@"孕期心理",@"节后综合症",@"睡眠",@"眼保健康"];
    
    self.searchList = [NSMutableArray arrayWithCapacity:0];
    //    ssViewController *ss = [[ssViewController alloc]init];
    self.searchC = [[UISearchController alloc]initWithSearchResultsController:nil];
    
    self.searchC.dimsBackgroundDuringPresentation = NO;
    
    self.searchC.searchResultsUpdater = self;
    
    self.searchC.delegate = self;
    
    self.searchC.searchBar.frame = CGRectMake(self.searchC.searchBar.frame.origin.x, self.searchC.searchBar.frame.origin.y, self.searchC.searchBar.frame.size.width, 44);
    
    self.searchC.searchBar.delegate = self;
    
    //    self.searchC.searchBar.searchResultsButtonSelected = YES;
    //    self.searchC.searchBar.showsSearchResultsButton=YES;
    
    self.mytable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.mytable.dataSource = self;
    self.mytable.delegate = self;
    self.mytable.tableFooterView = [[UIView alloc]init];
    self.mytable.tableHeaderView = self.searchC.searchBar;
    [self.view addSubview:self.mytable];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchC.active) {
        return self.searchList.count;
    }else{
        return self.newsTypeArr.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid = @"search";
    NewsTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        cell = [[NewsTypeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    if (self.searchC.active) {
        cell.label.text = self.searchList[indexPath.row];
        cell.btn.tag = indexPath.row;
    }else{
        cell.label.text = self.newsTypeArr[indexPath.row];
        cell.btn.tag = indexPath.row;
    }
    [cell.btn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSString *str1 = self.searchC.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",str1];
    if (self.searchList!=nil) {
        [self.searchList removeAllObjects];
    }
    self.searchList = [NSMutableArray arrayWithArray:[self.newsTypeArr filteredArrayUsingPredicate:predicate]];
    [self.mytable reloadData];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"-1-->%@",self.newsTypeArr[indexPath.row]);
    
}

- (void)test:(UIButton *)sender{
    
//    if (self.searchC.active) {
//        NSLog(@"%ld",sender.tag);
//        NSLog(@"-2-->%@",self.searchList[sender.tag]);
//    }else{
//        NSLog(@"%ld",sender.tag);
//        NSLog(@"-3-->%@",self.newsTypeArr[sender.tag]);
//    }
    
//        [self.navigationController popViewControllerAnimated:YES];
    if (_delegate !=nil&&[_delegate respondsToSelector:@selector(receiveValue:)]) {
        
        if (self.searchC.active) {
//            NSLog(@"%ld",sender.tag);
//            NSLog(@"-2-->%@",self.searchList[sender.tag]);
            [_delegate receiveValue:self.searchList[sender.tag]];
        }else{
//            NSLog(@"%ld",sender.tag);
//            NSLog(@"-3-->%@",self.newsTypeArr[sender.tag]);
            [_delegate receiveValue:self.newsTypeArr[sender.tag]];
        }
        
//        [_delegate receiveValue:self.newsTypeArr[sender.tag]];
        [self.navigationController popViewControllerAnimated:YES];
    }
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
