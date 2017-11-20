//
//  HDHUD.m
//  hd_ios
//
//  Created by 邬志成 on 2017/8/16.
//  Copyright © 2017年 com.bandou.app.hdIos. All rights reserved.
//

#import "HDHUD.h"
//#import "PasswordField.h"
//#import "PasswordAlertView.h"
//#import "WZCSelectView.h"
//#import "LJMapCoordinateToCorrect.h"

@import MapKit;

@implementation HDHUD
//
//+ (HDHUD *)shareHUD{
//    static HDHUD *hud;
//    if (hud == nil) {
//        hud = [[HDHUD alloc] init];
//    }
//    return hud;
//}

+ (void)loadConfig{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD setMaximumDismissTimeInterval:2];
}

+ (void)show{
    [SVProgressHUD show];
}

+ (void)showInfoWithStatus:(NSString *)msg{
    [SVProgressHUD showInfoWithStatus:msg];
}

+ (void)showErrorWithStatus:(NSString *)msg{
    [SVProgressHUD showErrorWithStatus:msg];
}

+ (void)showWithStatus:(NSString *)msg{
    [SVProgressHUD showWithStatus:msg];
}

+ (void)showSuccessWithStatus:(NSString *)msg{
    [SVProgressHUD showSuccessWithStatus:msg];
}

+ (void)showProgress:(float)progress status:(NSString *)msg{
    [SVProgressHUD showProgress:progress status:msg];
}

+ (void)showProgress:(float)progress{
    [SVProgressHUD showProgress:(float)progress];
}

+ (void)dismiss{
    [SVProgressHUD dismiss];
}

+ (void)dismissWithCallBack:(SVProgressHUDDismissCompletion)callBack{
    [SVProgressHUD dismissWithCompletion:callBack];
}

+ (BOOL)isVisible{
    return [SVProgressHUD isVisible];
}

+ (void)showAlertWithTarget:(UIViewController *)target title:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel confirm:(NSString *)confirm cancelCallBack:(void(^)())cancelCallBack confirmCallBack:(void(^)())confirmCallBack{
    [HDHUD dismiss];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelCallBack!=nil) {
            cancelCallBack();
        }
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:confirm style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (confirmCallBack!=nil) {
            confirmCallBack();
        }
    }]];
    [target presentViewController:alertVC animated:true completion:nil];
}

+ (void)showAlertWithTarget:(UIViewController *)target title:(NSString *)title message:(NSString *)message{
    [self showAlertWithTarget:target title:title message:message cancel:nil confirm:nil cancelCallBack:nil confirmCallBack:nil];
}

//+ (void)showPaymentPasswordAlertWithTarget:(UIViewController *)target cancelCallBack:(void (^)())cancelCallBack confirmCallBack:(void (^)(NSString *value))confirmCallBack{
//    if ([HDHUD isVisible]) {
//        [HDHUD dismiss];
//    }
//    PasswordAlertView *alertView = [[PasswordAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.7f, kStaticRatio(130))];
//    alertView.didCancelInput = cancelCallBack;
//    alertView.didCompleteInput = ^(NSString *code) {
//        if (confirmCallBack) {
//            confirmCallBack(code);
//        }
//        [WZCSelectView dismiss];
//    };
//    [WZCSelectView setDismissOnTouchOther:false];
//    [WZCSelectView showView:alertView position:WZCSelectViewShowPositionStyleCenter didShow:^{
//        [alertView.pasField becomeFirstResponder];
//    }];
    //    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    //    __block PasswordField *pasFieldView;
    //    __weak typeof(alertVC) weekAlertVC = alertVC;
    //    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    //        textField.borderStyle = UITextBorderStyleNone;
    //        textField.hidden = true;
    //        textField.userInteractionEnabled = false;
    //
    //        PasswordField *field = [[PasswordField alloc] init];
    //        [weekAlertVC.view addSubview:field];
    //        pasFieldView = field;
    //        field.translatesAutoresizingMaskIntoConstraints = false;
    //        NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:field attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:weekAlertVC.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    //        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:field attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:weekAlertVC.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-50];
    //        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:field attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:38];
    //        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:field attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:44*6];
    //        [weekAlertVC.view addConstraints:@[centerX,width,height,bottom]];
    //        weekAlertVC.view.userInteractionEnabled = true;
    //        pasFieldView.userInteractionEnabled = true;
    //        pasFieldView.secureTextEntry = true;
    //        pasFieldView.DidCompleteInput = ^(NSString *code) {
    //            [weekAlertVC dismissViewControllerAnimated:true completion:^{
    //                [target.view endEditing:true];
    //                if (confirmCallBack) {
    //                    confirmCallBack(code);
    //                }
    //            }];
    //        };
    //    }];
    //
    //    if ([cancel bd_isValue]) {
    //        [alertVC addAction:[UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    //            if (cancelCallBack!=nil) {
    //                cancelCallBack(pasFieldView.text);
    //            }
    //        }]];
    //    }
    ////    if ([confirm bd_isValue] || ![cancel bd_isValue]) {//要保证有取消的按钮
    ////        if (![confirm bd_isValue]) {
    ////            confirm = @"确定";
    ////        }
    ////        [alertVC addAction:[UIAlertAction actionWithTitle:confirm style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    ////            if (confirmCallBack!=nil) {
    ////                confirmCallBack(pasFieldView.text);
    ////            }
    ////        }]];
    ////    }
    //    pasFieldView.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.937 alpha:1.00];
    //    [target presentViewController:alertVC animated:true completion:^{
    //        [pasFieldView becomeFirstResponder];
    //    }];
    
//}




@end
