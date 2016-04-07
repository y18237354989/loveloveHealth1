//
//  newsServerceViewController.h
//  LoveHealth
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newsServerceViewController : UIViewController

+ (void)newsServerce:(void(^)(NSDictionary *newsDic))success;

+ (void)newsServerce1:(void (^)(NSDictionary *dic))success;

@end
