//
//  CommentTableViewCell.h
//  LoveHealth
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell

@property (strong, nonatomic) UIView      *views;
@property (strong, nonatomic) UIImageView *images;
@property (strong, nonatomic) UILabel     *namelable;
@property (strong, nonatomic) UILabel     *commentlable;
@property (strong, nonatomic) UIButton    *buttons;
@property (strong, nonatomic) UILabel     *reCommentNumber;
@property (strong, nonatomic) UILabel     *timelable;
@property (assign, nonatomic) double      d;

-(void)setIntroductionText:(NSString *)text;

@end
