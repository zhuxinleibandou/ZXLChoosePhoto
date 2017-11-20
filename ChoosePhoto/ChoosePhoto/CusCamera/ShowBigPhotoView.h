//
//  ShowBigPhotoView.h
//  hd_ios
//
//  Created by 朱信磊 on 2017/8/3.
//  Copyright © 2017年 com.bandou.app.hdIos. All rights reserved.
//

#import "BaseView.h"
#import "ImagesScrollowCollectionViewCell.h"
@interface ShowBigPhotoView : BaseView
//返回
@property (strong, nonatomic)UIButton *bt_back;

//确认
@property (strong, nonatomic)UIButton   *bt_sure;

//图片数组(多张或单张) 支持PHAsset 和 image
@property (strong, nonatomic) NSMutableArray    *aryImages;

/**
 初始位置
 */
@property (assign, nonatomic) NSInteger     index;

//返回
@property (copy, nonatomic)void(^BackActionBlock)();
//确认
@property (copy, nonatomic)void(^SureActionBlock)(UIImage *image);

@end
