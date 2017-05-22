//
//  QYBaseRecord.h
//  QingYue
//
//  Created by leilei on 2017/4/9.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYBaseRecordView : UIView
/** 书名*/
@property (nonatomic, strong) UILabel *bookNameLabel;
/** 书状态*/
@property (nonatomic, strong) UILabel *bookStateLabel;
/** 灰线白色背景图*/
@property (nonatomic, strong) UIView *grayBGView;
/** 标题1*/
@property (nonatomic, strong) UILabel *firstTitleLabel;
/** 标题2*/
@property (nonatomic, strong) UILabel *secondTitleLabel;
/** 标题3*/
@property (nonatomic, strong) UILabel *thirdTitleLabel;
/** 内容1*/
@property (nonatomic, strong) UILabel *firstContentLabel;
/** 内容2*/
@property (nonatomic, strong) UILabel *secondContentLabel;
/** 内容3*/
@property (nonatomic, strong) UILabel *thirdContentLabel;
/** 中间灰线*/
@property (nonatomic, strong) UIView *grayView;
@end
