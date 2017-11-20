//
//  ShowBigPhotoView.m
//  hd_ios
//
//  Created by 朱信磊 on 2017/8/3.
//  Copyright © 2017年 com.bandou.app.hdIos. All rights reserved.
//

#import "ShowBigPhotoView.h"
#import <Photos/Photos.h>
#import "ChoosePhotoMethod.h"

@interface ShowBigPhotoView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *mainView; // 显示图片的collectionView

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;



@end

@implementation ShowBigPhotoView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    // 设置显示图片的collectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = self.frame.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[ImagesScrollowCollectionViewCell class] forCellWithReuseIdentifier:@"ShowBigPhotoView"];
    mainView.dataSource = self;
    mainView.delegate = self;
    [self addSubview:mainView];
    _mainView = mainView;
    
    _bt_back = [[UIButton alloc]init];
    [_bt_back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_bt_back];
    
    _bt_sure = [[UIButton alloc]init];
    [_bt_sure addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_bt_sure];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _mainView.frame = self.bounds;
    float bt_width = kHeight(80);
    float bt_space = (kGetWidth(self.frame) - bt_width*2)/4;
    [_bt_back setFrame:CGRectMake(bt_space, kGetHeigh(self.frame) - bt_width-bt_space, bt_width, bt_width)];
    [_bt_back setImage:[UIImage imageNamed:[kimageBundle stringByAppendingPathComponent:@"btn_remake_normal-1"]] forState:UIControlStateNormal];
    [_bt_back setImage:[UIImage imageNamed:[kimageBundle stringByAppendingPathComponent:@"btn_remake_pressed"]] forState:UIControlStateHighlighted];
    [_bt_sure setFrame:CGRectMake(kGetWidth(self.frame) - bt_space - bt_width, kGetHeigh(self.frame) - bt_width - bt_space, bt_width, bt_width)];
    [_bt_sure setImage:[UIImage imageNamed:[kimageBundle stringByAppendingPathComponent:@"btn_greensure_normal-1"]] forState:UIControlStateNormal];
    [_bt_sure setImage:[UIImage imageNamed:[kimageBundle stringByAppendingPathComponent:@"btn_greensure_pressed-1"]] forState:UIControlStateHighlighted];
}

- (void)setAryImages:(NSMutableArray *)aryImages{
    _aryImages = aryImages;
    [_mainView reloadData];
    if (_mainView.contentOffset.x == 0 &&  _index!=0) {
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _aryImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImagesScrollowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShowBigPhotoView" forIndexPath:indexPath];
    id obj = [self.aryImages objectAtIndex:indexPath.row];
    
    //是否是图片对象
    if ([obj isKindOfClass:[PHAsset class]]) {
        PHAsset *asset = [self.aryImages objectAtIndex:indexPath.row];
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.networkAccessAllowed = YES;
        //解析缩略图
        [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
            //解析出来的图片
            [cell.imageView setImage:image];
            BDLog(@"%@",info);
        }];
        
    }else{
        cell.imageView.image =[self.aryImages objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  
}


- (void)backAction{
    self.BackActionBlock();
}

-(void)sureAction{
    NSInteger row = [[_mainView indexPathsForVisibleItems] firstObject].row;
    BDLog(@"%ld",row);
    ImagesScrollowCollectionViewCell *cell = (ImagesScrollowCollectionViewCell *)[_mainView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    UIImage *img = cell.imageView.image;
    if (self.SureActionBlock) {
       self.SureActionBlock(img);
    }
    
}

@end
