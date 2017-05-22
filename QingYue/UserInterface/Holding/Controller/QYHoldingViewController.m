//
//  QYHoldingViewController.m
//  QingYue
//
//  Created by leilei on 2017/3/26.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYHoldingViewController.h"

static CGFloat kOffset = 15;   // 按钮间距
@interface QYHoldingViewController ()
/** 列表collectionView*/
@property (nonatomic,strong) UICollectionView* listCollectionView;

@property (strong, nonatomic) UIButton *renwenButton;  // 人文自然
@property (strong, nonatomic) UIButton *swButton;  // 生物
@property (strong, nonatomic) UIButton *historyButton;  // 历史
@property (strong, nonatomic) UIButton *farmButton;   // 农业
@property (strong, nonatomic) UIButton *storyButton;  // 小说
@property (strong, nonatomic) UIButton *meiwenButton;  // 美文
@property (strong, nonatomic) UIButton *shikanButton;  // 时刊
@property (strong, nonatomic) UIButton *scienceButton;  // 环境科学
@property (strong, nonatomic) UIButton *artButton;     // 艺术
@property (strong, nonatomic) UIButton *medicalButton; // 医学
@property (strong, nonatomic) UIButton *moreButton;    // 更多

@end

@implementation QYHoldingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:self.renwenButton];
    [self.view addSubview:self.swButton];
    [self.view addSubview:self.historyButton];
    [self.view addSubview:self.farmButton];
    [self.view addSubview:self.storyButton];
    [self.view addSubview:self.meiwenButton];
    [self.view addSubview:self.shikanButton];
    [self.view addSubview:self.scienceButton];
    [self.view addSubview:self.artButton];
    [self.view addSubview:self.medicalButton];
    [self.view addSubview:self.moreButton];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self layoutSubviews];
    
}

#pragma mark - layout subviews 
- (void)layoutSubviews {
    
    CGFloat bigButtonWidth = (self.view.width - 3 * kOffset) / 2;
    CGFloat bigButtonHeight = (self.view.height - 6 * kOffset) / 5 * 2 - 20;
    CGFloat smallButtonWidth = ((self.view.width / 2 - 2 * kOffset) - 10) / 2;
    CGFloat smallButtonHeight = (self.view.height - 6 * kOffset) / 5 - 17;
    
    [_renwenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kOffset);
        make.left.equalTo(self.view.mas_left).offset(kOffset);
        make.width.equalTo(@(bigButtonWidth));
        make.height.equalTo(@(bigButtonHeight));
    }];
    
    
    [_swButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kOffset);
        make.left.equalTo(_renwenButton.mas_right).offset(kOffset);
        make.width.equalTo(@(smallButtonWidth));
        make.height.equalTo(@(smallButtonHeight));
    }];
    
    [_historyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kOffset);
        make.left.equalTo(_swButton.mas_right).offset(kOffset);
        make.width.equalTo(@(smallButtonWidth));
        make.height.equalTo(@(smallButtonHeight));
    }];
    
    [_farmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_swButton.mas_bottom).offset(kOffset);
        make.left.equalTo(_renwenButton.mas_right).offset(kOffset);
        make.right.equalTo(self.view.mas_right).offset(-kOffset);
        make.height.equalTo(@(smallButtonHeight));
    }];
    
    [_storyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_renwenButton.mas_bottom).offset(kOffset);
        make.left.equalTo(self.view.mas_left).offset(kOffset);
        make.width.equalTo(@(smallButtonWidth));
        make.height.equalTo(@(smallButtonHeight));
    }];
    
    [_meiwenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_renwenButton.mas_bottom).offset(kOffset);
        make.left.equalTo(_storyButton.mas_right).offset(kOffset);
        make.width.equalTo(@(smallButtonWidth));
        make.height.equalTo(@(smallButtonHeight));
    }];
    
    [_shikanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_renwenButton.mas_bottom).offset(kOffset);
        make.left.equalTo(_renwenButton.mas_right).offset(kOffset);
        make.right.equalTo(self.view.mas_right).offset(-kOffset);
        make.height.equalTo(@(smallButtonHeight));
    }];
    
    [_scienceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_storyButton.mas_bottom).offset(kOffset);
        make.left.equalTo(self.view.mas_left).offset(kOffset);
        make.width.equalTo(@(bigButtonWidth));
        make.height.equalTo(@(bigButtonHeight));
    }];
    
    
    [_artButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scienceButton.mas_top);
        make.left.equalTo(_scienceButton.mas_right).offset(kOffset);
        make.width.equalTo(@(smallButtonWidth));
        make.height.equalTo(@(smallButtonHeight));
    }];
    
    [_medicalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scienceButton.mas_top);
        make.left.equalTo(_artButton.mas_right).offset(kOffset);
        make.width.equalTo(@(smallButtonWidth));
        make.height.equalTo(@(smallButtonHeight));
    }];
    
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_artButton.mas_bottom).offset(kOffset);
        make.left.equalTo(_renwenButton.mas_right).offset(kOffset);
        make.right.equalTo(self.view.mas_right).offset(-kOffset);
        make.height.equalTo(@(smallButtonHeight));
    }];
}

