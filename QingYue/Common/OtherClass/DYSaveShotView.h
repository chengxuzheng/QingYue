//
//  DYSaveShotView.h
//  DayoSoft_O2O
//
//  Created by Lei_Zhong_Xun on 17/2/28.
//  Copyright © 2017年 Lei_Zhong_Xun. All rights reserved.
//

#import "QYBaseView.h"

@interface DYSaveShotView : QYBaseView

/** 小绿图*/
@property (nonatomic, strong) UIView *greenView;
/** 标题label*/
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)UIButton *sureButton;
@property (nonatomic, strong)UIView *dividerView;

@end
