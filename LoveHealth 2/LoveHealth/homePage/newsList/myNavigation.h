//
//  myNavigation.h
//  ios-自定义导航栏-0222
//
//  Created by administrator on 16/2/22.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myNavigation : UIView

@property (strong, nonatomic)UIImageView *bgImg;

@property (strong, nonatomic)UILabel *titleLabel;

@property (strong, nonatomic)UIImageView *titleImg;

@property (strong, nonatomic)UIButton *leftBtn;

@property (strong, nonatomic)UIButton *rightBtn;

- (instancetype)initWithBgImg:(NSString *)bgImg andTitleLabel:(NSString *)titleLabel andTitleImg:(NSString *)titleImg andleftBtn:(NSString *)leftBtn andRightBtn:(NSString *)rightBtn;

@end
