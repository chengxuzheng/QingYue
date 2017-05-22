//
//  QYBookDetailViewController.m
//  QingYue
//
//  Created by 崔明燃 on 2017/3/29.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYBookDetailViewController.h"
#import "QYCommentViewController.h"
#import "QYCommentDetailViewController.h"

#import "QYBookDetailListHeaderView.h"
#import "QYBookDetailCommentTableViewCell.h"

static NSString *listTableViewCommentCell = @"listTableViewCommentCell";
static CGFloat listHeaderHeigh = 200;

@interface QYBookDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *listTableView;
@property (strong, nonatomic) QYBookDetailListHeaderView *listHeader; // 頭视图

@end

@implementation QYBookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图书详情";
    
    [self.view addSubview:self.listTableView];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return listHeaderHeigh;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

// 每个section里面cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //QYBookDetailListHeaderView *detailHeaderView = [[UIView alloc] init];
    
    return self.listHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QYBookDetailCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:listTableViewCommentCell forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    QYCommentViewController *commentVC = [[QYCommentViewController alloc] init];
//    [self.navigationController pushViewController:commentVC animated:YES];
    QYCommentDetailViewController *commentDetailVC = [[QYCommentDetailViewController alloc] init];
    [self.navigationController pushViewController:commentDetailVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {

}


#pragma mark - layout subviews
- (void)layoutSubviews {
    [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - lazy load
- (UITableView *)listTableView {
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        [_listTableView registerClass:[QYBookDetailCommentTableViewCell class] forCellReuseIdentifier:listTableViewCommentCell];
    }
    
    return _listTableView;
}

- (QYBookDetailListHeaderView *)listHeader {
    if (!_listHeader) {
        _listHeader = [[QYBookDetailListHeaderView alloc] initWithFrame:(CGRect){0, 0, self.view.width, listHeaderHeigh}];
        
    }
    
    return _listHeader;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
