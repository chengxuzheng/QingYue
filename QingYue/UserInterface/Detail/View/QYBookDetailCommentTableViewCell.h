//
//  QYBookDetailCommentTableViewCell.h
//  QingYue
//
//  Created by 崔明燃 on 2017/4/2.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYBookDetailCommentTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *headerView;  // 头像
@property (strong, nonatomic) UILabel *nameLabel;   // 昵称
@property (strong, nonatomic) UILabel *timeLabel;   // 时间
@property (strong, nonatomic) UILabel *infoLabel;   // 评论信息
@property (strong, nonatomic) UIButton *allButton;  // 点击显示全部内容 按钮


@end
