//
//  GoodsTypeListViewController.m
//  逛一逛Tableview
//
//  Created by Administrator on 16/3/31.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "GoodsTypeListViewController.h"
#import "GuessLikeCollectionViewCell.h"
#import "GoodsSearchViewController.h"
@interface GoodsTypeListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property (strong,nonatomic) UICollectionView *collectView;

@end

@implementation GoodsTypeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
     
     UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
     self.navigationItem.rightBarButtonItem = right;
    
    [self createCollectView];
}


-(void)search{
     GoodsSearchViewController *gvc = [[GoodsSearchViewController alloc]init];
     [self.navigationController pushViewController:gvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createCollectView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) collectionViewLayout:flowLayout];
    
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    [self.view addSubview:self.collectView];
    self.collectView.backgroundColor = [UIColor whiteColor];
    
    //注册cell
    [self.collectView registerClass:[GuessLikeCollectionViewCell class] forCellWithReuseIdentifier:@"list"];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//定义每个UICollectionView 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(150, 200);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
//定义每个UICollectionView 纵向的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"list";
    GuessLikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    cell.goodsImage.image = [UIImage imageNamed:@"1.jpg"];
    cell.goodsName.text = @"哑铃凳等多功能卧推椅板家用仰卧起坐健身器材";
    return cell;
}
@end
