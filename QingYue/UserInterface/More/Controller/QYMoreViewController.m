//
//  QYMoreViewController.m
//  QingYue
//
//  Created by leilei on 2017/3/26.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYMoreViewController.h"
#import "QYMoreUserTableViewCell.h"
#import "QYMoreButtonTableViewCell.h"
#import "QYSettingViewController.h"
#import "QYMoreAttentionButtonViewController.h"
#import "QYMoreRecommendBuyButtonViewController.h"

#define QYMoreUserTableViewCellID @"QYMoreUserTableViewCell"
#define QYMoreButtonTableViewCellID @"QYMoreButtonTableViewCell"
#define QYMoreListTableViewCellID @"QYMoreListTableViewCell"

@interface QYMoreViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 列表tableView*/
@property (nonatomic, strong) UITableView *listTableView;
/** 图标数组*/
@property (nonatomic, strong) NSArray *iconArray;
/** 标题数组*/
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation QYMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"更多";
    self.view.backgroundColor = RGB(240, 240, 240, 1.0);
    [self.view addSubview:self.listTableView];
    [self createIconArray];
    [self createRightButton];
}

#pragma mark - 按钮实现方法
//右上角按钮点击
- (void)rigthButtonClick
{
   
}
//关注按钮实现
- (void)attentionButtonClick
{
    QYMoreAttentionButtonViewController *attentionVC = [[QYMoreAttentionButtonViewController alloc] init];
    [self.navigationController pushViewController:attentionVC animated:YES];
}
//评论按钮实现
- (void)commentButtonClick
{
    
}

//荐购按钮实现
- (void)recommentButtonClick
{
    QYMoreRecommendBuyButtonViewController *recommendVC = [[QYMoreRecommendBuyButtonViewController alloc] init];
    [self.navigationController pushViewController:recommendVC animated:YES];
}

#pragma mark - 设置导航栏
- (void)createRightButton
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 40, 40);
    [rightButton setImage:[UIImage imageNamed:@"information"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rigthButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - tableview delegate and datasource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        if (indexPath.row == 4) {
            QYSettingViewController *setingVC = [[QYSettingViewController alloc] init];
//            setingVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setingVC animated:YES];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        QYMoreUserTableViewCell *userCell = [tableView dequeueReusableCellWithIdentifier:QYMoreUserTableViewCellID forIndexPath:indexPath];
        
        return userCell;
    } else if (indexPath.section == 1) {
        QYMoreButtonTableViewCell *buttonCell = [tableView dequeueReusableCellWithIdentifier:QYMoreButtonTableViewCellID forIndexPath:indexPath];
        [buttonCell.attentionButton addTarget:self action:@selector(attentionButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [buttonCell.commentButton addTarget:self action:@selector(commentButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [buttonCell.recommentButton addTarget:self action:@selector(recommentButtonClick) forControlEvents:UIControlEventTouchUpInside];
        return buttonCell;
    } else {
        UITableViewCell *listCell = [tableView dequeueReusableCellWithIdentifier:QYMoreListTableViewCellID forIndexPath:indexPath];
        if (!listCell) {
            listCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:QYMoreListTableViewCellID];
        }
        listCell.imageView.image = [UIImage imageNamed:_iconArray[indexPath.row]];
        listCell.textLabel.font = Font(15);
        listCell.textLabel.text = _titleArray[indexPath.row];
        listCell.selectionStyle = UITableViewCellSelectionStyleNone;
        listCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return listCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }else if (indexPath.section == 1) {
        return 75;
    } else {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 5;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

#pragma mark - 布局
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark - lazy load
- (UITableView *)listTableView
{
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _listTableView.backgroundColor = RGB(240, 240, 240, 1.0);
        _listTableView.separatorColor = UIColorFromRGB(0xe3e3e3);
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        [_listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:QYMoreListTableViewCellID];
        [_listTableView registerClass:[QYMoreUserTableViewCell class] forCellReuseIdentifier:QYMoreUserTableViewCellID];
        [_listTableView registerClass:[QYMoreButtonTableViewCell class] forCellReuseIdentifier:QYMoreButtonTableViewCellID];
    }
    return _listTableView;
}

- (void)createIconArray
{
    _iconArray = @[
                   @"jieyuejilu", @"guihuan", @"zhuanjie", @"jiangou", @"shezhi"
                   ];
    _titleArray = @[
                    @"借阅记录", @"归还记录", @"转借记录", @"荐购记录", @"设置"
                    ];
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
