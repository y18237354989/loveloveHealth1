//
//  ReCommentViewController.h
//  LoveHealth
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsDetailViewController.h"

@interface ReCommentViewController : UIViewController

@property (strong, nonatomic)UITableView *reCommentTable;//评论回复页

@property (copy, nonatomic)NSString *placeLabel;

@property (assign, nonatomic)id<RecommentDelegate>delegate;

@end
