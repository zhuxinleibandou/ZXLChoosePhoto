//
//  IndexViewController.m
//  ePayProject
//
//  Created by 朱信磊 on 2017/11/14.
//  Copyright © 2017年 com.bandou.app.epay. All rights reserved.
//

#import "IndexViewController.h"
#import "ChoosePhotoViewController.h"

#define kHomeHeaderViewHeight 220

@interface IndexViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *hotView;
@property (nonatomic, weak) UIView *headerView;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat headerY = 0;
    headerY = ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) ? 64 : 0;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadView{
    [super loadView];
    [self.navigationItem setTitle:@"首页"];
    [self setupHeader];
}

- (void)setupHeader
{
    UIView *header = [[UIView alloc] init];
    header.frame = CGRectMake(0, 0, self.view.frame.size.width, kHomeHeaderViewHeight);
    header.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:header];
    _headerView = header;
    
    
    {
        UIButton *first = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, header.frame.size.width * 0.25, header.frame.size.height * 0.5)];
        [first setImage:[UIImage imageNamed:@"icon_index_housekeeping_10"] forState:UIControlStateNormal];
        [first setTitle:@"选单张" forState:UIControlStateNormal];
        [first.titleLabel setFont:kFont(14)];
        [first setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [first setTitleColor:kColor(0x444444ff) forState:UIControlStateHighlighted];
        [first setBackgroundColor:[UIColor whiteColor]];
        [first setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [first setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [first setTitleEdgeInsets:UIEdgeInsetsMake((kGetHeigh(first.bounds) - first.titleLabel.intrinsicContentSize.height ) /2 + first.imageView.intrinsicContentSize.height / 2 + (((kGetHeigh(first.bounds) - first.imageView.intrinsicContentSize.height - first.titleLabel.intrinsicContentSize.height)/2)/2), (kGetWidth(first.bounds) - first.titleLabel.intrinsicContentSize.width) / 2 - first.imageView.intrinsicContentSize.width, 0,0)];
        [first setImageEdgeInsets:UIEdgeInsetsMake((kGetHeigh(first.bounds) - first.imageView.intrinsicContentSize.height ) /2 - (((kGetHeigh(first.bounds) - first.imageView.intrinsicContentSize.height - first.titleLabel.intrinsicContentSize.height)/2)/2), (kGetWidth(first.bounds) - first.imageView.intrinsicContentSize.width)/2, 0, 0)];
        [first addTarget:self action:@selector(scanButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:first];
    }
    
    {
        UIButton *first = [[UIButton alloc] initWithFrame:CGRectMake(header.frame.size.width * 0.25, 0, header.frame.size.width * 0.25, header.frame.size.height * 0.5)];
        [first setImage:[UIImage imageNamed:@"icon_index_housekeeping_10"] forState:UIControlStateNormal];
        [first setTitle:@"选多张" forState:UIControlStateNormal];
        [first.titleLabel setFont:kFont(14)];
        [first setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [first setTitleColor:kColor(0x444444ff) forState:UIControlStateHighlighted];
        [first setBackgroundColor:[UIColor whiteColor]];
        [first setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [first setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [first setTitleEdgeInsets:UIEdgeInsetsMake((kGetHeigh(first.bounds) - first.titleLabel.intrinsicContentSize.height ) /2 + first.imageView.intrinsicContentSize.height / 2 + (((kGetHeigh(first.bounds) - first.imageView.intrinsicContentSize.height - first.titleLabel.intrinsicContentSize.height)/2)/2), (kGetWidth(first.bounds) - first.titleLabel.intrinsicContentSize.width) / 2 - first.imageView.intrinsicContentSize.width, 0,0)];
        [first setImageEdgeInsets:UIEdgeInsetsMake((kGetHeigh(first.bounds) - first.imageView.intrinsicContentSize.height ) /2 - (((kGetHeigh(first.bounds) - first.imageView.intrinsicContentSize.height - first.titleLabel.intrinsicContentSize.height)/2)/2), (kGetWidth(first.bounds) - first.imageView.intrinsicContentSize.width)/2, 0, 0)];
        [first addTarget:self action:@selector(chooseMore) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:first];
    }
}

- (void)scanButtonClicked{
    ChoosePhotoViewController *vc = [[ChoosePhotoViewController alloc]init];
    vc.ChoosePhotoBlockImage = ^(UIImage *img){
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)chooseMore{
    ChoosePhotoViewController *vc = [[ChoosePhotoViewController alloc]init];
    vc.chooseType = ChooseTypeMore;
    vc.maxImagesCount = 4;
    vc.ChooseArrayPhotoBlockImages = ^(NSMutableArray *aryImages) {
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}

@end