#pragma mark - lazyloading
- (UIButton *)renwenButton {
    if (!_renwenButton) {
        _renwenButton = [[UIButton alloc] init];
        _renwenButton.backgroundColor = [UIColor blueColor];
        [_renwenButton setTitle:@"人文自然" forState:UIControlStateNormal];
    }
    
    return _renwenButton;
}

-(UIButton *)swButton {
    if (!_swButton) {
        _swButton = [[UIButton alloc] init];
        _swButton.backgroundColor = [UIColor greenColor];
        [_swButton setTitle:@"生物" forState:UIControlStateNormal];
    }
    
    return _swButton;
}

- (UIButton *)historyButton {
    if (!_historyButton) {
        _historyButton = [[UIButton alloc] init];
        _historyButton.backgroundColor = [UIColor blueColor];
        [_historyButton setTitle:@"历史" forState:UIControlStateNormal];
    }
    
    return _historyButton;
}

- (UIButton *)farmButton {
    if (!_farmButton) {
        _farmButton = [[UIButton alloc] init];
        _farmButton.backgroundColor = [UIColor orangeColor];
        [_farmButton setTitle:@"农业" forState:UIControlStateNormal];
    }
    
    return _farmButton;
}

- (UIButton *)storyButton {
    if (!_storyButton) {
        _storyButton = [[UIButton alloc] init];
        _storyButton.backgroundColor = [UIColor blueColor];
        [_storyButton setTitle:@"小说" forState:UIControlStateNormal];
    }
    
    return _storyButton;
}

- (UIButton *)meiwenButton {
    if (!_meiwenButton) {
        _meiwenButton = [[UIButton alloc] init];
        _meiwenButton.backgroundColor = [UIColor orangeColor];
        [_meiwenButton setTitle:@"美文" forState:UIControlStateNormal];
    }
    
    return _meiwenButton;
}

- (UIButton *)shikanButton {
    if (!_shikanButton) {
        _shikanButton = [[UIButton alloc] init];
        _shikanButton.backgroundColor = [UIColor purpleColor];
        [_shikanButton setTitle:@"时刊" forState:UIControlStateNormal];
    }
    
    return _shikanButton;
}

- (UIButton *)scienceButton {
    if (!_scienceButton) {
        _scienceButton = [[UIButton alloc] init];
        _scienceButton.backgroundColor = [UIColor blueColor];
        [_scienceButton setTitle:@"环境科学" forState:UIControlStateNormal];
    }
    
    return _scienceButton;
}

- (UIButton *)artButton {
    if (!_artButton) {
        _artButton = [[UIButton alloc] init];
        _artButton.backgroundColor = [UIColor darkGrayColor];
        [_artButton setTitle:@"艺术" forState:UIControlStateNormal];
    }
    
    return _artButton;
}

- (UIButton *)medicalButton {
    if (!_medicalButton) {
        _medicalButton = [[UIButton alloc] init];
        _medicalButton.backgroundColor = [UIColor brownColor];
        [_medicalButton setTitle:@"医学" forState:UIControlStateNormal];
    }
    
    return _medicalButton;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [[UIButton alloc] init];
        _moreButton.backgroundColor = [UIColor orangeColor];
        [_moreButton setTitle:@"更多" forState:UIControlStateNormal];
    }
    
    return _moreButton;
}

#pragma mark - lazy load
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
