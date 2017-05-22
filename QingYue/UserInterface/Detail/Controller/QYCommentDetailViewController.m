//
//  QYCommentDetailViewController.m
//  QingYue
//
//  Created by 崔明燃 on 2017/4/8.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYCommentDetailViewController.h"

#import "QYCommentDetailTableViewCell.h"

static NSString *commentDetailTableViewCellIdentifier = @"commentDetailTableViewCellIdentifier";

@interface QYCommentDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *commentTableView;  

@end

@implementation QYCommentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"评论";
    [self.view addSubview:self.commentTableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self layoutSubviews];
}

#pragma mark - tableView delegate and datasoure
// 分几个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

// 每个section里面cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 240;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QYCommentDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commentDetailTableViewCellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - layout subviews
- (void)layoutSubviews {
    [_commentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - lazy load
- (UITableView *)commentTableView {
    if (!_commentTableView) {
        _commentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _commentTableView.delegate = self;
        _commentTableView.dataSource = self;
        [_commentTableView registerClass:[QYCommentDetailTableViewCell class] forCellReuseIdentifier:commentDetailTableViewCellIdentifier];
    }
    
    return _commentTableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
