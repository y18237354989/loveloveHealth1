//
//  AdvertisingColum.h
//  逛一逛Tableview
//
//  Created by Administrator on 16/3/30.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertisingColum : UIView<UIScrollViewDelegate>

@property(strong,nonatomic) UIScrollView *scrollView;

@property(strong,nonatomic) UIPageControl *pageControl;

@property(strong,nonatomic) NSTimer *timer;

@property(assign,nonatomic) int i;

@end
