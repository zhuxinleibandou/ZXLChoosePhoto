//
//  ChoosePhotoViewController.m
//  hd_ios
//
//  Created by 朱信磊 on 2017/8/3.
//  Copyright © 2017年 com.bandou.app.hdIos. All rights reserved.
//

#import "ChoosePhotoViewController.h"
#import "CameraView.h"
#import "CusCamera.h"
#import "MoreChooseCollectionViewCell.h"
#import "PhotoTool.h"

static NSString *const indentify = @"photolibraryidentify";
static NSString *const ChooseMoreImagesCell = @"ChooseMoreImagesCell";


@interface ChoosePhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PHPhotoLibraryChangeObserver,ChoosePhotoCollectionViewCellDelegate,MoreChooseCollectionViewCellDelegate,CusCameraDelegate>
{
    
    float bt_rec_item_width;
    //已选择的图片索引
    NSMutableArray *arySelImgIndex ;
    //当前选中的相册集
    ChoosePhotoModel   *_selPhotoModel;
    
    UIView      *_titlView;
}

@property (strong, nonatomic)     UIButton    *btTitle;

@property (strong, nonatomic) CusPickerView    *pickerView;

@property (strong, nonatomic) UICollectionView *collect;

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayou;

//拍照界面
@property (strong, nonatomic) CameraView *cameraView;
//显示照片界面
@property (strong, nonatomic) ShowBigPhotoView  *showImageView;
//所有相册照片数组
@property (strong, nonatomic) NSMutableArray<PHAsset *>  *ary_datas;

//选中的多张照片数组
@property (strong, nonatomic) NSMutableArray  *ary_selPhotos;

/**
 所有相册集对象数组
 */
@property (strong, nonatomic)  NSMutableArray<ChoosePhotoModel *> *photoAblumList;

@end

@implementation ChoosePhotoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self initPhotoFramework]) {
        _photoAblumList = [[NSMutableArray alloc] init];
        /** 当前用户允许app访问相册*/
        _photoAblumList = [[PhotoTool sharePhotoTool] getPhotoAblumList];
        [self.navigationController.view addSubview:[self headerView]];
    }
    if (_chooseType==ChooseTypeOne) {
        [_collect registerClass:[ChoosePhotoCollectionViewCell class] forCellWithReuseIdentifier:indentify];
        [_collect registerClass:[ChoosePhotoCollectionViewCell class] forCellWithReuseIdentifier:@"iconPhoto"];
    }else{
        [_collect registerClass:[MoreChooseCollectionViewCell class] forCellWithReuseIdentifier:ChooseMoreImagesCell];
        [_collect registerClass:[MoreChooseCollectionViewCell class] forCellWithReuseIdentifier:@"iconPhoto"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_titlView removeFromSuperview];
    _titlView = nil;
}

- (void)loadView{
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    float offset_y = 0.0f;
    bt_rec_item_width = (kGetWidth(self.view.frame)) / 4;
    UICollectionViewFlowLayout *layOutRec = [[UICollectionViewFlowLayout alloc]init];
    [layOutRec setScrollDirection:UICollectionViewScrollDirectionVertical];
    _flowLayou = layOutRec;
    [_flowLayou setItemSize:CGSizeMake(bt_rec_item_width, bt_rec_item_width)];
    
    _collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, offset_y, kGetWidth(self.view.frame), kGetHeigh(self.view.frame) - kTabBarHeight) collectionViewLayout:_flowLayou];
    [_collect setBackgroundColor:[UIColor clearColor]];
    [_collect setBounces:false];
    [_collect setDataSource:self];
    [_collect setDelegate:self];
    [self.view addSubview:_collect];
}

#pragma mark - 自定义头
- (UIView *)headerView{
    for (int i =0; i<_photoAblumList.count; i++) {
        ChoosePhotoModel *model = _photoAblumList[i];//获取相册集
        if (model.count > 0) {
            _selPhotoModel = model;
            break;
        }
    }
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(50, 24, kGetWidth(self.navigationController.view.bounds)-50*2, 44)];
    [v setBackgroundColor:[UIColor clearColor]];
    [v setUserInteractionEnabled:YES];
    _titlView = v;
    {
        float bt_w = kHeight(80);
        UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(0,0, bt_w, kGetHeigh(v.frame))];
        [bt setCenter:CGPointMake((v.frame.size.width)/2, kGetHeigh(v.bounds)/2)];
        [bt.titleLabel setFont:kFont(15)];
        [bt setTitle:_selPhotoModel.title forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [bt setBackgroundColor:[UIColor clearColor]];
        [bt setImage:[UIImage imageNamed:[kimageBundle stringByAppendingPathComponent:@"btn_down_normal"]] forState:UIControlStateNormal];
        [bt setTitleEdgeInsets:UIEdgeInsetsMake(0, -bt.imageView.intrinsicContentSize.width, 0, bt.imageView.intrinsicContentSize.width)];
        [bt setImageEdgeInsets:UIEdgeInsetsMake(0, bt.titleLabel.intrinsicContentSize.width, 0, -bt.titleLabel.intrinsicContentSize.width)];
        [bt addTarget:self
               action:@selector(chooseCollection) forControlEvents:UIControlEventTouchUpInside];
        _btTitle = bt;
        [v addSubview:bt];
    }
    //默认一个
    _ary_datas= [[PhotoTool sharePhotoTool] getAllAssetInPhotoAblumWithAscending:false withCollection:_selPhotoModel.assetCollection];
    [_collect reloadData];
    return v;
}

