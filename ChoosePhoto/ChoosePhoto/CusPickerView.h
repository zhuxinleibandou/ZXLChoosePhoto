//
//  CusPickerView.h
//  ePayProject
//
//  Created by 朱信磊 on 2017/11/16.
//  Copyright © 2017年 com.bandou.app.epay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CusPickerView : UIView

@property (strong, nonatomic) NSMutableArray    *aryTitles;

@property (copy, nonatomic )  void (^chooseBlock)(NSString *title,NSInteger row);

@property (copy, nonatomic)  NSString           *selTitle;

- (void)show;
@end
