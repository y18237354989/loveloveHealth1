//
//  ReCommentTableViewCell.h
//  LoveHealth
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReCommentTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *namelable;

@property (strong, nonatomic) UILabel *reCommentlable;

@property (strong, nonatomic) UILabel *timelable;

@property (assign, nonatomic) double d;

-(void)setIntroductionText:(NSString *)text;

@end
