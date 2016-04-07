//
//  myNavigation.m
//  ios-自定义导航栏-0222
//
//  Created by administrator on 16/2/22.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import "myNavigation.h"
#import "Header.h"

@implementation myNavigation


-(instancetype)initWithBgImg:(NSString *)bgImg andTitleLabel:(NSString *)titleLabel andTitleImg:(NSString *)titleImg andleftBtn:(NSString *)leftBtn andRightBtn:(NSString *)rightBtn{
     
     self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
     
     if (self) {
          if (bgImg) {
               self.bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
               self.bgImg.image = [UIImage imageNamed:bgImg];
          }else{
               self.bgImg.backgroundColor = [UIColor greenColor];
          }
          [self addSubview:self.bgImg];
          
          if (titleLabel) {
               self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 200)/2, 30, 200, 20)];
               self.titleLabel.text = titleLabel;
              self.titleLabel.textAlignment=1;
              self.titleLabel.textColor=[UIColor whiteColor];
              self.titleLabel.font=[UIFont systemFontOfSize:18];
               [self addSubview:self.titleLabel];
          }else{
               if (titleImg) {
                    self.titleImg = [[UIImageView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 40)/2, 15, 40, 40)];
                   self.titleImg.image = [UIImage imageNamed:titleImg];
                    [self addSubview:self.titleImg];
               }else{
                    
               }
          }
          
          if (leftBtn) {
               self.leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 20, 20)];
               [self.leftBtn setBackgroundImage:[UIImage imageNamed:leftBtn] forState:UIControlStateNormal];

               [self addSubview:self.leftBtn];
          }else{
               
          }
          
          
          if (rightBtn) {
               self.rightBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 30, 30, 20, 20)];
             [self.rightBtn setBackgroundImage:[UIImage imageNamed:rightBtn] forState:UIControlStateNormal];
               [self addSubview:self.rightBtn];

          }else{
               
          }
          
     }
     return self;
}
//-(void)toox{
//    
//     [self.navigationController popViewControllerAnimated:YES];
//    
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
