//
//  SetTableViewCell.m
//  LoveHealth
//
//  Created by Administrator on 16/4/11.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "SetTableViewCell.h"
#import "Header.h"
@implementation SetTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
       
        self.img = [[UIImageView alloc]init];
        [self.contentView addSubview:self.img];
        
        self.label = [[UILabel alloc]init];
        self.label.font = FONT(15);
        self.label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.label];
        
        self.img2 = [[UIImageView alloc]init];
        [self.contentView addSubview:self.img2];
        
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.img.frame = CGRectMake(15, 10, 22, 22);
    self.label.frame = CGRectMake(52, 10, 62, 22);
    
}

@end
