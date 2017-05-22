//
//  CXCycleView.m
//  TestCSV
//
//  Created by ChengxuZheng on 15/10/19.
//  Copyright © 2015年 ChengxuZheng. All rights reserved.
//

#import "CXCycleView.h"
#import "TopCycleModel.h"

//#import "FocusViewController.h"

#define kASVS_Width _adScrollView.bounds.size.width
#define kASVS_Height _adScrollView.bounds.size.height

@implementation CXCycleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}


- (void)createAdScrollView {
    _adScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSVS_Width, kSVS_Height)];
    _adScrollView.pagingEnabled = YES;
    _adScrollView.showsHorizontalScrollIndicator = NO;
    _adScrollView.delegate = self;
    [self addSubview:_adScrollView];
}

- (void)createPageControl {
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kSVS_Height-30, kSVS_Width, 30)];
    _pageControl.numberOfPages = _adDataArray.count;
    _pageControl.currentPage = 0;
    _pageControl.enabled = NO;
    [self addSubview:_pageControl];
}

- (void)setAdDataArray:(NSMutableArray *)adDataArray {
    _adIterval = 2.f;
    _adDataArray = [NSMutableArray array];
    _adDataArray = adDataArray;
    
    [self createAdScrollView];
    [self createPageControl];
    if (_adDataArray.count!=0) {
        [self loadDataThenShowAdvert];
    }
    
//    NSLog(@"%@",NSHomeDirectory());
}

- (void)loadDataThenShowAdvert {
    NSInteger imageCount = _adDataArray.count;
    [_adScrollView setContentSize:CGSizeMake(kASVS_Width*(imageCount+2), kASVS_Height)];
    _pageControl.numberOfPages = imageCount;
    for (int i = 0; i < imageCount; i++) {
        UIImageView *adImageView = [[UIImageView alloc] initWithFrame:CGRectMake((i+1)*kASVS_Width, 0, kASVS_Width, kASVS_Height)];
        adImageView.userInteractionEnabled = YES;
        TopCycleModel *model = _adDataArray[i];
        [adImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.thumb]]];
        [adImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:nil]];
        [_adScrollView addSubview:adImageView];
    }
    
    TopCycleModel *lastModel = _adDataArray[imageCount-1];
    UIImageView *lastAdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kASVS_Width, kASVS_Height)];
    [lastAdImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@",lastModel.thumb]]];
    [_adScrollView addSubview:lastAdImageView];
    
    TopCycleModel *firstModel = _adDataArray[0];
    UIImageView *firstAdImageView = [[UIImageView alloc] initWithFrame:CGRectMake((imageCount+1)*kASVS_Width, 0, kASVS_Width, kASVS_Height)];
    [firstAdImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@",firstModel.thumb]]];
    [_adScrollView addSubview:firstAdImageView];
    [_adScrollView setContentOffset:CGPointMake(_adScrollView.bounds.size.width, 0)];
    

    if (!_adTimer) {
        _adTimer = [NSTimer scheduledTimerWithTimeInterval:_adIterval
                                                    target:self
                                                  selector:@selector(startShowCycleAdvert)
                                                  userInfo:nil
                                                   repeats:YES];
    }
}

- (void)startShowCycleAdvert {
    
    CGFloat pageWidth = _adScrollView.frame.size.width;
    NSInteger currentPage = _adScrollView.contentOffset.x/pageWidth;
    if (currentPage == 0) {
        self.pageControl.currentPage = _pageControl.numberOfPages-1;
    }
    else if (currentPage == _pageControl.numberOfPages+1) {
        _pageControl.currentPage = 0;
    }
    else {
        _pageControl.currentPage = currentPage-1;
    }
    
    __block NSInteger currPageNumber = _pageControl.currentPage;
    CGRect rect = CGRectMake((currPageNumber+2)*pageWidth, 0, kASVS_Width, kASVS_Height);
    
    [UIView animateWithDuration:0.5 animations:^{
        [_adScrollView scrollRectToVisible:rect animated:NO];
    } completion:^(BOOL finished) {
        currPageNumber++;
        if (currPageNumber == _pageControl.numberOfPages) {
            [_adScrollView setContentOffset:CGPointMake(_adScrollView.bounds.size.width, 0)];
            currPageNumber = 0;
        }
    }];
    
    currentPage = _adScrollView.contentOffset.x/pageWidth;
    if (currentPage == 0) {
        _pageControl.currentPage = _pageControl.numberOfPages-1;
    }
    else if (currentPage == _pageControl.numberOfPages+1) {
        _pageControl.currentPage = 0;
    }
    else {
        _pageControl.currentPage = currentPage-1;
    }
   
}

#pragma mark - ScrollView delegate methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_adTimer) {
        [_adTimer invalidate];
        _adTimer = nil;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentAdPage;
    currentAdPage = _adScrollView.contentOffset.x/kASVS_Width;
    if (currentAdPage == 0) {
        [scrollView scrollRectToVisible:CGRectMake(kASVS_Width*_pageControl.numberOfPages, 0, kASVS_Width, kASVS_Height) animated:NO];
        currentAdPage = _pageControl.numberOfPages-1;
    }
    else if (currentAdPage == (_pageControl.numberOfPages+1)) {
        [scrollView scrollRectToVisible:CGRectMake(kASVS_Width, 0, kASVS_Width, kASVS_Height) animated:NO];
        currentAdPage = 0;
    }
    else{
        currentAdPage = currentAdPage-1;
    }
    self.pageControl.currentPage = currentAdPage;
    
    if (!_adTimer) {
        _adTimer = [NSTimer scheduledTimerWithTimeInterval:_adIterval
                                                    target:self
                                                  selector:@selector(startShowCycleAdvert)
                                                  userInfo:nil
                                                   repeats:YES];
    }
}

//#pragma mark - 用户事件
//- (void)adImageViewAction {
//    
//    NSLog(@"%ld", _pageControl.currentPage);
//    
//    TopCycleModel *model = _adDataArray[_pageControl.currentPage];
//    
//    //跳转H5链接地址
//    NSString *urlStr = model.key;
//    
//    if (urlStr) {
//        FocusViewController *focusVC = [[FocusViewController alloc] init];
//        focusVC.hidesBottomBarWhenPushed = YES;
//        focusVC.urlStr = urlStr;
//        focusVC.navigationItem.title = model.title;
//        [self.viewController.navigationController pushViewController:focusVC animated:YES];
//    }
//}

@end
