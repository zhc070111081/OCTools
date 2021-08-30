//
//  HMToastView.m
//  OCToolsClass
//
//  Created by zhuhc on 2021/8/30.
//

#import "HMToastView.h"

#define maxTextWidth ([UIScreen mainScreen].bounds.size.width - 40) // 默认最大宽度
static CGFloat defaultDuration = 5; // 默认显示3s
static CGFloat defaultDelay = 0.25; // 动画显示时间
static NSInteger maxNumberOfLines = 5; // 展示的最大行数

typedef NS_ENUM(NSInteger, HMToastViewDirection){
    HMToastViewDirectionTop = 0,
    HMToastViewDirectionBottom = 1,
    HMToastViewDirectionCenter = 2
};


@interface HMToastView ()

@property (strong, nonatomic, nullable) UILabel *tipLabel;

@property (assign, nonatomic) HMToastViewDirection direction;

@end

@implementation HMToastView

#pragma mark - Class method

+ (void)showString:(NSString *)content {
    [self showString:content duration:defaultDuration];
}

+ (void)showString:(NSString *)content inView:(UIView *)view {
    [self showString:content duration:defaultDuration inView:view];
}

+ (void)showString:(NSString *)content duration:(CGFloat)duration {
    [self showString:content duration:duration inView:nil];
}

+ (void)showString:(NSString *)content duration:(CGFloat)duration inView:(UIView *)view {
    
    if (content.length == 0) return;
    
    if (view == nil) {
        view = [self keyWindow];
    }
    
    // 创建view
    
    HMToastView *toast = [[HMToastView alloc] initWithFrame:CGRectZero];
    [view addSubview:toast];

    [toast setupContent:content];
    toast.frame = [toast toastViewFrame:content];
    toast.center = view.center;
    
    // 显示视图
    [toast showToast:defaultDuration];
}

#pragma mark - method
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 更新label的frame;
    CGSize size = [self currentContentSize:self.tipLabel.text];
    CGFloat tipW = size.width;
    CGFloat tipH = size.height;
    self.tipLabel.frame = CGRectMake(0, 0, tipW, tipH);
    
    CGPoint center = self.tipLabel.center;
    center.x = self.bounds.size.width * 0.5;
    center.y = self.bounds.size.height * 0.5;
    self.tipLabel.center = center;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupConfig];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupConfig];
    }
    return self;
}

- (void)setupConfig {
    self.alpha = 0.0;
    self.backgroundColor = [UIColor blackColor];
    self.direction = HMToastViewDirectionCenter;
    [self addSubview:self.tipLabel];
}

- (void)setupContent:(NSString *)content {
    self.tipLabel.text = content;
}

- (CGRect)toastViewFrame:(NSString *)content {
    CGSize size = [self currentContentSize:content];
    CGFloat toastW = size.width + 20;
    CGFloat toastH = size.height + 20;
    return CGRectMake(0, 0, toastW, toastH);
}

- (void)showToast:(CGFloat)duration {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:defaultDelay animations:^{
            self.alpha = 1.0;
        } completion:^(BOOL finished) {
            [self performSelector:@selector(hideToast) withObject:self afterDelay:defaultDuration];
        }];
    });
}

- (void)hideToast {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:defaultDelay animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [NSLayoutConstraint deactivateConstraints:self.constraints];
        }];
    });
}

#pragma mark - getter
- (UILabel *)tipLabel {
    
    if (_tipLabel == nil) {
        _tipLabel.backgroundColor = [UIColor blueColor];
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLabel.numberOfLines = maxNumberOfLines;
        _tipLabel.font = [UIFont systemFontOfSize:15];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}


#pragma mark - key window
+ (UIWindow *)keyWindow {
    
    UIWindow *keyWindow = nil;
    
    if (@available(iOS 13.0, *)) {
        
        UIWindowScene *scene = [self windowScene];
        for (UIWindow *tWindow in scene.windows) {
            if (tWindow.isKeyWindow) {
                keyWindow = tWindow;
                break;
            }
        }
        
        if (!keyWindow) {
            keyWindow = [UIApplication sharedApplication].keyWindow;
        }
        
    } else {
        keyWindow = [UIApplication sharedApplication].keyWindow;
    }
    
    return keyWindow;
}

+ (UIWindowScene *)windowScene  API_AVAILABLE(ios(13.0)){
    
    UIWindowScene *windowScene = nil;
    
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive) {
                windowScene = scene;
                break;
            }
        }
    }
    
    return windowScene;
}

#pragma mark - content size
- (CGSize)currentContentSize:(NSString *)content {
    
    CGFloat singleLineHeight = self.tipLabel.font.lineHeight;
    CGSize tipTextSize = [self sizeForString:content font:self.tipLabel.font size:CGSizeMake(maxTextWidth, MAXFLOAT) mode:NSLineBreakByWordWrapping];

    CGFloat maxHeight = singleLineHeight * maxNumberOfLines;

    CGFloat textWidth = tipTextSize.width;
    CGFloat textHeight = tipTextSize.height;

    if (textWidth > maxTextWidth) {
        textWidth = maxTextWidth;
    }

    if (textHeight > maxHeight) {
        textHeight = maxHeight;
    }

    return CGSizeMake(textWidth, textHeight);
}

- (CGSize)sizeForString:(NSString *)string
                   font:(UIFont *)font
                   size:(CGSize)size
                   mode:(NSLineBreakMode)lineBreakMode {
    
    if (!font) font = [UIFont systemFontOfSize:15];
    
    NSMutableDictionary *attr = [NSMutableDictionary new];
    attr[NSFontAttributeName] = font;
    if (lineBreakMode != NSLineBreakByWordWrapping) {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode = lineBreakMode;
        attr[NSParagraphStyleAttributeName] = paragraphStyle;
    }
    
    CGRect rect = [string boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:attr context:nil];
    return rect.size;
}

@end
