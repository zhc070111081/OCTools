//
//  HMNavigationController.m
//  OCToolsClass
//
//  Created by zhuhc on 2021/8/26.
//

#import "HMNavigationController.h"

@interface HMNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation HMNavigationController

//+ (void)initialize {
//    // 设置导航栏背景图片和颜色
//    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
//    [bar setBarTintColor:YJColor(40, 40, 53)];
//    [bar setBarTintColor:YJColor(40, 40, 53)];
//    [bar setTranslucent:NO];
//
//    // 设置导航栏上文字的属性
//    NSMutableDictionary *titleDic = [NSMutableDictionary dictionary];
//    titleDic[NSFontAttributeName] = [UIFont systemFontOfSize:18];
//    titleDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    [bar setTitleTextAttributes:titleDic];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 开启侧滑返回功能
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.viewControllers.count != 0) {

        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;

        // 设置导航栏统一返回按钮
        UIImage *image = [[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    }

    [super pushViewController:viewController animated:animated];
}

- (void)pop {
    [self popViewControllerAnimated:YES];
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {

    if (self.viewControllers.count == 1) {
        return NO;
    }
    // 禁止某个控制器 不开启侧滑返回
//    else if (<#expression#>)

    return YES;
}

// 返回当前界面设置的状态栏颜色
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}
@end
