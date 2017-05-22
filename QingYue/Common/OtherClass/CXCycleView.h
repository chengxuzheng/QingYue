//
//  CXCycleView.h
//  TestCSV
//
//  Created by ChengxuZheng on 15/10/19.
//  Copyright © 2015年 ChengxuZheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXCycleView : UIView <UIScrollViewDelegate>


@property (nonatomic, strong) NSMutableArray *adDataArray;
@property (nonatomic, strong) UIScrollView *adScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *adTimer;


@property (nonatomic, assign) CGFloat adIterval;




@end
