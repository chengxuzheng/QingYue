//
//  QYHomeViewController.m
//  QingYue
//
//  Created by 崔明燃 on 2017/3/24.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYHomeViewController.h"
#import "QYHotBookListViewController.h"

#import "QYHomePicHeaderCollectionReusableView.h"
#import "QYHomeCollectionReusableView.h"
#import "QYHomeCollectionViewCell.h"
#import "QYBookDetailViewController.h"


//static CGFloat headerViewHeight = 0;
static NSString *firstHeaderViewIdentifier = @"kFirstRecipeCollectionHeaderViewID";
static NSString *headerViewIdentifier = @"kRecipeCollectionHeaderViewID";

@interface QYHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *listCollectionView;
@property (strong, nonatomic)  QYHomePicHeaderCollectionReusableView *listFirstHeaderView;
@property (strong, nonatomic)  QYHomeCollectionReusableView *listHeaderView;
@property (nonatomic, strong) UIImageView *tztImageView;


@end

@implementation QYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"北京大学图书馆";
    self.view.backgroundColor = [UIColor blueColor];
//        self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.listCollectionView];
    [[UIApplication sharedApplication].delegate.window addSubview:self.tztImageView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSData *data = [kUserDefaults objectForKey:@"tztImage"];
    UIImage *image = [[UIImage alloc] initWithData:data];
    
    _tztImageView.image = image;
    
    [UIView animateWithDuration:.35 animations:^{
        _tztImageView.alpha = 0;
    } completion:^(BOOL finished) {
        _tztImageView.hidden = YES;
    }];
    
}

#pragma mark - button clicked
- (void)moreButtonClicked:(UIButton *)button {
    
//    [self.listCollectionView reloadData];
    
    QYHotBookListViewController *bookListVC = [[QYHotBookListViewController alloc] init];
    bookListVC.hidesBottomBarWhenPushed = YES;
    
    switch (button.tag) {
        case 0:
        {
            bookListVC.navigationItem.title = @"热门图书";
        }
            break;
        case 1:
        {
            bookListVC.navigationItem.title = @"新书推荐";
        }
            break;
        case 2:
        {
            bookListVC.navigationItem.title = @"猜你喜欢";
        }
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:bookListVC animated:YES];
}

#pragma mark - collection delegate and dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView == _listCollectionView) {
        return 3;
    }
    
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == _listCollectionView) {
        return 4;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    QYHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"kMyCollectionViewCell_ID" forIndexPath:indexPath];
    
    cell.layer.borderWidth = .5;
    cell.layer.borderColor = [[UIColor lightGrayColor] CGColor];

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == _listCollectionView) {
        if (indexPath.section == 0) {
            _listFirstHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:firstHeaderViewIdentifier forIndexPath:indexPath];
            _listFirstHeaderView.titleLbl.text = @"热门图书";
            
            _listFirstHeaderView.moreButton.tag = indexPath.section;
            
            [_listFirstHeaderView.moreButton addTarget:self action:@selector(moreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            return _listFirstHeaderView;
            
        }
        _listHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIdentifier forIndexPath:indexPath];
        _listHeaderView.backgroundColor = [UIColor whiteColor];
        
        _listHeaderView.moreButton.tag = indexPath.section;
        [_listHeaderView.moreButton addTarget:self action:@selector(moreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (indexPath.section == 1) {
            _listHeaderView.titleLbl.text = @"新书推荐";
        } else if (indexPath.section == 2) {
            _listHeaderView.titleLbl.text = @"猜你喜欢";
        }
        
        return _listHeaderView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    QYBookDetailViewController *bookDetailVC = [[QYBookDetailViewController alloc] init];
    [self.navigationController pushViewController:bookDetailVC animated:YES];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (collectionView == _listCollectionView) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

/**
 * 定义头视图的尺寸
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (collectionView == _listCollectionView) {
        if (section == 0) {
            return CGSizeMake(self.view.bounds.size.width, 200);
        }
        return CGSizeMake(self.view.bounds.size.width, 30);
    }
    return CGSizeMake(self.view.bounds.size.width, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 10);
}


#pragma mark - layout subviews
- (void)viewWillLayoutSubviews
{
    [_listCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    [_tztImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo([UIApplication sharedApplication].delegate.window);
    }];
}

#pragma mark - lazy load
- (UIImageView *)tztImageView {
    if (!_tztImageView) {
        _tztImageView = [[UIImageView alloc] init];
    }
    return _tztImageView;
}

- (UICollectionView *)listCollectionView {
    if (!_listCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((self.view.bounds.size.width - 7.5) / 4, 100);
        flowLayout.minimumInteritemSpacing = .6;
        flowLayout.minimumLineSpacing = .6;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 1, 0, 1);
        
        _listCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _listCollectionView.backgroundColor = [UIColor whiteColor];
        
        
        _listCollectionView.dataSource = self;
        _listCollectionView.delegate = self;
        [_listCollectionView registerClass:[QYHomeCollectionViewCell class] forCellWithReuseIdentifier:@"kMyCollectionViewCell_ID"];
        [_listCollectionView registerClass:[QYHomeCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIdentifier];
        [_listCollectionView registerClass:[QYHomePicHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:firstHeaderViewIdentifier];
    }
    
    return _listCollectionView;
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
