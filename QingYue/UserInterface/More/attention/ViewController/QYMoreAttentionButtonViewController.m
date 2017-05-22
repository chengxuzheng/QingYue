//
//  QYMoreAttentionButtonViewController.m
//  QingYue
//
//  Created by leilei on 2017/4/8.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYMoreAttentionButtonViewController.h"
#import "QYMoreAttentionButtonTableViewCell.h"


//static NSString *QYMoreAttentionButtonTableViewCellID = @"QYMoreAttentionButtonTableViewCell";
#define QYSettingTableViewCellID @"QYSettingTableViewCell"
@interface QYMoreAttentionButtonViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 列表*/
@property (nonatomic, strong) UITableView *listTableView;

@end

@implementation QYMoreAttentionButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关注";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.listTableView];
}

#pragma mark - 按钮实现方法


#pragma mark - tableview delegate and dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYMoreAttentionButtonTableViewCell *attentionCell = [tableView dequeueReusableCellWithIdentifier: QYSettingTableViewCellID forIndexPath:indexPath];
    
    return attentionCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1f;
}
#pragma mark - 布局
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

#pragma mark - lazy load
- (UITableView *)listTableView
{
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.separatorColor = UIColorFromRGB(0xe3e3e3);
        [_listTableView registerClass:[QYMoreAttentionButtonTableViewCell class] forCellReuseIdentifier: QYSettingTableViewCellID];
    }
    return _listTableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