#pragma mark - 选择相册集
- (void)chooseCollection{
    NSMutableArray *aryTitle = [[NSMutableArray alloc]initWithCapacity:_photoAblumList.count];
    [_photoAblumList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ChoosePhotoModel *model = obj;
        BDLog(@"%@",model.title);
        [aryTitle addObject:model.title];
    }];
    
    CusPickerView *pick = self.pickerView;
    [pick setAryTitles:aryTitle];
    pick.chooseBlock = ^(NSString *title, NSInteger row) {
        _selPhotoModel =  _photoAblumList[row];
        _ary_datas= [[PhotoTool sharePhotoTool] getAllAssetInPhotoAblumWithAscending:false withCollection:_selPhotoModel.assetCollection];
        [_collect reloadData];
        [_ary_selPhotos removeAllObjects];
        [arySelImgIndex removeAllObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_btTitle setTitle:title forState:UIControlStateNormal];
            [_btTitle setTitleEdgeInsets:UIEdgeInsetsMake(0, -_btTitle.imageView.intrinsicContentSize.width, 0, _btTitle.imageView.intrinsicContentSize.width)];
            [_btTitle setImageEdgeInsets:UIEdgeInsetsMake(0, _btTitle.titleLabel.intrinsicContentSize.width, 0, -_btTitle.titleLabel.intrinsicContentSize.width)];
        });
    };
    [pick setSelTitle:_btTitle.titleLabel.text];
    [pick show];
}


- (CusPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[CusPickerView alloc]initWithFrame:CGRectMake(0, kGetHeigh(self.view.bounds) - kHeight(260) + kTabBarHeight, kGetWidth(self.view.bounds), kHeight(260))];
    }
    return _pickerView;
}


//判断是否有访问权限
- (BOOL )initPhotoFramework{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        BDLog(@"无访问权限");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"暂无访问相册权限，请在设置中开启" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
            //            [[HDUserDefine ShareManager]GoToAppSetting];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return false;
    }else{
        [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
        return YES;
    }
}


//相册变化回调
- (void)photoLibraryDidChange:(PHChange *)changeInstance
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // your codes
    });
}


//选择照片类型
- (void)setChooseType:(ChooseType)chooseType{
    _chooseType = chooseType;
    if (_chooseType==ChooseTypeMore) {
        _ary_selPhotos = [[NSMutableArray alloc]init];
        arySelImgIndex = [[NSMutableArray alloc]init];
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem  alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(SureChoose)]];
    }else{
        //单张
        [_ary_selPhotos removeAllObjects];
        [arySelImgIndex removeAllObjects];
    }
}

//多张图片 导航栏右上角显示 “确定”
- (void)SureChoose{
    NSMutableArray *ary_sel_images = [[NSMutableArray alloc]init];
    for (NSDictionary *value in _ary_selPhotos) {
        [ary_sel_images addObject:[value objectForKey:@"image"]];
    }
    if (self.ChooseArrayPhotoBlockImages) {
        self.ChooseArrayPhotoBlockImages(ary_sel_images);
    }
    [self GoBack];
}


/**
 返回上层vc
 */
- (void)GoBack{
    if (self.presentingViewController||!self.navigationController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}



#pragma mark - CollectionView DataSouth

//返回 item 之间的左右间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
//返回 section 的inset(上左下右边距)
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//返回 行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return kHeight(2);
}

