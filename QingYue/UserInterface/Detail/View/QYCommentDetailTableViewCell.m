//
//  QYCommentDetailTableViewCell.m
//  QingYue
//
//  Created by 崔明燃 on 2017/4/8.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYCommentDetailTableViewCell.h"

@implementation QYCommentDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //self.contentView.backgroundColor = [UIColor redColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.headerView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.praiseButton];
        [self.contentView addSubview:self.infoLabel];
        [self.contentView addSubview:self.allButton];
        
        [self.contentView addSubview:self.bookImg];
        [self.contentView addSubview:self.bookNameLabel];
        [self.contentView addSubview:self.deleteButton];
        
        [self subViewsLayout];
    }
    return self;
}

#pragma mark - layout subview
- (void)subViewsLayout {
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.left.equalTo(_headerView.mas_right).offset(10);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom);
        make.left.equalTo(_headerView.mas_right).offset(10);
        make.width.equalTo(@260);
        make.height.equalTo(@20);
    }];
    
    [_praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(18);
        make.right.equalTo(self.contentView.mas_right).offset(-25);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.mas_bottom).offset(2);
        make.left.equalTo(_headerView.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(@100);
    }];
    
    [_bookImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-18);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.width.equalTo(@15);
        make.height.equalTo(@15);
    }];
    
    [_bookNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        make.left.equalTo(_bookImg.mas_right).offset(2);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
    
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.width.equalTo(@25);
        make.height.equalTo(@25);
    }];
}

#pragma mark - lazy load
- (UIImageView *)headerView {
    if (!_headerView) {
        _headerView = [[UIImageView alloc] init];
        _headerView.backgroundColor = [UIColor orangeColor];
        _headerView.layer.masksToBounds = YES;
        _headerView.layer.cornerRadius = 25.f;
    }
    
    return _headerView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor redColor];
    }
    
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor blueColor];
    }
    
    return _timeLabel;
}

- (UIButton *)praiseButton {
    if (!_praiseButton) {
        _praiseButton = [[UIButton alloc] init];
        _praiseButton.backgroundColor = MyGreenColor;
    }
    
    return _praiseButton;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.backgroundColor = [UIColor greenColor];
    }
    
    return _infoLabel;
}

- (UIButton *)allButton {
    if (!_allButton) {
        _allButton = [[UIButton alloc] init];
        _allButton.backgroundColor = [UIColor yellowColor];
    }
    
    return _allButton;
}

- (UIImageView *)bookImg {
    if (!_bookImg) {
        _bookImg = [[UIImageView alloc] init];
        _bookImg.backgroundColor = MyGreenColor;
    }
    
    return _bookImg;
}

- (UILabel *)bookNameLabel {
    if (!_bookNameLabel) {
        _bookNameLabel = [[UILabel alloc] init];
        _bookNameLabel.font = Font(15);
        _bookNameLabel.text = @"三生三世十里桃花";
    }
    
    return _bookNameLabel;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        _deleteButton.backgroundColor = [UIColor grayColor];
    }
    
    return _deleteButton;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
