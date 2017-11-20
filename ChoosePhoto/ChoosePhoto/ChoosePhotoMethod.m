//
//  ChoosePhotoMethod.m
//  ePayProject
//
//  Created by 朱信磊 on 2017/11/16.
//  Copyright © 2017年 com.bandou.app.epay. All rights reserved.
//

#import "ChoosePhotoMethod.h"

static ChoosePhotoMethod *manager;

@interface ChoosePhotoMethod ()

@end

@implementation ChoosePhotoMethod

+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ChoosePhotoMethod alloc]init];
    });
    return manager;
}

- (NSString *)transformAblumTitle:(NSString *)title
{
    if ([title isEqualToString:@"Slo-mo"]) {
        return @"慢动作";
    } else if ([title isEqualToString:@"Recently Added"]) {
        return @"最近添加";
    } else if ([title isEqualToString:@"Favorites"]) {
        return @"最爱";
    } else if ([title isEqualToString:@"Recently Deleted"]) {
        return @"最近删除";
    } else if ([title isEqualToString:@"Videos"]) {
        return @"视频";
    } else if ([title isEqualToString:@"All Photos"]) {
        return @"所有照片";
    } else if ([title isEqualToString:@"Selfies"]) {
        return @"自拍";
    } else if ([title isEqualToString:@"Screenshots"]) {
        return @"屏幕快照";
    } else if ([title isEqualToString:@"Camera Roll"]) {
        return @"相机胶卷";
    }
    return title;
}


- (UIImage *)bd_imageScaleToSize:(UIImage *)image inSize:(CGSize)size{
    CGSize scaledSize = [self GetScaleForProportionalResize:image.size intoSize:size];
    //    NSLog(@"primal w=%f, h=%f, scaled w=%f, h=%f", image.size.width, image.size.height, scaledSize.width, scaledSize.height);
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(scaledSize);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, scaledSize.width, scaledSize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}


- (CGSize)GetScaleForProportionalResize:(CGSize)imgSize intoSize:(CGSize)intoSize
{
    float sx = imgSize.width;
    float sy = imgSize.height;
    float dx = intoSize.width;
    float dy = intoSize.height;
    float scale = 1;
    if( sx != 0 && sy != 0 ){
        float scaleX = dx/sx;
        float scaleY = dy/sy;
        scale = scaleX<scaleY ? scaleX : scaleY;
    }
    return CGSizeMake(sx*scale, sy*scale);
}
@end
