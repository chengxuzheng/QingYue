//
//  QYHelpViewController.m
//  QingYue
//
//  Created by leilei on 2017/4/3.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYHelpViewController.h"


#define QYHelpViewControllerCellID @"QYHelpViewControllerCell"
@interface QYHelpViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 列表tableView*/
@property (nonatomic, strong) UITableView *listTableView;
/** 图标数组*/
@property (nonatomic, strong) NSArray *iconArray;
/** 标题数组*/
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation QYHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"帮助";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.listTableView];
    [self createIconArray];
}

#pragma mark - tableviewdelegate and datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *listCell = [tableView dequeueReusableCellWithIdentifier:QYHelpViewControllerCellID forIndexPath:indexPath];
    
    if (!listCell) {
        listCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:QYHelpViewControllerCellID];
    }
    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    listCell.textLabel.font = Font(15);
    listCell.textLabel.text = _titleArray[indexPath.section][indexPath.row];
    listCell.imageView.image = [UIImage imageNamed:_iconArray[indexPath.section][indexPath.row]];
    return listCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.backgroundColor = RGB(240, 240, 240, 1.0);
        _listTableView.separatorColor = UIColorFromRGB(0xe3e3e3);
        [_listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:QYHelpViewControllerCellID];
    }
    return _listTableView;
}
- (void)createIconArray
{
    _iconArray =@[
                  @[ @"saoyisao"],
                  @[ @"guancang"],
                  @[ @"history"],
                  @[ @"soushuo"],
                  @[ @"tuijiancc"]
                  ];
    _titleArray = @[
                    @[ @"扫一扫: 通过扫描来借阅、归还和转借图书"],
                    @[ @"馆藏: 图书馆藏中书的分类"],
                    @[ @"历史记录: 查看借阅、归还和转借图书的记录"],
                    @[ @"图书搜索: 这里可以找到心仪的图书"],
                    @[ @"荐购图书: 把想要看的书提交给我们"]
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
