//
//  QYSettingViewController.m
//  QingYue
//
//  Created by leilei on 2017/4/2.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYSettingViewController.h"
#import "QYBindingPhoneViewController.h"
#import "QYModifyCodeViewController.h"
#import "QYHelpViewController.h"
#import "QYFeedbackViewController.h"
#import "QYYesOrNoShotView.h"
#import "QYLoginViewController.h"

#define QYSettingTableViewCellID @"QYSettingTableViewCell"
@interface QYSettingViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 列表tableView*/
@property (nonatomic, strong) UITableView *listTableView;
/** 图标数组*/
@property (nonatomic, strong) NSArray *iconArray;
/** 标题数组*/
@property (nonatomic, strong) NSArray *titleArray;
/** 退出按钮*/
@property (nonatomic, strong) UIButton *quitButton;
/** 自定义保存弹窗*/
@property (nonatomic,strong) QYYesOrNoShotView* ensureShotView;
/** 自定义保存弹窗遮罩层 */
@property (nonatomic,strong) GKCover* saveShopCover;
@end

@implementation QYSettingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = RGB(240, 240, 240, 1.0);
    [self.view addSubview:self.listTableView];
    [self.view addSubview:self.quitButton];
    [self createIconArray];
}

#pragma mark - 按钮实现方法
- (void)completeButtonAction
{
    GKCover *cover = [GKCover translucentCoverWithTarget:self action:nil];
    cover.alpha = 0.3;
    cover.frame = [UIScreen mainScreen].bounds;
    [self.view.window addSubview:cover];
    self.saveShopCover = cover;
    self.ensureShotView.frame = CGRectMake(30, MSSize_Height / 2 - 150, MSSize_Width - 60, 160);
    [self.view.window addSubview:self.ensureShotView];
    _ensureShotView.contentLabel.text = @"确定要退出?";
}
/**
 *  隐藏保存按钮提示框
 */
- (void)hiddenSaveShotViewClick
{
    [_saveShopCover removeFromSuperview];
    [_ensureShotView removeFromSuperview];
}

//选择是, 退出登录, 跳转到登录页面
- (void)sureButtonClick
{
    
}
#pragma mark - tableview delegate and datasource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            QYBindingPhoneViewController *bindingPhoneVC = [[QYBindingPhoneViewController alloc] init];
            [self.navigationController pushViewController:bindingPhoneVC animated:YES];
        } else if (indexPath.row == 1) {
            QYModifyCodeViewController *modifyVC =[[QYModifyCodeViewController alloc] init];
            [self.navigationController pushViewController:modifyVC animated:YES];
        }
    } else if (indexPath.section == 1) {
        QYHelpViewController *helpVC = [[QYHelpViewController alloc] init];
        [self.navigationController pushViewController:helpVC animated:YES];
    } else if (indexPath.section == 2) {
        QYFeedbackViewController *feedBackVC = [[QYFeedbackViewController alloc] init];
        [self.navigationController pushViewController:feedBackVC animated:YES];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *listCell = [tableView dequeueReusableCellWithIdentifier:QYSettingTableViewCellID forIndexPath:indexPath];
    if (!listCell) {
        listCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:QYSettingTableViewCellID];
    }
    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    listCell.textLabel.font = Font(15);
    listCell.textLabel.text = _titleArray[indexPath.section][indexPath.row];
    listCell.imageView.image = [UIImage imageNamed:_iconArray[indexPath.section][indexPath.row]];
    listCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return listCell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else {
        return 1;
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
#pragma mark - 布局
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    [_quitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@(50));
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
        [_listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:QYSettingTableViewCellID];
        
    }
    return _listTableView;
}
- (UIButton *)quitButton {
    if (!_quitButton) {
        _quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //上来注册的按钮就设置为灰色
        _quitButton.backgroundColor = RGB(38, 203, 100, 1.0);
        _quitButton.layer.cornerRadius = 5;
        _quitButton.enabled = NO;
        [_quitButton setTitle:@"确定" forState:UIControlStateNormal];
        [_quitButton addTarget:self action:@selector(completeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _quitButton;
}
- (QYYesOrNoShotView *)ensureShotView
{
    if (!_ensureShotView) {
        _ensureShotView = [[QYYesOrNoShotView alloc] init];
        _ensureShotView.layer.cornerRadius = 11.f;
         [_ensureShotView.sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_ensureShotView.cancelButton addTarget:self action:@selector(hiddenSaveShotViewClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ensureShotView;
}

- (void)createIconArray
{
    _iconArray =@[
                  @[ @"jieyuejilu", @"guihuan"],
                  @[ @"zhuanjie"],
                  @[ @"jiangou"]
                  ];
    _titleArray = @[
                    @[ @"绑定手机号", @"密码修改"],
                    @[ @"帮助"],
                    @[ @"信息反馈"]
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
