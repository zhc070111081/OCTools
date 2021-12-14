//
//  ViewController.m
//  OCToolsClass
//
//  Created by 心诚 on 2021/8/24.
//

#import "ViewController.h"
#import "HMKeychainService.h"
#import "HMCommonHeader.h"
#import "HMToastView.h"
#import "HMAlertViewController.h"
#import "HMDownloadManager.h"
#import <sys/utsname.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    // 获取设备标识Identifier
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    UIDevice *device = [UIDevice currentDevice];
    NSString *name =  device.name;
    NSLog(@"name: %@ --- model: %@ --- localizedModel: %@ --- systemName: %@ --- systemVersion: %@",device.name,device.model,device.localizedModel,device.systemName,device.systemVersion);
    
//    id object = [HMKeychainService readData:@"com.apple.tools" resultClass:[NSDictionary class]];
////    id object = [HMKeychainService readData:@"com.apple.tools2223" resultClass:[NSArray class]];
//
//    if (object == nil) {
//        NSDictionary *dic = @{@"userAccount":@"test01",@"pwd":@"12345"};
//        [HMKeychainService saveData:dic withIdentifier:@"com.apple.tools2223"];
//    }
//
//    NSLog(@"object: %@",object);
//
//    weakObject(self);
    
//    HMRandomColor(<#r#>, <#g#>, <#b#>)
    
//    [HMToastView showString:@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈"];
    
//    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
//    view.backgroundColor = [UIColor blackColor];
//    view.alpha = 0.6;
//    [self.view addSubview:view];
    
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
//    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//
//    UIView *sunView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
//    sunView.backgroundColor = [UIColor whiteColor];
//    [vc.view addSubview:sunView];
//    sunView.center = vc.view.center;
//    [self presentViewController:vc animated:NO completion:^{}];
    
    
    
//    NSLog(@"scale : %f",[UIScreen mainScreen].scale);
//    // 哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈
//    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"提示" message:@"哈哈哈哈哈哈哈哈哈哈哈" preferredStyle:UIAlertControllerStyleAlert];//UIAlertActionStyleDefault
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//
//    [vc addAction:action];
//
//    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//
//    [vc addAction:action1];
//
//    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//
//    [vc addAction:action2];
//
//    [self presentViewController:vc animated:YES completion:^{
//        NSLog(@"%@---%ld",vc.view,vc.modalPresentationStyle);
//
//    }];
    
//    HMAlertViewController *vc = [HMAlertViewController alertWithTitle:@"提示" message:@" 哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈" buttons:@[@"取消", @"确定"] callback:^(HMAlertStyle index) {
//
//    }];
//
//    [self presentViewController:vc animated:NO completion:^{
//        NSLog(@"%@---%ld",vc.view,vc.modalPresentationStyle);
//    }];
    
    //https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4
    // NSLog(@"接收下载数据  currentSize: %lld ----> totoaSize: %lld",source.totalBytesWritten, source.totalBytesExpectedToWrite);
//    [[HMDownloadManager defaultManager] downloadWithUrl:@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4" allHTTPHeaderFields:nil progress:^(HMDownloadSource * _Nullable source) {
//        NSLog(@"接收下载数据  currentSize: %lld ----> totoaSize: %lld",source.totalBytesWritten, source.totalBytesExpectedToWrite);
//    } complete:^(HMDownloadSource * _Nullable source, NSError * _Nullable error) {
//        NSLog(@"error: %@",error);
//    }];
}


-(void)readRGBForUIColor:(UIColor*)color{
 
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat b = components[2] * 255;
    CGFloat g = components[1] * 255;
    CGFloat r = components[0] * 255;
    NSLog(@"red:%f\ngreen:%f\nblue:%f",r,g,b);
}

@end
