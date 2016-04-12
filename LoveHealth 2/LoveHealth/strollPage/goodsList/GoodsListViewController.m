//
//  GoodsListViewController.m
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "GoodsListViewController.h"
#import "Header.h"
#import "myNavigation.h"
#import "AdvertisingColum.h"
#import "GoodsTypeCollectionViewCell.h"
#import "GuessLikeCollectionViewCell.h"
#import "GoodsDetailViewController.h"
#import "GoodsTypeListViewController.h"


@interface GoodsListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong,nonatomic)UICollectionView *collectView;
@property (strong,nonatomic)AdvertisingColum *headerView;

@property (strong,nonatomic)NSArray *cell1arr1;
@property (strong,nonatomic)NSArray *cell1arr2;
@property (strong,nonatomic)NSArray *cell2arr1;
@property (strong,nonatomic)NSArray *cell2arr2;

@property (strong, nonatomic)myNavigation *navigation;

@property (copy, nonatomic)NSString *nameStr;  //临时存放商品名



@end

@implementation GoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"逛一逛";
    
    
    [self createCollectView];
    
    self.cell1arr1 = @[@"drugs",@"cooking",@"weights"];
    self.cell1arr2 = @[@"常用西药",@"养生中药",@"健身器材"];
    self.cell2arr1 = @[@"1.jpg",@"1.4.jpg",@"1.5.jpg",@"1.jpg",@"1.4.jpg",@"1.5.jpg",@"1.jpg",@"1.4.jpg",@"1.5.jpg",@"1.5.jpg"];
//    self.cell2arr2 = @[@"瘦身机",@"健身车",@"中药祛痘",@"瘦身机",@"健身车",@"中药祛痘",@"瘦身机",@"健身车",@"中药祛痘",@"瘦身机"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createCollectView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 150);
    
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    self.collectView.backgroundColor = COLOR(228, 228, 228, 1);
//    设置代理
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    [self.view addSubview:self.collectView];
    
    //注册cell
    [self.collectView registerClass:[GoodsTypeCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectView registerClass:[GuessLikeCollectionViewCell class] forCellWithReuseIdentifier:@"cell4"];
    
    // 注册ReusableView，设置组名
    [self.collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"001"];
    
    /*
     ***广告栏
     */
    self.headerView = [[AdvertisingColum alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    
}
#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 3;
    if (section == 1) {
        return 10;
    }else{
        return 3;
    }
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
//定义section的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(320, 150);
    }else{
        return CGSizeMake(320, 36);
    }
    
}

//定义组名
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"001" forIndexPath:indexPath];
    if (indexPath.section ==0) {
        
        [headView addSubview:self.headerView];
    }else{
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 2, 320, 34)];
        backView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:backView];
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 34)];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = [UIFont systemFontOfSize:15];
        [backView addSubview:titleLab];
        
        if (indexPath.section == 1){
            titleLab.text = @"精品推荐";
//        }else if (indexPath.section == 2){
//            titleLab.text = @"好店推荐";
//        }else{
//            titleLab.text = @"猜你喜欢";
        }
    }
    return headView;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        static NSString *identify = @"cell";
        GoodsTypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        [cell sizeToFit];
        cell.backgroundColor = COLOR(255, 255, 255, 1);
        cell.goodsImage.image = [UIImage imageNamed:self.cell1arr1[indexPath.row]];
        cell.goodsType.text = self.cell1arr2[indexPath.row];
        
        return cell;
//    }else if (indexPath.section == 1){
//        static NSString *identify = @"cell2";
//        QualityGoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
//        [cell sizeToFit];
//
//        cell.backgroundColor = COLOR(228, 228, 228, 1);
//        cell.goodsImage.image = [UIImage imageNamed:self.cell2arr1[indexPath.row]];
//        cell.goodsName.text = @"瘦身机";
//        self.nameStr = cell.goodsName.text;
//        cell.goodsPriceLabel.text = [NSString stringWithFormat:@"￥:998"];
//        return cell;
//    }else if (indexPath.section == 2){
//        static NSString *identify = @"cell3";
//        GoodShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
//        [cell sizeToFit];
//        cell.backgroundColor = COLOR(228, 228, 228, 1);
//        cell.goodsImage.image = [UIImage imageNamed:self.cell2arr1[indexPath.row]];
//        cell.goodsName.text = self.cell2arr2[indexPath.row];
//        return cell;
//    }else{
//        static NSString *identify = @"cell4";
//        GuessLikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
//        [cell sizeToFit];
//
//        cell.backgroundColor = COLOR(228, 228, 228, 1);
//        cell.goodsImage.image = [UIImage imageNamed:self.cell2arr1[indexPath.row]];
//        cell.goodsName.text = @"瘦身机瘦身机瘦身机瘦身机瘦身机";
//        return cell;
    }else{
        static NSString *identify = @"cell4";
                GuessLikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
                [cell sizeToFit];
        
                cell.backgroundColor = COLOR(255, 255, 255, 1);
                cell.goodsImage.image = [UIImage imageNamed:self.cell2arr1[indexPath.row]];
                cell.goodsName.text = @"瘦身机瘦身机瘦身机瘦身机瘦身机";
                return cell;
    }
    
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size ;
    if (indexPath.section==0) {
        size = CGSizeMake(104, 104);
//    }else if (indexPath.section==1){
//        size = CGSizeMake(100, 160);
//    }else if (indexPath.section == 2){
//        size = CGSizeMake(100, 110);
    }else{
        size = CGSizeMake(157, 215);
    }
    
    return size;
}

//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    if (section == 1) {
//        return UIEdgeInsetsMake(2, 2, 2, 2);
//    }else{
//        return UIEdgeInsetsMake(5, 5, 5, 5);
//    }
    return UIEdgeInsetsMake(2, 2, 0, 2);
    
//    if (section == 0) {
//        return UIEdgeInsetsMake(2, 2, 0, 2);
//    }else{
//        return UIEdgeInsetsMake(0, 0, 0, 0);
//    }
}

//定义每个UICollectionView 横向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}
//定义每个UICollectionView 纵向的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2.0f;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"选择第%ld组第%ld",indexPath.section,indexPath.row);
     
     if (indexPath.section == 0) {
          GoodsTypeListViewController *gdvc1 = [[GoodsTypeListViewController alloc]init];
          gdvc1.hidesBottomBarWhenPushed = YES;
          [self.navigationController pushViewController:gdvc1 animated:YES];
     }
     
    if (indexPath.section == 1) {
        GoodsDetailViewController *gdvc2 = [[GoodsDetailViewController alloc]init];
//         gdvc2.goodsDic = [NSMutableDictionary dictionaryWithObject:self.nameStr forKey:@"name"];
         gdvc2.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:gdvc2 animated:YES];
    }
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end