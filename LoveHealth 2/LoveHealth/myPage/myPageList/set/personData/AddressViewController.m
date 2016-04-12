//
//  AddressViewController.m
//  LoveHealth
//
//  Created by administrator on 16/4/12.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "AddressViewController.h"
#import "Header.h"

@interface AddressViewController ()

@property (strong, nonatomic)UIButton *addBtn;

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
     
     self.addBtn = BUTTON_RECT(WIDTH5S(15), HEIGHT5S(460), WIDTH5S(290), HEIGHT5S(40));
     self.addBtn.titleLabel.font = FONT(15);
     [self.addBtn setTitle:@"添加收货地址" forState:UIControlStateNormal];
     self.addBtn.backgroundColor = COLOR(0, 210, 210, 1);
     [self.view addSubview:self.addBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
