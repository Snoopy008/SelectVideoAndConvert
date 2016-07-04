//
//  ViewController.m
//  SelectVideoAndConvert
//
//  Created by macavilang on 16/7/4.
//  Copyright © 2016年 Snoopy. All rights reserved.
//

#import "ViewController.h"
#import "GCMImagePickerController.h"
#import "GCMAssetModel.h"

//生成随机数
#define RandomNum (arc4random() % 9999999999999999)

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableArray *videoModelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    videoModelArray = [NSMutableArray array];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    GCMImagePickerController *picker = [[GCMImagePickerController alloc] init];
    
    //返回选中的原图
    [picker setDidFinishSelectImageModels:^(NSMutableArray *models) {
        NSLog(@"原图%@",models);
        for (GCMAssetModel *videoModel in models) {
           videoModel.fileName = [NSString stringWithFormat:@"%ld.mp4",RandomNum];
            [videoModel convertVideoWithModel:videoModel];
            [videoModelArray addObject:videoModel];
        }
    }];
    [self presentViewController:picker animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
