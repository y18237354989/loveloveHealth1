//
//  CommentTableViewCell.m
//  LoveHealth
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "Header.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
     self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
          
          self.views=[[UIView alloc]init];
          [self.contentView addSubview:_views];
          
          self.images=[[UIImageView alloc]init];
          [self.views addSubview:self.images];
          
          self.namelable=[[UILabel alloc]init];
          [self.views addSubview:self.namelable];
          
          self.commentlable=[[UILabel alloc]init];
          self.commentlable.numberOfLines=0;
          [self.views addSubview:self.commentlable];
          
          self.timelable=[[UILabel alloc]init];
         self.timelable.font = FONT(10);
          [self.views addSubview:self.timelable];
          
          self.buttons=[[UIButton alloc]init];
          [self.buttons setTitle:@"回复" forState:UIControlStateNormal];
          [self.buttons setTitleColor:COLOR(100, 100, 100, 1) forState:UIControlStateNormal];
          self.buttons.titleLabel.font=FONT(12);
          [self.buttons  setTintColor:[UIColor blueColor]];
          [self.views addSubview:self.buttons];
          
          self.reCommentNumber = [[UILabel alloc]init];
          self.reCommentNumber.textColor = COLOR(100, 100, 100, 1);
          self.reCommentNumber.textAlignment = 2;
          self.reCommentNumber.font = FONT(12);
          [self.views addSubview:self.reCommentNumber];
          
          
          
     }
     return self;
}
-(void)layoutSubviews{
     [super layoutSubviews];
     self.views.frame=CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT5S(50)+_d);
     
     self.namelable.frame=CGRectMake(WIDTH5S(40), 10, WIDTH5S(150), HEIGHT5S(15));
     self.timelable.frame=CGRectMake(WIDTH5S(40), 25, WIDTH5S(100), HEIGHT5S(13));
     self.images.frame=CGRectMake(10, 10, WIDTH5S(30), HEIGHT5S(30));
     self.commentlable.frame=CGRectMake(20, 40, WIDTH5S(300), HEIGHT5S(_d));
     self.buttons.frame=CGRectMake(WIDTH5S(280), 10, WIDTH5S(30), HEIGHT5S(30));
     self.reCommentNumber.frame = CGRectMake(WIDTH5S(240), 10, WIDTH5S(35), HEIGHT5S(30));
}

-(void)setIntroductionText:(NSString *)text{
     CGRect frame=[self frame];
     
     self.commentlable.text=text;
     self.commentlable.font=[UIFont systemFontOfSize:15];
     
     CGRect textSize = [text boundingRectWithSize:CGSizeMake(300, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
     
     _d=textSize.size.height;
     
     frame.size.height=textSize.size.height+HEIGHT5S(50);
     
     self.frame=frame;
}


@end
