//
//  CameraView.m
//  hd_ios
//
//  Created by 朱信磊 on 2017/8/3.
//  Copyright © 2017年 com.bandou.app.hdIos. All rights reserved.
//

#import "CameraView.h"

@interface  CameraView()

/**
 开始
 */
@property (strong, nonatomic)UIButton *btStart;


@end

@implementation CameraView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)initView{
    float offset_x = 0.0f;
    float offset_y = 0.0f;
    UIView *top = [[UIView alloc]initWithFrame:CGRectMake(offset_x,offset_y, self.frame.size.width, kHeight(60))];
    [top setBackgroundColor:[UIColor clearColor]];
    [self addSubview:top];
    {
        float offset_xx= kHeight(5);
        float offset_yy = kHeight(20);
        {
            UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(offset_xx, offset_yy, kHeight(60), kHeight(55))];
            [back setImage:[UIImage imageNamed:[kimageBundle stringByAppendingPathComponent:@"ic_delete"]] forState:UIControlStateNormal];
            [back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
            [top addSubview:back];
        }
        {
            UIButton *change = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(top.frame)-kHeight(55)-kHeight(10),offset_yy, kHeight(60), kHeight(55))];
            [change setImage:[UIImage imageNamed:[kimageBundle stringByAppendingPathComponent:@"Post_icon_switchCamera"]] forState:UIControlStateNormal];
            [change addTarget:self action:@selector(changeAction) forControlEvents:UIControlEventTouchUpInside];
            [top addSubview:change];
        }
    }

    {
        UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.frame)-kHeight(50)/2, CGRectGetMidY(self.frame)+ CGRectGetMidY(self.frame)/2-kHeight(50)/2, kHeight(50), kHeight(50))];
        [bt setImage:[UIImage imageNamed:[kimageBundle stringByAppendingPathComponent:@"Post_icon_record"]] forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(ClickAction) forControlEvents:UIControlEventTouchUpInside];
        [bt.layer setBorderColor:[UIColor whiteColor].CGColor];
        [bt.layer setBorderWidth:3];
        [bt.layer setMasksToBounds:YES];
        [bt.layer setCornerRadius:bt.frame.size.height/2];
        [self addSubview:bt];
        _btStart = bt;
    }

}


-(void)backAction{
    self.Backblock();
}

-(void)changeAction{
    self.ChangeCameraBlock();
}

-(void)ClickAction{
    self.ClickActionBlock();
}

@end
