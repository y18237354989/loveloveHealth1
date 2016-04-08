//
//  nearlistViewController.m
//  ailiao
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "nearlistViewController.h"

@interface nearlistViewController ()

@end

@implementation nearlistViewController

- (void)viewWillAppear:(BOOL)animated{
     self.navigationController.navigationBar.hidden = NO;
}

-(id)init{
    
    self=[super init];
    if (self) {
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_GROUP),@(ConversationType_DISCUSSION)]];
    }
    
    return self;
}

-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath{
    RCConversationViewController *vc=[[RCConversationViewController alloc]init];
    vc.targetId=model.targetId;
    vc.title=@"会话";
    [self.navigationController pushViewController:vc animated:YES]; 
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
