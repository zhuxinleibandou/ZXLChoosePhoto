//
//  ChoosePhotoViewController.h
//  hd_ios
//
//  Created by 朱信磊 on 2017/8/3.
//  Copyright © 2017年 com.bandou.app.hdIos. All rights reserved.
//

#import <Photos/Photos.h>
#import "ChoosePhotoCollectionViewCell.h"
#import "ShowBigPhotoView.h"
#import "CusPickerView.h"
#import "ChoosePhotoViewController.h"
typedef NS_ENUM(NSUInteger, ChooseType) {
    ChooseTypeOne,      //单张选择
    ChooseTypeMore,     //多张选择
};

@interface ChoosePhotoViewController : UIViewController

@property (assign, nonatomic) ChooseType  chooseType;   //选择类型 默认单张

//选择单张照片回调   未设置选择类型，则默认回调
@property (strong, nonatomic)void(^ChoosePhotoBlockImage)(UIImage *selImg);

//选择多张照片  chooseType = ChooseTypeMore  会回调此方法
@property (strong, nonatomic)void(^ChooseArrayPhotoBlockImages)(NSMutableArray *aryImages);

//最大选择照片数
@property (assign, nonatomic) NSInteger     maxImagesCount;

@end
