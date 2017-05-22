//
//  QYHomePicHeaderCollectionReusableView.h
//  QingYue
//
//  Created by 崔明燃 on 2017/3/28.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CXCycleView.h"

@interface QYHomePicHeaderCollectionReusableView : UICollectionReusableView

@property (strong, nonatomic) CXCycleView *picCxCycView;
@property (nonatomic, strong) UILabel *titleLbl;
@property (strong, nonatomic) UIButton *moreButton;

@end
