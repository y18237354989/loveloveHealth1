//
//  PostListViewController.h
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostListViewController : UIViewController

@property (strong, nonatomic)UITableView *postTable;

@property (strong, nonatomic)NSMutableDictionary *dataDic;  //服务器帖子数据

@property (strong, nonatomic)NSMutableArray *picArr; //存放图片

@end
