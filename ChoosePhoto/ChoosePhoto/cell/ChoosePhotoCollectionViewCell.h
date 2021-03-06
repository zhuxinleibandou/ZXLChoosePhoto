//
//  ChoosePhotoCollectionViewCell.h
//  hd_ios
//
//  Created by 朱信磊 on 2017/8/3.
//  Copyright © 2017年 com.bandou.app.hdIos. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ChoosePhotoCollectionViewCell;

@protocol ChoosePhotoCollectionViewCellDelegate <NSObject>

- (void)ChoosePhotoCollectionViewCell:(ChoosePhotoCollectionViewCell *)cell;

@end


@interface ChoosePhotoCollectionViewCell : UICollectionViewCell


@property (strong, nonatomic) UIImageView *imgVC;

@property (weak, nonatomic) id<ChoosePhotoCollectionViewCellDelegate> delegate;




@end