//返回 section 数量
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return (_ary_datas.count+1);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_chooseType == ChooseTypeOne) {
        //单张
        if (indexPath.row==0) {
            ChoosePhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"iconPhoto" forIndexPath:indexPath];
            [cell.imgVC setImage:[UIImage imageNamed:[kimageBundle stringByAppendingPathComponent:@"icon_photo"]]];
            cell.delegate = self;
            return cell;
        }else{
            ChoosePhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];
            cell.delegate = self;
            CGSize size = cell.frame.size;
            size.width *= 2.5;
            size.height *= 2.5;
            
            PHAsset *asset = [_ary_datas objectAtIndex:indexPath.row-1];
            //解析缩略图
            [[PhotoTool sharePhotoTool] requestImageForAsset:asset size:size resizeMode:PHImageRequestOptionsResizeModeExact completion:^(UIImage *image, NSDictionary *info) {
                //解析出来的图片
                [cell.imgVC setImage:image];
            }];
            return cell;
        }
    }else{
        //多张
        if (indexPath.row==0) {
            MoreChooseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"iconPhoto" forIndexPath:indexPath];
            [cell.imgVC setImage:[UIImage imageNamed:[kimageBundle stringByAppendingPathComponent:@"icon_photo"]]];
            [cell setMoreChooseBtHidden:YES];
            cell.more_delegate = self;
            return cell;
        }else{
            MoreChooseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ChooseMoreImagesCell forIndexPath:indexPath];
            cell.more_delegate = self;
            [cell setMoreChooseBtHidden:false];
            [cell setSel_selected:false];
            PHAsset *asset = [_ary_datas objectAtIndex:indexPath.row-1];
            CGSize size = cell.frame.size;
            size.width *= 2.5;
            size.height *= 2.5;
            //解析缩略图
            [[PhotoTool sharePhotoTool] requestImageForAsset:asset size:size resizeMode:PHImageRequestOptionsResizeModeExact completion:^(UIImage *image, NSDictionary *info) {
                //解析出来的图片
                [cell.imgVC setImage:image];
                for (NSMutableDictionary *dict in _ary_selPhotos) {
                    PHAsset *obj = [dict valueForKey:@"phasset"];
                    if ([obj isEqual:asset]) {
                        [dict setValue:image forKey:@"image"];
                    }
                }
            }];
            for (NSNumber *selRow in arySelImgIndex) {
                if (selRow.intValue == indexPath.row) {
                    [cell setSel_selected:YES];
                }
            }
            return cell;
        }
    }
}

