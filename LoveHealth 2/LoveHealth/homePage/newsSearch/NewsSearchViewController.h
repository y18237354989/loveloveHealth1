//
//  NewsSearchViewController.h
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsListViewController.h"
@interface NewsSearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchControllerDelegate,UISearchBarDelegate>

@property(assign,nonatomic)id<NewsTypeDelegate>delegate;
@property(strong,nonatomic)NSString *str;


@property(strong,nonatomic)UISearchController *searchC;

@property (strong,nonatomic)UITableView *mytable;

@property(strong,nonatomic)NSMutableArray *searchList;

@property(strong,nonatomic)NSArray *newsTypeArr;

@end
