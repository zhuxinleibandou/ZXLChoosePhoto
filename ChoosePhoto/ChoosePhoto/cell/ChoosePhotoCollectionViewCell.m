//
//  ChoosePhotoCollectionViewCell.m
//  hd_ios
//
//  Created by 朱信磊 on 2017/8/3.
//  Copyright © 2017年 com.bandou.app.hdIos. All rights reserved.
//

#import "ChoosePhotoCollectionViewCell.h"

@interface ChoosePhotoCollectionViewCell ()


@end

@implementation ChoosePhotoCollectionViewCell


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];
        _imgVC = [[UIImageView alloc]init];
        [_imgVC.layer setMasksToBounds:YES];
        [_imgVC setUserInteractionEnabled:YES];
        [_imgVC setContentMode:UIViewContentModeScaleAspectFill];
        [_imgVC addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Click)]];
        [self.contentView addSubview:_imgVC];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    float offset_x = 0.0f;
    float offset_y = 0.0f;
    [_imgVC setFrame:CGRectMake(offset_x, offset_y, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame))];

}


- (void)Click{
    if (_delegate && [_delegate respondsToSelector:@selector(ChoosePhotoCollectionViewCell:)]) {
        [_delegate ChoosePhotoCollectionViewCell:self];
    }
}

@end
