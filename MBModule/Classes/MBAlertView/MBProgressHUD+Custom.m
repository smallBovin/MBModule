//
//  MBProgressHUD+Custom.m
//  samllVideoPartner
//
//  Created by 李保洋 on 2018/12/20.
//  Copyright © 2018年 bovin. All rights reserved.
//

#import "MBProgressHUD+Custom.h"



#define kAfterDalayTime     1.0
#define kAdapt(x)     (x)*([UIScreen mainScreen].bounds.size.width/375.0)

@implementation MBProgressHUD (Custom)

#pragma mark--仅文字弹框提示----

+ (instancetype)showOnlyTextMessage:(NSString *)message {
    return [self showOnlyTextMessage:message afterDalay:kAfterDalayTime];
}
+ (instancetype)showOnlyTextMessage:(NSString *)message afterDalay:(NSTimeInterval)afterDalay {
    return [self showOnlyTextMessage:message toView:nil afterDalay:afterDalay];
}
+ (instancetype)showOnlyTextMessage:(NSString *)message toView:(UIView *)view afterDalay:(NSTimeInterval)afterDalay {
    if (nil == view) {
        view = [UIApplication sharedApplication].delegate.window;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor blackColor];
    hud.label.text = message;
    hud.label.textColor = [UIColor whiteColor];
    hud.label.font = [UIFont systemFontOfSize:16];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:afterDalay];
    return hud;
}

#pragma mark--静态图片的弹框-----
+ (instancetype)showIconImage:(UIImage *)image message:(NSString *)message {
    return [self showIconImage:image message:message afterDalay:kAfterDalayTime];
}
+ (instancetype)showIconImage:(UIImage *)image message:(NSString *)message afterDalay:(NSTimeInterval)afterDalay {
    return [self showIconImage:image message:message toView:nil afterDalay:afterDalay];
}
+ (instancetype)showIconImage:(UIImage *)image message:(NSString *)message toView:(UIView *)view afterDalay:(NSTimeInterval)afterDalay {
    if (nil == view) {
        view = [UIApplication sharedApplication].delegate.window;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.customView = [[UIImageView alloc]initWithImage:image];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:afterDalay];
    return hud;
}
+ (instancetype)showCustomView:(UIView *)customView message:(NSString *)message toView:(UIView *)view afterDalay:(NSTimeInterval)afterDalay {
    if (nil == view) {
        view = [UIApplication sharedApplication].delegate.window;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (message.length>0) {
        hud.label.text = message;
    }
    hud.customView = customView;
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:afterDalay];
    return hud;
}

+ (instancetype)showUploadOrDownloadProgress:(CGFloat)pregress {
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor whiteColor];
    hud.contentColor = [UIColor blackColor];
    
    return hud;
}

+ (instancetype)showLoadingWithMessage:(NSString *)message {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    if (message && message.length>0) {
        hud.label.text = message;
    }
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (instancetype)showLoadingProgress {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (void)hideLoadingHUD {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [MBProgressHUD hideHUDForView:window animated:YES];
}

+ (void)showSuccessAlertWithIcon:(NSString *)imageName message:(NSString *)message {
    [MBProgressHUD showSuccessAlertWithIcon:imageName message:message toView:nil afterDalay:kAfterDalayTime];
}

+ (void)showSuccessAlertWithIcon:(NSString *)imageName message:(NSString *)message toView:(UIView *)view afterDalay:(NSTimeInterval)dalay {
    if (nil == view) {
        view = [UIApplication sharedApplication].delegate.window;
    }
    MBProgressCustomView *customView = [[MBProgressCustomView alloc]initWithFrame:CGRectMake(0, 0, kAdapt(110), kAdapt(110))];
    UIImageView *icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    [customView addSubview:icon];
    UILabel *label = [[UILabel alloc]init];
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    [customView addSubview:label];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(customView.mas_centerX);
        make.top.equalTo(customView.mas_top).offset(kAdapt(24));
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(customView.mas_centerX);
        make.top.equalTo(icon.mas_bottom).offset(kAdapt(24));
    }];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    hud.customView = customView;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:dalay];
}


@end


@implementation MBProgressCustomView

- (CGSize)intrinsicContentSize {
    return CGSizeMake(kAdapt(110), kAdapt(110));
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.layer.cornerRadius = kAdapt(10);
    }
    return self;
}

@end

@implementation MBRecognizeGifView

- (CGSize)intrinsicContentSize {
    return CGSizeMake(kAdapt(180), kAdapt(180));
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.layer.cornerRadius = kAdapt(10);
    }
    return self;
}


@end
