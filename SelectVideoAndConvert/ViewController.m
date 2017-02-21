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








//触发方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    GCMImagePickerController *picker = [[GCMImagePickerController alloc] init];
    //返回选中的原图
    [picker setDidFinishSelectImageModels:^(NSMutableArray *models) {
        NSLog(@"原图%@",models);
        for (GCMAssetModel *videoModel in models) {
           videoModel.fileName = [NSString stringWithFormat:@"%ld.mp4",RandomNum];
            
            //转码压缩存储至本地（如果想修改存储路径和压缩比例看方法内部）
            [videoModel convertVideoWithModel:videoModel];
            
            //所有数据都在模型数组里，想要的数据具体看模型，模型（GCMAssetModel）里面写的很清楚
            //解码是异步的，但指针始终指向videoModel这个对象，所以在这边打印fileData可能为null,这是正常现象，过十几秒fileData就有数据了。
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
