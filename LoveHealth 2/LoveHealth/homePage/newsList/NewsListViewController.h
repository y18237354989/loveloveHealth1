//
//  NewsListViewController.h
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewsTypeDelegate <NSObject>

- (void)receiveValue:(NSString *)value;

@end

@interface NewsListViewController : UIViewController<NewsTypeDelegate>


@property (strong, nonatomic)UITableView *newsListTable;

//标题scroll
@property (strong, nonatomic)UIScrollView *titleScroll;
//图片主题scroll
@property (strong, nonatomic)UIScrollView *imageScroll;

//新闻分类数组
@property (strong, nonatomic)NSMutableArray *newsTypeArr;


//接收新闻数据的字典
@property (strong, nonatomic)NSDictionary *newsDataDic;

@end
