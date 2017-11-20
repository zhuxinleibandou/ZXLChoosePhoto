//
//  CameraView.h
//  hd_ios
//
//  Created by 朱信磊 on 2017/8/3.
//  Copyright © 2017年 com.bandou.app.hdIos. All rights reserved.
//

#import "BaseView.h"

@interface CameraView : UIView

/**
 初始化界面
 */
- (void)initView;
//关闭
@property (copy, nonatomic)void(^Backblock)();

/**
 转换摄像头
 */
@property (copy, nonatomic)void(^ChangeCameraBlock)();

/**
 拍照
 */
@property (copy, nonatomic) void(^ClickActionBlock)();

@end
