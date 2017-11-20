//
//  ChoosePhotoMethod.h
//  ePayProject
//
//  Created by 朱信磊 on 2017/11/16.
//  Copyright © 2017年 com.bandou.app.epay. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kimageBundle        [[NSBundle mainBundle] pathForResource:@"CusCameraIcon" ofType:@"bundle"]

#pragma mark - 通用宏定义
//获取手机屏幕大小
#define kFullScreen [[UIScreen mainScreen] bounds]
//获取手机屏幕尺寸
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
//判断是否是ipad
#define kIsIPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//判断是否是iphone
#define kIsIPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否是视网膜屏
#define kIsRetina ([[UIScreen mainScreen] scale] >= 2.0)
//手机的型号判断
#define kIsIPhone_4 (kIsIPhone && kFullScreen.size.width < 568.0)
#define kIsIPhone_5 (kIsIPhone && kFullScreen.size.width == 568.0)
#define kIsIPhone_6 (kIsIPhone && kFullScreen.size.width == 667.0)
#define kIsIPhone_6P (kIsIPhone && kFullScreen.size.width == 736.0)
//颜色16进制转换
#define kColor(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0 green:((c>>16)&0xFF)/255.0 blue:((c>>8)&0xFF)/255.0 alpha:((c)&0xFF)/255.0]
//字体大小适配
#define kFont(x) [UIFont systemFontOfSize:((kIsIPhone_4 || kIsIPhone_5)?(x - 1):(kIsIPhone_6P?(x + 1):x))]
#define kFontBold(x) [UIFont boldSystemFontOfSize:((kIsIPhone_4 || kIsIPhone_5)?(x - 1):(kIsIPhone_6P?(x + 1):x))]
#define KFontSize(x) (kIsIPhone_4 || kIsIPhone_5)?(x - 1):(kIsIPhone_6P?(x + 1):x)
//5&6&6+适配 K_STATIC_RATIO
#define kStaticRatio(x)  (kIsIPhone?((kFullScreen.size.height<=568.f?1.f:(kFullScreen.size.height/568.f))*x):((kFullScreen.size.height<=1024.f?1.2f:(kFullScreen.size.height/1024.0f)+0.2)*x))
//页面尺寸适配
#define kHeight(x) x*kFullScreen.size.width/375
//导航高
#define kTabBarHeight 64.0f
//底部tab导航高
#define kBottomHeight 49.0f
//基础线颜色
#define kLineColor kColor(0x949494FF)
//基础线高
#define kLineHeight (1 / [UIScreen mainScreen].scale)
//当前build号
#define kAppBuild     ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])
//当前版本号
#define kVersion   ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
//系统版本
#define kSystemVersion [[[UIDevice currentDevice] systemVersion]floatValue]
//获取沙盒Document路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒temp路径
#define kTempPath NSTemporaryDirectory()
//获取沙盒Cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
//DisPatch延迟时间
#define KDisPatchTimeSecond(s) dispatch_time(DISPATCH_TIME_NOW, s*NSEC_PER_SEC)
// 获取Appdelegate对象
#define KAppdelegate    (AppDelegate *)[[UIApplication sharedApplication] delegate]

#define kNavigation [((AppDelegate *)[[UIApplication sharedApplication] delegate]) navigationController]
//开发的时候打印，但是发布的时候不打印的NSLog  方法名  行号
#ifndef __OPTIMIZE__
#define BDLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define BDLog(...)
#endif
#define DefineWeakSelf __weak __typeof(self) weakSelf = self
//获取宽
#define kGetWidth(s)     CGRectGetWidth(s)
//获取高
#define kGetHeigh(s)     CGRectGetHeight(s)

@interface ChoosePhotoMethod : NSObject

+ (instancetype)shareManager;

- (NSString *)transformAblumTitle:(NSString *)title;


- (UIImage *)bd_imageScaleToSize:(UIImage *)image inSize:(CGSize)size;

@end



