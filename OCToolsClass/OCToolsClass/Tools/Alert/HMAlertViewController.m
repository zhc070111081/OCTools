//
//  HMAlertViewController.m
//  OCToolsClass
//
//  Created by zhuhc on 2021/8/31.
//

#import "HMAlertViewController.h"

@interface HMAlertViewController ()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property (weak, nonatomic) IBOutlet UIView *horizontalLine;

// vertical
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIView *verticalLine;

@property (copy, nonatomic, nullable) void(^callback)(HMAlertStyle index);

@property (strong, nonatomic, nullable) NSArray<NSString *> *buttons;

@property (copy, nonatomic, nullable) NSString *titleTips;

@property (copy, nonatomic, nullable) NSString *message;

@end

@implementation HMAlertViewController

+ (instancetype)instantiateViewControllerWithIdentifier:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Alert" bundle:[NSBundle mainBundle]];
    HMAlertViewController *vc = [storyboard instantiateViewControllerWithIdentifier:identifier];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    return vc;
}

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray<NSString *> *)buttons callback:(void (^)(HMAlertStyle))callback {
    
    if (buttons.count == 0) return nil;
    
    HMAlertViewController *vc = nil;
    
    if (buttons.count == 1) {
        vc = [self instantiateViewControllerWithIdentifier:@"SingleButtonAlert"];
    }
    
    if (buttons.count == 2) {
        vc = [self instantiateViewControllerWithIdentifier:@"TwoButtonAlert"];
    }
    vc.titleTips = title;
    vc.message = message;
    vc.buttons = buttons;
    vc.callback = callback;
    
    
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    [self setupConfig];
}

- (void)setupConfig {
    
    self.bgView.layer.cornerRadius = 15;
    self.bgView.hidden = YES;
    self.bgView.alpha = 0;
    
    self.titleLabel.text = self.titleTips;
    self.contentLabel.text = self.message;
    
    if (self.buttons.count == 1) {
        [self.confirmBtn setTitle:self.buttons.firstObject forState:UIControlStateNormal];
    }
    
    if (self.buttons.count == 2) {
        [self.cancelBtn setTitle:self.buttons.firstObject forState:UIControlStateNormal];
        [self.confirmBtn setTitle:self.buttons.lastObject forState:UIControlStateNormal];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self showAlert];
}

- (void)showAlert {
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.hidden = NO;
        self.bgView.alpha = 1.0;
    } completion:^(BOOL finished) {
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (IBAction)confirmClick:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:^{}];
    if (self.callback) self.callback(HMAlertStyleConfirm);
}
- (IBAction)cancelClick:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:^{}];
    if (self.callback) self.callback(HMAlertStyleCancel);
}

@end
