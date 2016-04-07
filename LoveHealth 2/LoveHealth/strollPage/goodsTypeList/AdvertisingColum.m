//
//  AdvertisingColum.m
//  逛一逛Tableview
//
//  Created by Administrator on 16/3/30.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "AdvertisingColum.h"
#import "Header.h"

@implementation AdvertisingColum

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (instancetype)initWithFrame:(CGRect)frame{
     self = [super initWithFrame:frame];
     if (self) {
          self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
          self.scrollView.contentSize = CGSizeMake(320*5, CGRectGetHeight(self.frame));
          //        self.scrollView.delegate = self;
          self.scrollView.showsVerticalScrollIndicator = NO;//是否显示竖向滚动条
          self.scrollView.showsHorizontalScrollIndicator = NO;//是否显示横向滚动条
          self.scrollView.pagingEnabled = YES;//是否设置分页
          [self addSubview:self.scrollView];
          
          self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(WIDTH5S(150), HEIGHT5S(140), 10, 10)];
          self.pageControl.alpha = 0.5;
          self.pageControl.pageIndicatorTintColor = COLOR(255, 255, 255, 1);//正常色
          self.pageControl.currentPageIndicatorTintColor = COLOR(0, 210, 210, 1);//选中色
          self.pageControl.numberOfPages = 4;
          [self addSubview:self.pageControl];
          
          
          for (int i = 0; i<5; i++) {
               UIImageView *image = [[UIImageView alloc]init];
               image.frame = CGRectMake(WIDTH5S(320)*i, 0, WIDTH5S(320), CGRectGetHeight(self.frame));
               image.image = [UIImage imageNamed:@"cat"];
               [self.scrollView addSubview:image];
          }
     }
     
     [self timerStart];
     
     return self;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
     
     [self timerStop];
     
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
     
     [self timerStart];
     
}

- (void)timerStart{
     self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(test) userInfo:nil repeats:YES];
}
- (void)timerStop{
     [self.timer invalidate];
     self.timer = nil;
}

#pragma mark - 定时器方法
-(void)test{
     if (self.i == 4) {
          self.i =0;
          [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
          self.i++;
          [self.scrollView setContentOffset:CGPointMake(WIDTH5S(320)*self.i, 0) animated:YES];
          
     }else{

          self.i++;
          [self.scrollView setContentOffset:CGPointMake(WIDTH5S(320)*self.i, 0) animated:YES];
          
     }
     
     if (self.i == 4) {
          self.pageControl.currentPage = 0;
     }else{
          self.pageControl.currentPage = self.i;
     }
}
@end
