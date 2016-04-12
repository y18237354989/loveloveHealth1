//
//  FeedBackViewController.m
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "FeedBackViewController.h"
#import "Header.h"
@interface FeedBackViewController ()<UITextViewDelegate>

@property (strong,nonatomic) UITextView *textView;

@property (strong,nonatomic) UIButton *submitBtn;

@end

@implementation FeedBackViewController

- (void)viewWillAppear:(BOOL)animated{
     
     self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"意见反馈";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(15, 92, 290, 400) ];
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.textAlignment = NSTextAlignmentLeft;
    self.textView.layer.borderWidth = 1.0f;
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.layer.cornerRadius = 5;
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    
    self.submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 530, 290, 28)];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.submitBtn setBackgroundColor:COLOR(0, 210, 210, 1)];
    [self.submitBtn setTitleColor:COLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    [self.view addSubview:self.submitBtn];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    self.textView.frame = CGRectMake(15, 92, 290, 220);
    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    self.textView.frame = CGRectMake(15, 92, 290, 400);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
