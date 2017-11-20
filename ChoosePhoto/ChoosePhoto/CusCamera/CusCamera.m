//
//  CusCamera.m
//  hd_ios
//
//  Created by 朱信磊 on 2017/8/3.
//  Copyright © 2017年 com.bandou.app.hdIos. All rights reserved.
//

#import "CusCamera.h"
#import <AVFoundation/AVFoundation.h>

//NSString  *const videoDir = @"videoDir";

static CusCamera *manager;

@interface CusCamera ()<AVCaptureFileOutputRecordingDelegate>
//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property (nonatomic, strong) AVCaptureDevice *device;

//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property (nonatomic, strong) AVCaptureDeviceInput *input;

//输出图片
@property (nonatomic ,strong) AVCaptureStillImageOutput *imageOutput;

//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property (nonatomic, strong) AVCaptureSession *session;

//图像预览层，实时显示捕获的图像
//@property (nonatomic ,strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (assign, nonatomic)VideoCameraType type;
@end

@implementation CusCamera

+ (instancetype)shareManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[CusCamera alloc]init];
        [manager initDevice];
        [manager initSession];
    });
    return manager;
}
/**
 初始化设备
 */
-(void)initDevice{
    //创建视屏设备
    
    self.device = [self cameraWithPosition:_type==VideoCameraTypeBefore?AVCaptureDevicePositionFront:AVCaptureDevicePositionBack];
    
     self.input = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];
    
    self.imageOutput = [[AVCaptureStillImageOutput alloc] init];
    
}

//根据前后置位置拿到相应的摄像头：
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ){
            return device;
        }
    return nil;
}

/**
 初始化session
 */
- (void)initSession{
    //初始化session
    self.session = [[AVCaptureSession alloc] init];
    //     拿到的图像的大小可以自行设定
    //    AVCaptureSessionPreset320x240
    //    AVCaptureSessionPreset352x288
    //    AVCaptureSessionPreset640x480
    //    AVCaptureSessionPreset960x540
    //    AVCaptureSessionPreset1280x720
    //    AVCaptureSessionPreset1920x1080
    //    AVCaptureSessionPreset3840x2160
//    self.session.sessionPreset = AVCaptureSessionPreset640x480;
    //输入输出设备结合
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.imageOutput]) {
        [self.session addOutput:self.imageOutput];
    }
  
}

- (void)bd_StartRuningInView:(UIView *)view andLayerFrame:(CGRect)frame{
    //创建预览图层
    //预览层的生成
    AVCaptureVideoPreviewLayer *preLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
//    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    //设备取景开始
//    [self.session startRunning];
//    if ([_device lockForConfiguration:nil]) {
//        //自动闪光灯，
//        if ([_device isFlashModeSupported:AVCaptureFlashModeAuto]) {
//            [_device setFlashMode:AVCaptureFlashModeAuto];
//        }
//        //自动白平衡,但是好像一直都进不去
//        if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
//            [_device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
//        }
//        [_device unlockForConfiguration];
//    }
    
    //设置图层大小
    preLayer.frame = frame;
    
    //添加到指定的view上
    [view.layer addSublayer:preLayer];
    
    [_session startRunning];
}
 
//切换摄像头
- (void)bd_changeCurrentCameraType{
    if (_type==VideoCameraTypeBefore) {
        //后置摄像头
        _type = VideoCameraTypeAfter;
    }else{
        _type = VideoCameraTypeBefore;
    }
    //初始化设备、session
    [manager initDevice];
    [manager initSession];
}

- (void)photoBtnDidClick
{
    AVCaptureConnection *conntion = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!conntion) {
        NSLog(@"拍照失败!");
        return;
    }

   [self.imageOutput captureStillImageAsynchronouslyFromConnection:conntion completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
       if (imageDataSampleBuffer == nil) {
           return ;
       }
       NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
       UIImage *image= [UIImage imageWithData:imageData];
       [self.session stopRunning];
       if (_delegate && [_delegate respondsToSelector:@selector(CusCameraClickPhotoWithImage:)]) {
           [_delegate CusCameraClickPhotoWithImage:image];
       }
   }];
}

@end
