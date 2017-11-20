//
//  CusCamera.h
//  hd_ios
//
//  Created by 朱信磊 on 2017/8/3.
//  Copyright © 2017年 com.bandou.app.hdIos. All rights reserved.
//

#import "BaseView.h"
typedef enum : NSUInteger {
    VideoCameraTypeBefore,      //前置摄像头
    VideoCameraTypeAfter,       //后置摄像头
} VideoCameraType;

@protocol CusCameraDelegate <NSObject>

- (void)CusCameraClickPhotoWithImage:(UIImage *)image;

@end

@interface CusCamera : BaseView

+ (instancetype)shareManager;

@property (weak, nonatomic) id<CusCameraDelegate> delegate;


- (void)bd_StartRuningInView:(UIView *)view andLayerFrame:(CGRect)frame;
/**
 转换当前摄像头类型
 
 @discussion
 AVMediaTypeAudio
 */
- (void)bd_changeCurrentCameraType;

//拍照按钮
- (void)photoBtnDidClick;


@end
