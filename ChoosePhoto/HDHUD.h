//
//  HDHUD.h
//  hd_ios
//
//  Created by 邬志成 on 2017/8/16.
//  Copyright © 2017年 com.bandou.app.hdIos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDHUD : NSObject


+ (void)show;
+ (void)showInfoWithStatus:(NSString *)msg;
+ (void)showErrorWithStatus:(NSString *)msg;
+ (void)showWithStatus:(NSString *)msg;
+ (void)showSuccessWithStatus:(NSString *)msg;
+ (void)showProgress:(float)progress status:(NSString *)msg;
+ (void)showProgress:(float)progress;
+ (void)dismiss;
+ (void)dismissWithCallBack:(SVProgressHUDDismissCompletion)callBack;
+ (BOOL)isVisible;

+ (void)loadConfig;

/**
 显示一个提示框

 @param target 控制器
 @param title 标题
 @param message 内容
 @param cancel 取消按钮
 @param confirm 确定按钮
 @param cancelCallBack 取消回调
 @param confirmCallBack 确定回调
 */
+ (void)showAlertWithTarget:(UIViewController *)target title:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel confirm:(NSString *)confirm cancelCallBack:(void(^)())cancelCallBack confirmCallBack:(void(^)())confirmCallBack;


///**
// 显示一个提示框
//
// @param target 控制器
// @param title 标题
// @param message 内容
// */
//+ (void)showAlertWithTarget:(UIViewController *)target title:(NSString *)title message:(NSString *)message;

//
///**
// 显示输入支付密码的对话框
//
// @param target target description
// @param cancelCallBack cancelCallBack description
// @param confirmCallBack confirmCallBack description
// */
//+ (void)showPaymentPasswordAlertWithTarget:(UIViewController *)target cancelCallBack:(void (^)())cancelCallBack confirmCallBack:(void (^)(NSString *value))confirmCallBack;




@end
