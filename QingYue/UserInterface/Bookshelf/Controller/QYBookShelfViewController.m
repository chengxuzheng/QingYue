//
//  QYBookShelfViewController.m
//  QingYue
//
//  Created by leilei on 2017/3/26.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYBookShelfViewController.h"
#import "QYBookShelfCollecionHeaderReusableView.h"
#import "QYBookShelfCollectionViewCell.h"
#import "QYSearchViewController.h"


#define QYBookShelfCollectionViewCellID @"QYBookShelfCollectionViewCell"
#define QYBookShelfHeaderViewID @"QYBookShelfHeaderView"
static NSString *const MultilevelHeaderCellID = @"DYMultilevelHeaderView";

@interface QYBookShelfViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
/** 列表collectionView*/
@property (nonatomic,strong) UICollectionView* listCollectionView;
/** 头视图带搜索框*/
@property (nonatomic,strong) QYBookShelfCollecionHeaderReusableView* searchHeaderView;
@end

@implementation QYBookShelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"书架";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.listCollectionView];
}
#pragma mark - 按钮点击事件
- (void)headerViewSearchBtnClick
{
    QYSearchViewController *searchVC = [[QYSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    
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

#pragma mark - 触碰其他地方的时候
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_listCollectionView endEditing:YES];
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
// 自定义的头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
   QYBookShelfCollecionHeaderReusableView *bookHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:QYBookShelfHeaderViewID forIndexPath:indexPath];
    [bookHeader.searchButton addTarget:self action:@selector(headerViewSearchBtnClick) forControlEvents:UIControlEventTouchUpInside];

    
    return bookHeader;
}

// 头视图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(MSSize_Width, 50);
}

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
        [_listCollectionView registerClass:[QYBookShelfCollecionHeaderReusableView class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:QYBookShelfHeaderViewID];
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
