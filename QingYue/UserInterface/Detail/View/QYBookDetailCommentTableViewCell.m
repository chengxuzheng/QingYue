//
//  QYBookDetailCommentTableViewCell.m
//  QingYue
//
//  Created by 崔明燃 on 2017/4/2.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYBookDetailCommentTableViewCell.h"

@implementation QYBookDetailCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //self.contentView.backgroundColor = [UIColor redColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.headerView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.infoLabel];
        [self.contentView addSubview:self.allButton];
        
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
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.mas_bottom).offset(2);
        make.left.equalTo(_headerView.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(@100);
    }];
}

#pragma mark - lazy load
- (UIImageView *)headerView {
    if (!_headerView) {
        _headerView = [[UIImageView alloc] init];
        [_headerView setImage:[UIImage imageNamed:@"默认用户头像"]];
        _headerView.backgroundColor = [UIColor orangeColor];
        _headerView.layer.masksToBounds = YES;
        _headerView.layer.cornerRadius = 25.f;
    }
    
    return _headerView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"傻瓜逗逗";
        _nameLabel.font = Font(15);
//        _nameLabel.backgroundColor = [UIColor redColor];
    }
    
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = Font(13);
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.text = @"2017年10月25日";
//        _timeLabel.backgroundColor = [UIColor blueColor];
    }
    
    return _timeLabel;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.font = Font(14);
        _infoLabel.textColor = [UIColor lightGrayColor];
        _infoLabel.numberOfLines = 0;
        _infoLabel.text = @"《我们内心的冲突》，本书讨论了人内心的主要的冲突类型和它们的各种表现形式，分析并归纳了各种相互矛盾的态度和倾向，指出了被这些冲突所扰之人旨在解决冲突的努力结果怎样导致失败并陷入恶性循环，提出了解决这些冲突的切实可行的建议和设想。因此，即使读者已经从作者早期论著如《我们时代的神经症人格》中初步接触了她的理论，但要真正认识、全面了解作者及其代表的学说，则只有在进一步细读她后期的成熟之作——《我们内心的冲突》之后才能实现。较之于《我们时代的神经人格》，不仅在理论上有重大的发展，而且达到了早期著作中鲜有的哲学的高度";
//        _infoLabel.backgroundColor = [UIColor greenColor];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