#pragma mark - 选择单张
- (void)ChoosePhotoCollectionViewCell:(ChoosePhotoCollectionViewCell *)cell{
    
    NSInteger row = [_collect indexPathForCell:cell].row;
    if (row==0) {
        BDLog(@"照相");
        [self initCarmera];
    }else{
        __weak typeof(self)weakSelf = self;
        //单张
        if (_chooseType == ChooseTypeOne) {
            //选中图片后 显示高清大图
            NSInteger row = [_collect indexPathForCell:cell].row;
            weakSelf.showImageView = [[ShowBigPhotoView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
            [weakSelf.showImageView setIndex:row-1];
            [ weakSelf.showImageView setAryImages:_ary_datas];
            //点击取消
            [ weakSelf.showImageView setBackActionBlock:^{
                //移除预览照片界面
                [weakSelf.showImageView removeFromSuperview];
                weakSelf.showImageView = nil;
            }];
            //点击确认
            [ weakSelf.showImageView setSureActionBlock:^(UIImage *image) {
                BDLog(@"选中的图片%@ ",image);
                //移除预览照片界面
                [weakSelf.showImageView removeFromSuperview];
                weakSelf.showImageView = nil;
                //回调单张照片
                if (weakSelf.ChoosePhotoBlockImage) {
                    //压缩图片
                    if (image.size.width>[[UIScreen mainScreen]bounds].size.width||image.size.height>[[UIScreen mainScreen]bounds].size.height) {
                        image= [[ChoosePhotoMethod shareManager]bd_imageScaleToSize:image inSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
                    }
                    weakSelf.ChoosePhotoBlockImage(image);
                }
                [weakSelf.navigationController popViewControllerAnimated:false];
            }];
            
            [[[UIApplication sharedApplication]keyWindow] addSubview: weakSelf.showImageView];
        }
    }
    
}

#pragma mark - 选择多张
- (void)MoreChooseCollectionViewClickCell:(MoreChooseCollectionViewCell *)cell{
    NSIndexPath *indexPath = [_collect indexPathForCell:cell];
    NSInteger row = indexPath.row;
    if (row==0) {
        BDLog(@"照相");
        [self initCarmera];
    }else{
        //选择多张
        NSInteger row = [_collect indexPathForCell:cell].row  ;
        id obj = [self.ary_datas objectAtIndex:row - 1];
        //是否是图片对象
        if ([obj isKindOfClass:[PHAsset class]]) {
            PHAsset *asset = (PHAsset *)obj;
            PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
            option.networkAccessAllowed = false;
            BOOL same = false;
            NSDictionary *selDict = nil;
            for (NSDictionary *obj in _ary_selPhotos) {
                if ([asset isEqual:[obj valueForKey:@"phasset"]]) {
                    same = true;
                    selDict = obj;
                    break;
                }
            }
            if (same) {
               [_ary_selPhotos removeObject:selDict];
               [arySelImgIndex removeObject:@(row)];
            }else{
                if (_maxImagesCount!=0 && _maxImagesCount <= _ary_selPhotos.count) {
                        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"最多上传%ld张照片!",_maxImagesCount]];
                        return;
                    }
                [_ary_selPhotos addObject:[[NSMutableDictionary alloc] initWithDictionary:@{@"phasset":asset,@"image":@""}]];
                [arySelImgIndex addObject:@(row)];
            }
             [_collect reloadItemsAtIndexPaths:@[indexPath]];
        }
        
    }
    
}

#pragma  mark - 初始化 拍照界面
- (void)initCarmera{
    [[CusCamera shareManager]bd_StartRuningInView:self.cameraView andLayerFrame:[[UIScreen mainScreen]bounds]];
    [self.cameraView initView];
    [[[UIApplication sharedApplication]keyWindow] addSubview:self.cameraView];
    
    __weak typeof(self) weakSelf = self;
    [_cameraView setBackblock:^{
        BDLog(@"关闭");
        [weakSelf.cameraView removeFromSuperview];
        weakSelf.cameraView = nil;
    }];
    [_cameraView setChangeCameraBlock:^{
        BDLog(@"转换");
        [[CusCamera shareManager]bd_changeCurrentCameraType];
        [weakSelf BDCameraViewClickClose];
        [weakSelf initCarmera];
    }];
    
    [_cameraView setClickActionBlock:^{
        BDLog(@"开始拍照");
        [CusCamera shareManager].delegate = weakSelf;
        [[CusCamera shareManager] photoBtnDidClick];
        
    }];
}


#pragma mark - CusCameraDelegate
-(void)CusCameraClickPhotoWithImage:(UIImage *)image{
    DefineWeakSelf;
    NSMutableArray *ary = [NSMutableArray arrayWithArray:[NSArray arrayWithObjects:image, nil]];
    BDLog(@"显示大图预览照片界面");
    self.showImageView = [[ShowBigPhotoView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [ self.showImageView setAryImages:ary];
    //点击取消
    [ weakSelf.showImageView setBackActionBlock:^{
        //初始化相机
        [weakSelf BDCameraViewClickClose];
        [weakSelf initCarmera];
        //移除预览照片界面
        [weakSelf.showImageView removeFromSuperview];
        weakSelf.showImageView = nil;
    }];
    //点击确定
    [ self.showImageView setSureActionBlock:^(UIImage *image) {
        BDLog(@"选中的图片%@",image);
        //保存到相册
        [weakSelf loadImageFinished:image];
        
    }];
    [[[UIApplication sharedApplication]keyWindow] addSubview: weakSelf.showImageView];
    
}

/**
 关闭拍照界面
 */
- (void)BDCameraViewClickClose{
    [_cameraView removeFromSuperview];
    _cameraView = nil;
}
//初始化拍照视图
-(UIView *)cameraView{
    if (_cameraView) {
        return _cameraView;
    }
    _cameraView = [[CameraView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    return _cameraView;
}


//保存图片到本地
- (void)loadImageFinished:(UIImage *)image
{
    NSMutableArray *imageIds = [NSMutableArray array];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        //写入图片到相册
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        //记录本地标识，等待完成后取到相册中的图片对象
        [imageIds addObject:req.placeholderForCreatedAsset.localIdentifier];
        
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        NSLog(@"success = %d, error = %@", success, error);
        
        UIImage *dealImag = image;
        //压缩图片
        if (dealImag.size.width>[[UIScreen mainScreen]bounds].size.width||dealImag.size.height>[[UIScreen mainScreen]bounds].size.height) {
            dealImag= [[ChoosePhotoMethod shareManager]bd_imageScaleToSize:dealImag inSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //移除预览照片界面
            [self.showImageView removeFromSuperview];
            self.showImageView = nil;
            BDLog(@"关闭");
            [self.cameraView removeFromSuperview];
            self.cameraView = nil;
            
            [self GoBack];
            //回调照片
            if (self.ChoosePhotoBlockImage) {
                self.ChoosePhotoBlockImage(dealImag);
            }
            //回调多张照片
            if (self.ChooseArrayPhotoBlockImages) {
                NSMutableArray *ary = [[NSMutableArray alloc]initWithArray:@[dealImag]];
                self.ChooseArrayPhotoBlockImages(ary);
            }
            
        });
    }];
}

- (void)dealloc{
    BDLog(@"控制器被释放");
}

@end
