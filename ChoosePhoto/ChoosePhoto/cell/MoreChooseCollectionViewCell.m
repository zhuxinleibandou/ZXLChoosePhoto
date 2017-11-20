//
//  MoreChooseCollectionViewCell.m
//  hd_ios
//
//  Created by 朱信磊 on 2017/8/23.
//  Copyright © 2017年 com.bandou.app.hdIos. All rights reserved.
//

#import "MoreChooseCollectionViewCell.h"

@interface MoreChooseCollectionViewCell ()

@property (strong, nonatomic) UIButton  *bt_selected;

@end

@implementation MoreChooseCollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];
        _bt_selected = [[UIButton alloc]init];
        [_bt_selected setUserInteractionEnabled:NO];
        
        [_bt_selected setImage:[UIImage imageNamed:[kimageBundle stringByAppendingPathComponent:@"btn_bluesure_normal"]] forState:UIControlStateNormal];
        [_bt_selected setImage:[UIImage imageNamed:[kimageBundle stringByAppendingPathComponent:@"btn_bluesure_selected"]] forState:UIControlStateSelected];
        [self.contentView addSubview:_bt_selected];
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    [_bt_selected setFrame:CGRectMake(kGetWidth(self.frame) - kHeight(30), kHeight(2), kHeight(25), kHeight(25))];
}

- (void)setSel_selected:(BOOL)sel_selected{
    _sel_selected = sel_selected;
    [_bt_selected setSelected:_sel_selected];
}
- (void)setMoreChooseBtHidden:(BOOL)moreChooseBtHidden{
    [_bt_selected setHidden:moreChooseBtHidden];
}

- (void)Click{
    if (_more_delegate && [_more_delegate respondsToSelector:@selector(MoreChooseCollectionViewClickCell:)]) {
        [_more_delegate MoreChooseCollectionViewClickCell:self];
    }
}


@end
