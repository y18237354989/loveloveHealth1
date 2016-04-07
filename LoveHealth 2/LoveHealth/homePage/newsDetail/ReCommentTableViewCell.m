//
//  ReCommentTableViewCell.m
//  LoveHealth
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "ReCommentTableViewCell.h"
#import "Header.h"

@implementation ReCommentTableViewCell

- (void)awakeFromNib {
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
     self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
          
          
          self.namelable=[[UILabel alloc]init];
          [self.contentView addSubview:self.namelable];
          
          self.reCommentlable=[[UILabel alloc]init];
          self.reCommentlable.numberOfLines=0;
          [self.contentView addSubview:self.reCommentlable];
          
          self.timelable=[[UILabel alloc]init];
          [self.contentView addSubview:self.timelable];
                    
     }
     return self;
}
-(void)layoutSubviews{
     [super layoutSubviews];
     self.namelable.frame=CGRectMake(15, 10, WIDTH5S(120), HEIGHT5S(20));
     self.timelable.frame=CGRectMake(WIDTH5S(185), 10, WIDTH5S(120), HEIGHT5S(20));
     self.reCommentlable.frame=CGRectMake(15, WIDTH5S(40), WIDTH5S(300), HEIGHT5S(_d));

}


-(void)setIntroductionText:(NSString *)text{
     CGRect frame=[self frame];
     
     self.reCommentlable.text=text;
     self.reCommentlable.font=[UIFont systemFontOfSize:12];
     
     CGRect textSize = [text boundingRectWithSize:CGSizeMake(WIDTH5S(300), 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
     
     _d=textSize.size.height;
     
     frame.size.height=textSize.size.height+HEIGHT5S(50);
     
     self.frame=frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
