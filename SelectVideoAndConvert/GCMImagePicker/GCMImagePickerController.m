//
//  GCMImagePickerController.m
//  SelectMediumFile
//
//  Created by macavilang on 16/6/28.
//  Copyright © 2016年 Snoopy. All rights reserved.
//

#import "GCMImagePickerController.h"
#import "GCMAssetsGroupController.h"

@interface GCMImagePickerController ()

@property (nonatomic,strong) GCMAssetsGroupController *assetsGroupVC;

@end

@implementation GCMImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (instancetype)init{
    
    if (self = [super initWithRootViewController:self.assetsGroupVC]) {
        UINavigationBar *navBar = [UINavigationBar appearance];
        //导航条背景色
        navBar.barTintColor = [UIColor redColor];
        
    }
    return self;
}


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    return  [self init];
}
- (GCMAssetsGroupController *)assetsGroupVC{
    if (_assetsGroupVC == nil) {
        _assetsGroupVC = [[GCMAssetsGroupController alloc] init];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"选择相册";
        titleLabel.font = [UIFont systemFontOfSize:22];
        [titleLabel sizeToFit];
        _assetsGroupVC.navigationItem.titleView = titleLabel;
        
        
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        [backButton setTitle:@" 返回" forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        
        _assetsGroupVC.navigationItem.leftBarButtonItem = leftButtonItem;
    }
    return _assetsGroupVC;
}


- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
