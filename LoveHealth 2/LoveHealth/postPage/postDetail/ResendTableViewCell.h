//
//  ResendTableViewCell.h
//  LoveHealth
//
//  Created by administrator on 16/4/9.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResendTableViewCell : UITableViewCell

@property (strong, nonatomic)UIImageView *userhead;

@property (strong, nonatomic)UILabel *username;

@property (strong, nonatomic)UILabel *sendword;

@property (strong, nonatomic)UILabel *time;

@property (assign, nonatomic)double h;

-(void)setIntroductionText:(NSString *)text;

@end
