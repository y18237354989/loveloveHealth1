//
//  GoodsTypeListViewController.m
//  逛一逛Tableview
//
//  Created by Administrator on 16/3/31.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "GoodsTypeListViewController.h"
#import "GuessLikeCollectionViewCell.h"
#import "GoodsTypeDetailCollectionViewCell.h"
#import "GoodsDetailViewController.h"
#import "Header.h"

@interface GoodsTypeListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate>


@property (strong,nonatomic) UICollectionView *collectView;
@property(strong,nonatomic)UISearchController *searchController;

@property(strong,nonatomic)NSMutableArray *searchList;
@property (strong,nonatomic)NSMutableArray *goodsNameArr;

@end

@implementation GoodsTypeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    [self createCollectView];
    [self createSearchController];
    [self createNsmutableArray];
    [self changeSearchBar];
    
}
-(void)createNsmutableArray{
    
    self.goodsNameArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<20; i++) {
        [self.goodsNameArr addObject:[NSString stringWithFormat:@"%d-哑铃凳等多功能卧推椅板家用仰卧起坐健身器材",i]];
    }
    self.searchList = [NSMutableArray arrayWithCapacity:0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createCollectView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    flowLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 44);
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64+44, 320, 568-64-44) collectionViewLayout:flowLayout];
    
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    [self.view addSubview:self.collectView];
    self.collectView.backgroundColor = [UIColor whiteColor];
    
    //注册cell
    [self.collectView registerClass:[GoodsTypeDetailCollectionViewCell class] forCellWithReuseIdentifier:@"list"];
    // 注册ReusableView，设置组名
    [self.collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"0001"];
}

-(void)createSearchController{
    
    UIView *views = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 320, 44)];
    views.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:views];
    
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchResultsUpdater = self;
    self.searchController.delegate = self;
//    self.searchController.searchBar.backgroundColor = [UIColor clearColor];
//    [self.searchController.searchBar setBackgroundColor:COLOR(0, 210, 210, 1)];
    [views addSubview:self.searchController.searchBar];
    
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44);
    self.searchController.searchBar.placeholder = @"请输入商品名";
    self.searchController.searchBar.delegate = self;
}
-(void)changeSearchBar{
//    [[self.searchController.searchBar.subviews objectAtIndex:0]removeFromSuperview];
    for (UIView *subview in self.searchController.searchBar.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
            break;
        }
    }
//    [self.searchController.searchBar setShowsCancelButton:YES animated:YES];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.searchController.active) {
        return self.searchList.count;
    }else{
        return self.goodsNameArr.count;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//定义每个UICollectionView 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(320, 100);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//定义每个UICollectionView 横向的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
//定义每个UICollectionView 纵向的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"list";
    GoodsTypeDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    cell.goodsImage.image = [UIImage imageNamed:@"1.jpg"];
//    cell.goodsName.text = self.goodsNameArr[indexPath.row];
    if (self.searchController.active) {
        cell.goodsName.text = self.searchList[indexPath.row];
    }else{
        cell.goodsName.text = self.goodsNameArr[indexPath.row];
    }
    return cell;
}

//搜索结果更新
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSString *str1 = self.searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",str1];
    if (self.searchList!=nil) {
        [self.searchList removeAllObjects];
    }
    self.searchList = [NSMutableArray arrayWithArray:[self.goodsNameArr filteredArrayUsingPredicate:predicate]];
    [self.collectView reloadData];
}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
        self.searchController.searchBar.showsCancelButton = YES;

}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"选择第%ld组第%ld",indexPath.section,indexPath.row);
        GoodsDetailViewController *gdvc2 = [[GoodsDetailViewController alloc]init];
        //         gdvc2.goodsDic = [NSMutableDictionary dictionaryWithObject:self.nameStr forKey:@"name"];
        gdvc2.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:gdvc2 animated:YES];
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//按顶部导航按钮返回时
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.searchController.active) {
        self.searchController.active = NO;
       [self.searchController.searchBar removeFromSuperview];
    }
}



@end
