//
//  QYHotBookListViewController.m
//  QingYue
//
//  Created by 崔明燃 on 2017/4/8.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYHotBookListViewController.h"
#import "QYBookShelfCollectionViewCell.h"

#define QYBookShelfCollectionViewCellID @"QYBookShelfCollectionViewCell"
#define QYBookShelfHeaderViewID @"QYBookShelfHeaderView"
static NSString *const MultilevelHeaderCellID = @"DYMultilevelHeaderView";

@interface QYHotBookListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

/** 列表collectionView*/
@property (nonatomic,strong) UICollectionView* listCollectionView;

@end

@implementation QYHotBookListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"猜你喜欢";
    [self.view addSubview:self.listCollectionView];
    
}

#pragma mark - 布局
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [_listCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark - 滑动的时候
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_listCollectionView endEditing:YES];
}


#pragma mark - collectionView delegate and datasource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QYBookShelfCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:QYBookShelfCollectionViewCellID forIndexPath:indexPath];
    
    return cell;
}

// 头视图的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(MSSize_Width, 50);
//}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 14;
}

#pragma mark - lazy load
- (UICollectionView *)listCollectionView
{
    if (!_listCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake((MSSize_Width) / 3, 200);
        _listCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _listCollectionView.backgroundColor = RGB(241, 242, 242, 1.0);
        _listCollectionView.delegate = self;
        _listCollectionView.dataSource = self;
        [_listCollectionView registerClass:[QYBookShelfCollectionViewCell class] forCellWithReuseIdentifier:QYBookShelfCollectionViewCellID];
    }
    return _listCollectionView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
