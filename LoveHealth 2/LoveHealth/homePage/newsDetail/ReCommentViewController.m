//
//  ReCommentViewController.m
//  LoveHealth
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "ReCommentViewController.h"
#import "Header.h"
#import "ReCommentTableViewCell.h"

@interface ReCommentViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (strong, nonatomic)UIView *navigationView;

@property (strong, nonatomic)UIButton *backButton;

@property (strong, nonatomic)UIButton *okBtn;

@property (strong, nonatomic)UIButton *cancleBtn;

@property (strong, nonatomic)NSMutableArray *wordArr;

@property (copy, nonatomic)NSString *numStr;//回复总条数

@property (strong, nonatomic)UITextView *reCommentTextView;//回复输入区

//自适应label高
@property (assign, nonatomic)double height;

@end

@implementation ReCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     
     self.navigationItem.title = @"评论回复";
     self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
     
     self.wordArr = [NSMutableArray arrayWithCapacity:0];
     
     if ([self.placeLabel isEqualToString:@"1"]) {
          [self.wordArr addObject:@"哈哈1"];
          [self.wordArr addObject:@"呵呵1"];
     }else if ([self.placeLabel isEqualToString:@"2"]){
          [self.wordArr addObject:@"哈哈2"];
          [self.wordArr addObject:@"呵呵2"];
          [self.wordArr addObject:@"嘿嘿2"];
          [self.wordArr addObject:@"啦啦2"];
     }else{
          [self.wordArr addObject:@"哈哈3"];
          [self.wordArr addObject:@"呵呵3"];
          [self.wordArr addObject:@"嘿嘿3"];
     }
     self.numStr = [NSString stringWithFormat:@"%lu",(unsigned long)self.wordArr.count];
     
     //评论回复View
     self.reCommentTable = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(44), WIDTH5S(320), HEIGHT5S(524)) style:UITableViewStyleGrouped];
     self.reCommentTable.backgroundColor = COLOR(242, 242, 242, 1);
     self.reCommentTable.dataSource = self;
     self.reCommentTable.delegate = self;
     [self.view addSubview:self.reCommentTable];
     
     self.reCommentTable.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(320), HEIGHT5S(140))];
     self.reCommentTable.tableHeaderView.backgroundColor = COLOR(242, 242, 242, 1);
     [self.reCommentTable addSubview:self.reCommentTable.tableHeaderView];
     
     self.navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(320), HEIGHT5S(64))];
     self.navigationView.backgroundColor = COLOR(0, 210, 210, 1);
     [self.view addSubview:self.navigationView];
     
     self.backButton = [[UIButton alloc]initWithFrame:CGRectMake(15, HEIGHT5S(32), WIDTH5S(20), HEIGHT5S(20))];
     [self.backButton setBackgroundImage:[UIImage imageNamed:@"back_48px_1125197_easyicon.net"] forState:UIControlStateNormal];
     [self.navigationView addSubview:self.backButton];
     [self.backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
     //textView
     self.reCommentTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, HEIGHT5S(0), WIDTH5S(320), HEIGHT5S(100))];
     self.reCommentTextView.textColor = COLOR(100, 100, 100, 1);
     self.reCommentTextView.font = FONT(15);
     self.reCommentTextView.delegate = self;
     self.reCommentTextView.returnKeyType = UIReturnKeyDefault;
     self.reCommentTextView.scrollEnabled = YES;//可拖动
     self.reCommentTextView.editable = YES;//可编辑
     self.reCommentTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适高
     [self.reCommentTable.tableHeaderView addSubview:self.reCommentTextView];
     
     self.okBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(265), HEIGHT5S(110), WIDTH5S(40), HEIGHT5S(20))];
     [self.okBtn setTitle:@"发送" forState:UIControlStateNormal];
     [self.okBtn setTitleColor:COLOR(100, 100, 100, 1) forState:UIControlStateNormal];
     [self.reCommentTable.tableHeaderView addSubview:self.okBtn];
     [self.okBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
     
     self.cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, HEIGHT5S(110), WIDTH5S(40), HEIGHT5S(20))];
     [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
     [self.cancleBtn setTitleColor:COLOR(100, 100, 100, 1) forState:UIControlStateNormal];
     [self.reCommentTable.tableHeaderView addSubview:self.cancleBtn];
     [self.cancleBtn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
}

- (void)back{
     
     if (_delegate != nil && [_delegate respondsToSelector:@selector(printText:)]) {
          [_delegate printText:self.numStr];
          [self.navigationController popViewControllerAnimated:YES];
     }
}

- (void)send{
     
     [self.wordArr addObject:self.reCommentTextView.text];
     [self.reCommentTable reloadData];
     [self.view endEditing:YES];
     self.numStr = [NSString stringWithFormat:@"%ld",self.wordArr.count];

}

- (void)cancle{
     
     [self.view endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     
     return self.wordArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     return self.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     static NSString *Identifier = @"reComment";
     
     ReCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
     
     if (cell == nil) {
          cell = [[ReCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
     }
    
     [cell setIntroductionText:self.wordArr[indexPath.row]];
     
     cell.namelable.text = @"222";
     cell.timelable.text = @"222";
     self.height=cell.frame.size.height;
     
     self.reCommentTextView.text = nil;
     return cell;
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
