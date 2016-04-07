//
//  MyPageListViewController.m
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "MyPageListViewController.h"
#import "Header.h"
#import "nearlistViewController.h"
#import "newsServerceViewController.h"
#import "MyOrderViewController.h"

@interface MyPageListViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MyPageListViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
 
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(320), HEIGHT5S(160))];
     self.bgView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.bgView];
     
     self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 160, WIDTH5S(320), HEIGHT5S(360)) style:UITableViewStyleGrouped];
     self.myTable.dataSource = self;
     self.myTable.delegate = self;
     self.myTable.scrollEnabled = NO;
     [self.view addSubview:self.myTable];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     
     return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     if (section == 0) {
          return 20;
     }else{
          return 0.1+5;
     }
     
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     
     int num;
     
     if (section == 0) {
          num = 5;
     }else if (section == 1){
          num = 2;
     }
     
     return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     static NSString *Identifier = @"myTable";
     
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
     
     if (cell == nil) {
          cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
     }
     
      NSArray *arr = @[@"我的收藏", @"我的消息",@"我的贴子", @"我的订单", @"我的购物车", @"意见反馈", @"设置"];
     
     UILabel *textLab = [[UILabel alloc]initWithFrame:CGRectMake(52, 10, WIDTH5S(100), HEIGHT5S(22))];
     
     [cell addSubview:textLab];
     if (indexPath.section == 0) {
          textLab.text = arr[indexPath.row];
     }else{
          textLab.text = arr[indexPath.row + 5];
     }
     
     
     return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     
//     [newsServerceViewController newsServerce1:^(NSDictionary *dic) {
//          
//          NSLog(@"%@",dic);
//     }];
     
    if (indexPath.section==0) {
        if (indexPath.row==1) {
            self.navigationController.navigationBar.hidden=NO;
            nearlistViewController *ner=[[nearlistViewController alloc]init];
            [self.navigationController pushViewController:ner animated:YES];
        
        }else if (indexPath.row == 3){
             
             MyOrderViewController *mvc = [[MyOrderViewController alloc]init];
             [self.navigationController pushViewController:mvc animated:YES];
        }
         
    }
    
     
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
