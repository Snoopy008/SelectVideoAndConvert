//
//  GCMAssetModel.h
//  SelectMediumFile
//
//  Created by macavilang on 16/6/28.
//  Copyright © 2016年 Snoopy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCMAssetModel : NSObject

@property (nonatomic,strong) UIImage *thumbnail;//缩略图
@property (nonatomic,copy) NSURL *imageURL;//原图url,是AssetURL
@property (nonatomic,assign) BOOL isSelected;//是否被选中

@property (nonatomic,assign) BOOL isImage;//是否是图片
@property (nonatomic,copy) NSString *sandboxPath;//文件存储在本地的路径
@property (nonatomic,copy) NSString *fileName;//文件名
@property (nonatomic,copy) NSData *fileData;//文件的NSData
- (void)originalImage:(void (^)(UIImage *image))returnImage;//获取原图

- (void) convertVideoWithModel:(GCMAssetModel *) model;
@end
