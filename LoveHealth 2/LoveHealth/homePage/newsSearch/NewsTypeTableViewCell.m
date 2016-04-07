//
//  NewsTypeTableViewCell.m
//  搜索联想
//
//  Created by Administrator on 16/3/29.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "NewsTypeTableViewCell.h"

@implementation NewsTypeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.btn = [[UIButton alloc]init];
        [self.btn setImage:[UIImage imageNamed:@"Add_48px_1166404_easyicon.net"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.btn];
        
        self.label = [[UILabel alloc]init];
        self.label.textAlignment = NSTextAlignmentLeft;
        self.label.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.label];
    }
    return self;
}

-(void)layoutSubviews{
    self.btn.frame = CGRectMake(290, 10, 20, 20);
    self.label.frame = CGRectMake(10, 10, 100, 30);
}

@end
