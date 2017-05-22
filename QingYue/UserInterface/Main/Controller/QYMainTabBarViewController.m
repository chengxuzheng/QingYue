//
//  QYMainTabBarViewController.m
//  QingYue
//
//  Created by leilei on 2017/3/26.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYMainTabBarViewController.h"
#import "QYHomeViewController.h"
#import "QYHoldingViewController.h"
#import "QYScanViewController.h"
#import "QYBookShelfViewController.h"
#import "QYMoreViewController.h"
#import "BaseNavigationController.h"

@interface QYMainTabBarViewController ()<UITabBarControllerDelegate>
/** 中间按钮*/
@property (nonatomic, strong) UIButton *middleButton;

@end

@implementation QYMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barTintColor = [UIColor whiteColor];
    [self setTabBarVC];
    [self setupMiddleButton];
    [self addButtonNotifation];
}

#pragma mark - 添加通知
//添加大圆按钮的通知
-(void)addButtonNotifation{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(buttonHidden) name:@"buttonNotifationCenter" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(buttonNotHidden) name:@"buttonNotHidden" object:nil];
}
-(void)buttonNotHidden{
    _middleButton.hidden=NO;
}
-(void)buttonHidden{
    _middleButton.hidden=YES;
}

#pragma mark - 添加中间按钮
-(void)setupMiddleButton
{
    //  添加突出按钮
    [self addCenterButtonWithImage:[UIImage imageNamed:@"中间绿"] selectedImage:[UIImage imageNamed:@"中间绿"]];
    //  UITabBarControllerDelegate 指定为自己
    self.delegate = self;
    //  指定当前页——中间页
    //self.selectedIndex=0;
    //  设点button状态
    //button.selected=YES;
    //  设定其他item点击选中颜色
}

-(void) addCenterButtonWithImage:(UIImage*)buttonImage selectedImage:(UIImage*)selectedImage
{
    _middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_middleButton addTarget:self action:@selector(pressChange:) forControlEvents:UIControlEventTouchUpInside];
    _middleButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    
    //  设定button大小为适应图片
    _middleButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [_middleButton setImage:buttonImage forState:UIControlStateNormal];
    [_middleButton setImage:selectedImage forState:UIControlStateSelected];
    
    // 去掉选中button时候的阴影
    _middleButton.adjustsImageWhenHighlighted = NO;
    /*
     *  核心代码：设置button的center 和 tabBar的 center 做对齐操作， 同时做出相对的上浮
     */
    CGPoint center = self.tabBar.center;
    center.y = center.y - buttonImage.size.height / 4;
    _middleButton.center = center;
    [self.view addSubview:_middleButton];
}
//按钮实现方法
-(void)pressChange:(id)sender
{
    self.selectedIndex = 2;
    _middleButton.selected = YES;
}


#pragma mark- TabBar Delegate
//  换页和button的状态关联上
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (self.selectedIndex == 2) {
        _middleButton.selected=YES;
    }else
    {
        _middleButton.selected=NO;
    }
}

#pragma mark - 初始化所有控制器
// 初始化所有子控制器
- (void)setTabBarVC{
    [self setTabBarChildController:[[QYHomeViewController alloc] init] title:@"推荐" image:@"推荐灰" selectImage:@"推荐绿"];
    [self setTabBarChildController:[[QYHoldingViewController alloc] init] title:@"馆藏" image:@"馆藏灰" selectImage:@"馆藏绿"];
    [self setTabBarChildController:[[QYScanViewController alloc] init] title:nil image:@"" selectImage:@""];
    [self setTabBarChildController:[[QYBookShelfViewController alloc] init] title:@"书架" image:@"书架灰" selectImage:@"书架绿"];
    [self setTabBarChildController:[[QYMoreViewController alloc] init] title:@"更多" image:@"更多灰" selectImage:@"更多绿"];
}

// 添加tabbar的子viewcontroller
- (void)setTabBarChildController: (UIViewController *)controller title: (NSString *)title image: (NSString *)imageStr selectImage: (NSString *)selectImageStr
{
     BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:controller];
    navi.tabBarItem.title = title;
    navi.tabBarItem.image = [[UIImage imageNamed:imageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navi.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [navi.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:RGB(74, 74, 74, 1.0)} forState:UIControlStateNormal];
    [navi.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:UIColorFromRGB(0x22cb64)} forState:UIControlStateSelected];
    
    [self addChildViewController:navi];
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
