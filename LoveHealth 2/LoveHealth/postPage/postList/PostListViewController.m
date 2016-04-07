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

@interface PostListViewController ()<UITableViewDataSource,UITableViewDelegate>

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
     
     self.postTable = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(0), SCREEN_WIDTH, HEIGHT5S(520)) style:UITableViewStylePlain];
     self.postTable.dataSource = self;
     self.postTable.delegate = self;
     self.postTable.separatorStyle = NO;  //隐藏cell自带的分割线
     [self.view addSubview:self.postTable];
     
     self.picArr = [NSMutableArray arrayWithCapacity:0];
     [self.picArr addObject:@"1.1.jpg"];
}
//发帖
- (void)sendPost{
     
     SendPostViewController *spv = [[SendPostViewController alloc]init];
     spv.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:spv animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     
     return 5;
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
          cell.postTitle.text = @"今天天气不错今天天气jj";
          cell.date.text = @"2016-04-06";
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
          cell.postTitle1.text = @"今天天气不错今天天气错今天天气";
          cell.date.text = @"2016-04-06";
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
     [self.navigationController pushViewController:pdv animated:YES];
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
