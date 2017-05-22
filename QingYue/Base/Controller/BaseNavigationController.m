//
//  BaseNavigationController.m
//  Yuncang
//
//  Created by ChengxuZheng on 15/11/18.
//  Copyright © 2015年 ChengxuZheng. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.navigationBar.barTintColor = RGB(69, 69, 69, 1);
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.navigationBar.translucent = NO;
//    self.navigationBar.backgroundColor = [UIColor yellowColor];
    //    5.栏颜色  barTintColor
    self.navigationBar.barTintColor = RGB(250, 250, 250, 1.0);
    //    按钮的颜色
    self.navigationBar.tintColor = [UIColor blackColor];
//    self.navigationBar.barStyle = UIBarStyleBlack;

    
//    // 产生按钮图片
//    UIImage *backImg = [[UIImage imageNamed:@"fanhui"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
//    // 用按钮图片替代系统箭头
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backImg forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    // 隐藏导航栏标题
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
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
