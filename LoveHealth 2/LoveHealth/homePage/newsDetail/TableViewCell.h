//
//  TableViewCell.h
//  LoveHealth
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (strong, nonatomic) UIView      *views;
@property (strong, nonatomic) UIImageView *images;
@property (strong, nonatomic) UILabel     *namelable;
@property (strong, nonatomic) UILabel     *commentlable;
@property (strong, nonatomic) UIButton    *buttons;
@property (strong, nonatomic) UILabel     *reCommentNumber;
@property (strong, nonatomic) UILabel     *timelable;
@property (assign, nonatomic) double      d;
-(void)setIntroductionText:(NSString *)text;

//-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
//

@end
