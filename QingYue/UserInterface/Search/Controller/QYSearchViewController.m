//
//  QYSearchViewController.m
//  QingYue
//
//  Created by Zheng on 2017/4/11.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYSearchViewController.h"
#import "QYSearchView.h"

#define kRightItemColor RGB(47, 202, 103, 1)
static NSString *const kHotTitle = @"热门搜索";
static NSString *const kRightItemTitle = @"搜索";
static const CGFloat kVerticalSpacing = 22.5f;
static const CGFloat kHorizontalSpacing = 20.f;
static const CGFloat kBtnHeight = 30.f;

@interface QYSearchViewController ()
@property (nonatomic, strong) UILabel *hotTitleLbl;
@property (nonatomic, strong) UIView *hotBgView;
@property (nonatomic, strong) QYSearchView *searchView;

@property (nonatomic, strong) NSMutableArray *hotArr;
@end

@implementation QYSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _hotArr = [@[@"三生三世十里桃花",
                 @"我就是要飞翔你怕不怕",
                 @"挺生卡卡卡",
                 @"啦啦啦德玛西亚",
                 @"你",
                 @"明月",
                 @"哈哈哈",
                 @"你怕不怕"] mutableCopy];
    
    [self subviewsInView];
    
    [self loadHotData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar addSubview:self.searchView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_searchView removeFromSuperview];
    _searchView = nil;
}

#pragma mark -通过数据创建热门标题
- (void)loadHotData {
    
    [self.view addSubview:self.hotBgView];
    [_hotBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hotTitleLbl.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - 用户点击事件
#pragma mark 导航栏搜索
- (void)rightBarButtonPressed:(id)sender {
    NSLog(@"点击搜索带你飞翔");
}

#pragma mark 热门搜索
- (void)searchHotBtnAction:(UIButton *)sender {
    NSLog(@"点击了 %@",sender.titleLabel.text);
}

#pragma mark - subviews
- (void)subviewsInView {
    [self showRightButtonWithTitle:kRightItemTitle titleColor:kRightItemColor];

    [self.view addSubview:self.hotTitleLbl];
    [_hotTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kVerticalSpacing);
        make.left.mas_equalTo(kHorizontalSpacing);
    }];
    
}

- (QYSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[QYSearchView alloc] initWithFrame:CGRectMake(0, 0, 0.68*MSSize_Width, kBtnHeight)];
        _searchView.center = CGPointMake(self.view.center.x, 22);
        _searchView.backgroundColor = RGB(237, 238, 239, 1);
        _searchView.layer.cornerRadius = 5;
        _searchView.layer.masksToBounds = YES;
    }
    return _searchView;
}

- (UILabel *)hotTitleLbl {
    if (!_hotTitleLbl) {
        _hotTitleLbl = [UILabel new];
        _hotTitleLbl.text = kHotTitle;
        _hotTitleLbl.font = Font(15);
    }
    return _hotTitleLbl;
}

- (UIView *)hotBgView {
    if (!_hotBgView) {
        _hotBgView = [UIView new];
        
        CGFloat kMaxWidth = [UIScreen mainScreen].bounds.size.width-20.f;
        CGFloat kTempWidth = 0;
        NSUInteger kRowNumber = 0;
        CGFloat offSetLeft = 0;
        
        for (int i = 0; i < _hotArr.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:_hotArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = Font(12);
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [btn addTarget:self action:@selector(searchHotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            NSString *titleStr = btn.titleLabel.text;
            NSDictionary *attributeDic = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
            CGFloat btnWidth = [titleStr boundingRectWithSize:CGSizeMake(MAXFLOAT, kBtnHeight) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:attributeDic context:nil].size.width+20;
            
            offSetLeft = kTempWidth;
            kTempWidth += btnWidth;
            
            if (kTempWidth > kMaxWidth) {
                kRowNumber++;
                offSetLeft = 0;
                kTempWidth = btnWidth;
            }
            
            btn.frame = CGRectMake(kHorizontalSpacing+offSetLeft, (kRowNumber+0.5)*kBtnHeight, btnWidth, kBtnHeight);
            
            [_hotBgView addSubview:btn];
        }
        
    }
    return _hotBgView;
}

#pragma mark - 内存警告
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
