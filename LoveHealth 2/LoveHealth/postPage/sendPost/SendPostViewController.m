//
//  SendPostViewController.m
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "SendPostViewController.h"
#import "Header.h"
#import "YCXMenu.h"

@interface SendPostViewController ()<UITextViewDelegate>

@property (strong,nonatomic)UILabel *titleLabel;

@property (strong,nonatomic)UITextField *titleText;

@property (strong,nonatomic)UILabel *contentLabel;

@property (strong,nonatomic)UITextView *contentView;

@property (strong,nonatomic)UIButton *markBtn;

@property (strong,nonatomic)UIButton *sendBtn;

@property (strong,nonatomic)UILabel *addpicLabel;

@property (strong,nonatomic)UIButton *addpicBtn;

@property (strong, nonatomic)NSMutableArray *items;

@property (strong,nonatomic)UIView *view1;

@end

@implementation SendPostViewController
@synthesize items = _items;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"发贴子";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createPart];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createPart{
    
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(15, 185, 290, 305)];
    self.view1.backgroundColor = [UIColor whiteColor];
    self.view1.layer.borderWidth = 1.0;
    self.view1.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.view1.layer.cornerRadius = 6;
    [self.view addSubview:self.view1];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 80, 35, 20)];
    self.titleLabel.font = FONT(15);
    self.titleLabel.text = @"标题:";
    [self.view addSubview:self.titleLabel];
    
    self.titleText = [[UITextField alloc]initWithFrame:CGRectMake(15, 115, 290, 30)];
    self.titleText.layer.cornerRadius = 6;
    self.titleText.layer.borderWidth = 1.0;
    self.titleText.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self.view addSubview:self.titleText];
    
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 155, 35, 20)];
    self.contentLabel.font = FONT(15);
    self.contentLabel.text = @"内容:";
    [self.view addSubview:self.contentLabel];
    
    self.contentView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 290, 230)];
    self.contentView.delegate = self;
    [self.view1 addSubview:self.contentView];
    
    self.markBtn = [[UIButton alloc]initWithFrame:CGRectMake(220, 80, 84, 20)];
    [self.markBtn setBackgroundColor:COLOR(204, 255, 255, 1)];
    [self.markBtn setTitle:@"点击选择标签" forState:UIControlStateNormal];
    self.markBtn.titleLabel.font = FONT(12);
    [self.markBtn setTitleColor:COLOR(0, 204, 204, 1) forState:UIControlStateNormal];
    [self.markBtn addTarget:self action:@selector(ChooseMark:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.markBtn];
    
    self.sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 510, 290, 40)];
    [self.sendBtn setBackgroundColor:COLOR(0, 204, 204, 1)];
    [self.sendBtn setTitle:@"确认发布" forState:UIControlStateNormal];
    [self.sendBtn setTitleColor:COLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    self.sendBtn.layer.cornerRadius = 6;
    [self.view addSubview:self.sendBtn];
    
    self.addpicLabel = [[UILabel alloc]initWithFrame:CGRectMake(235, 230, 55, 18)];
    self.addpicLabel.font = FONT(13);
    self.addpicLabel.textColor = COLOR(215, 219, 226, 1);
    self.addpicLabel.text = @"添加图片";
    [self.view1 addSubview:self.addpicLabel];
    
    self.addpicBtn = [[UIButton alloc]initWithFrame:CGRectMake(235, 250, 50, 50)];
    [self.addpicBtn setImage:[UIImage imageNamed:@"AddPic"] forState:UIControlStateNormal];
    [self.view1 addSubview:self.addpicBtn];
    
}

- (void)ChooseMark:(UIButton *)sender{
    
//    ChooseMarkViewController *cvc = [[ChooseMarkViewController alloc]init];
//    [self.navigationController pushViewController:cvc animated:YES];
    // 显示默认样式的Menu
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *btn = sender;
        [YCXMenu setHasShadow:YES];
        [YCXMenu setBackgrounColorEffect:YCXMenuBackgrounColorEffectGradient];
        [YCXMenu setTintColor:COLOR(0, 204, 204, 1)];
        [YCXMenu setTitleFont:[UIFont systemFontOfSize:15.0]];
        [YCXMenu showMenuInView:self.view fromRect:btn.frame menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item) {
            NSLog(@"%@",item);
        }];
    }
}

#pragma mark - setter/getter
- (NSMutableArray *)items {
    if (!_items) {
        
        // set title
        YCXMenuItem *menuTitle = [YCXMenuItem menuTitle:@"Menu" WithIcon:nil];
        menuTitle.foreColor = [UIColor whiteColor];
        menuTitle.titleFont = [UIFont boldSystemFontOfSize:15.0f];
        
        //          //set logout button
        //          YCXMenuItem *logoutItem = [YCXMenuItem menuItem:@"Logout" image:nil target:self action:@selector(logout:)];
        //          logoutItem.foreColor = [UIColor redColor];
        //          logoutItem.alignment = NSTextAlignmentCenter;
        
        
        //set item
        _items = [@[
                    //                      menuTitle,
                    [YCXMenuItem menuItem:@"养生"
                                    image:nil
                                      tag:100
                                 userInfo:@{@"title":@"Menu"}],
                    [YCXMenuItem menuItem:@"健康"
                                    image:nil
                                      tag:101
                                 userInfo:@{@"title":@"Menu"}],
                    [YCXMenuItem menuItem:@"中医"
                                    image:nil
                                      tag:102
                                 userInfo:@{@"title":@"Menu"}],
                    [YCXMenuItem menuItem:@"西医"
                                    image:nil
                                      tag:103
                                 userInfo:@{@"title":@"Menu"}],
                    [YCXMenuItem menuItem:@"饮食"
                                    image:nil
                                      tag:104
                                 userInfo:@{@"title":@"Menu"}]
                    //  logoutItem
                    ] mutableCopy];
    }
    return _items;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
   self.contentView.frame = CGRectMake(0, 0, 290, 120);

}
-(void)textViewDidEndEditing:(UITextView *)textView{
    self.contentView.frame = CGRectMake(0, 0, 290, 230);
}

@end
