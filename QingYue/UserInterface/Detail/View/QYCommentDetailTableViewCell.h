//
//  QYCommentDetailTableViewCell.h
//  QingYue
//
//  Created by 崔明燃 on 2017/4/8.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYCommentDetailTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *headerView;  // 头像
@property (strong, nonatomic) UILabel *nameLabel;   // 昵称
@property (strong, nonatomic) UILabel *timeLabel;   // 时间
@property (strong, nonatomic) UILabel *infoLabel;   // 评论信息
@property (strong, nonatomic) UIButton *allButton;  // 点击显示全部内容 按钮

@property (strong, nonatomic) UIButton *praiseButton;  //赞
@property (strong, nonatomic) UIImageView *bookImg;    // 小书图标
@property (strong, nonatomic) UILabel *bookNameLabel;  // 书名
@property (strong, nonatomic) UIButton *deleteButton;  // 删除按钮

@end
