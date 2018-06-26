//
//  PhotoTool.h
//  AppProject
//
//  Created by 朱信磊 on 2018/6/26.
//  Copyright © 2018年 com.bandou.app. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
@interface ChoosePhotoModel : NSObject
@property (nonatomic, copy) NSString *title; //相册名字
@property (nonatomic, assign) NSInteger count; //该相册内相片数量
@property (nonatomic, strong) PHAsset *headImageAsset; //相册第一张图片缩略图
@property (nonatomic, strong) PHAssetCollection *assetCollection; //相册集，通过该属性获取该相册集下所有照片
@end


@interface PhotoTool : NSObject
+ (instancetype)sharePhotoTool;
/**
 * @brief 保存图片到系统相册
 */
- (void)saveImageToAblum:(UIImage *)image completion:(void (^)(BOOL suc, PHAsset *asset))completion;


/**
 获取用户所有相册列表

 @return 数组
 */
- (NSMutableArray<ChoosePhotoModel *> *)getPhotoAblumList;

/**
 获取相册内所有图片资源

 @param ascending  是否按创建时间正序排列 YES,创建时间正（升）序排列; NO,创建时间倒（降）序排列
 @return 数组
 */
- (NSMutableArray<PHAsset *> *)getAllAssetInPhotoAblumWithAscending:(BOOL)ascending;


/**
 获取指定相册内的图片资源

 @param ascending 是否按创建时间正序排列 YES,创建时间正（升）序排列; NO,创建时间倒（降）序排列
 @param collection 指定相册
 @return 数组
 */
- (NSMutableArray<PHAsset *> *)getAllAssetInPhotoAblumWithAscending:(BOOL)ascending withCollection:(PHAssetCollection *)collection;


/**
 * @brief 获取每个Asset对应的图片
 */
- (void)requestImageForAsset:(PHAsset *)asset size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void (^)(UIImage *image, NSDictionary *info))completion;


/**
 * @brief 点击确定时，获取每个Asset对应的图片（imageData）
 */
- (void)requestImageForAsset:(PHAsset *)asset scale:(CGFloat)scale resizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void (^)(UIImage *image))completion;



/**
 * @brief 判断图片是否存储在本地/或者已经从iCloud上下载到本地
 */
- (BOOL)judgeAssetisInLocalAblum:(PHAsset *)asset ;
@end
