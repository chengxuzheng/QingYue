//
//  QYYesOrNoShotView.h
//  QingYue
//
//  Created by leilei on 2017/4/3.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYBaseView.h"

@interface QYYesOrNoShotView : QYBaseView
/** 小绿图*/
@property (nonatomic, strong) UIView *greenView;
/** 标题label*/
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)UIButton *sureButton;
/** 取消按钮*/
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong)UIView *dividerView;
@end
