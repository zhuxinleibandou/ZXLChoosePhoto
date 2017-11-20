//
//  MoreChooseCollectionViewCell.h
//  hd_ios
//
//  Created by 朱信磊 on 2017/8/23.
//  Copyright © 2017年 com.bandou.app.hdIos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoosePhotoCollectionViewCell.h"
#import "ChoosePhotoMethod.h"
@class MoreChooseCollectionViewCell;

@protocol MoreChooseCollectionViewCellDelegate <NSObject>

- (void)MoreChooseCollectionViewClickCell:(MoreChooseCollectionViewCell *)cell;

@end

@interface MoreChooseCollectionViewCell : ChoosePhotoCollectionViewCell
/**
 多选按钮状态
 */
@property (assign, nonatomic) BOOL sel_selected;

/**
 是否隐藏多选按钮
 */
@property (assign, nonatomic) BOOL moreChooseBtHidden;

@property (weak, nonatomic) id<MoreChooseCollectionViewCellDelegate> more_delegate;

@end
