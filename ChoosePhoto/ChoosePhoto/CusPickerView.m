//
//  CusPickerView.m
//  ePayProject
//
//  Created by 朱信磊 on 2017/11/16.
//  Copyright © 2017年 com.bandou.app.epay. All rights reserved.
//

#import "CusPickerView.h"
#import "ChoosePhotoMethod.h"

@interface CusPickerView () <UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIButton *bt_cancel;
    
    UIButton *bt_sure;
    
    NSString *selStr;
    
    NSInteger selRow;
}
@property (strong, nonatomic) UIPickerView *picker;

@property (strong, nonatomic) UIView        *bgView;

@end

@implementation CusPickerView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        //确定
        bt_sure = [[UIButton alloc]initWithFrame:CGRectMake(kGetWidth(self.frame) - kHeight(50), 0, kHeight(50), kHeight(50))];
        [bt_sure setTitle:@"确定" forState:UIControlStateNormal];
        [bt_sure setTitleColor:kColor(0x444444ff) forState:UIControlStateNormal];
        [bt_sure.titleLabel setFont:kFont(15)];
        [bt_sure addTarget:self action:@selector(clickSureAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bt_sure];
        //取消
        bt_cancel = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kHeight(50), kHeight(50))];
        [bt_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [bt_cancel setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [bt_cancel.titleLabel setFont:kFont(15)];
        [bt_cancel addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bt_cancel];
        
        _picker= [[UIPickerView alloc]initWithFrame:CGRectMake(0, kHeight(50), kGetWidth(self.frame), kGetHeigh(self.frame)- kHeight(50))];
        [_picker setBackgroundColor:[UIColor whiteColor]];
        _picker.delegate = self;
        _picker.dataSource = self;
        [self addSubview:_picker];
    }
    return self;
}

#pragma mark - 确定
- (void)clickSureAction{
    if (_chooseBlock) {
        _chooseBlock(selStr,selRow);
    }
    [self Close];
}

#pragma mark - 取消
- (void)clickCancelAction{
    [self Close];
}

- (void)show{
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    [_bgView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
    [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(Close)]];
    [_bgView addSubview:self];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:_bgView];
    
    [_picker reloadAllComponents];
    [_picker selectRow:selRow inComponent:0 animated:YES];
}

- (void)setAryTitles:(NSMutableArray *)aryTitles{
    _aryTitles = aryTitles;
}

- (void)setSelTitle:(NSString *)selTitle{
    _selTitle = selTitle;
    selStr = _selTitle;
    [_aryTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *str = (NSString *)obj;
        if ([_selTitle isEqualToString:str]) {
            selRow = idx;
        }
    }];
}

- (void)Close{
    [_bgView removeFromSuperview];
    _bgView = nil;
    [self removeFromSuperview];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return  _aryTitles.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *string = [_aryTitles objectAtIndex:row];
    return string;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    selStr = [_aryTitles objectAtIndex:row];
    selRow = row;
//    if (_chooseBlock) {
//        _chooseBlock(string,row);
//    }
}


- (void)dealloc{
    BDLog(@"释放pickerView");
}

@end
