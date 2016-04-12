//
//  NewsDetailViewController.h
//  爱健康
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RecommentDelegate <NSObject>

- (void)printText:(NSString *)str;

@end

@interface NewsDetailViewController : UIViewController<RecommentDelegate>

@property(strong,nonatomic)NSArray *imgarr;

@property (copy, nonatomic)NSString *newsid;

@end
