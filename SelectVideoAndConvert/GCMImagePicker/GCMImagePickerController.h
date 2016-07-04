//
//  GCMImagePickerController.h
//  SelectMediumFile
//
//  Created by macavilang on 16/6/28.
//  Copyright © 2016年 Snoopy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCMImagePickerController : UINavigationController

@property (nonatomic,copy) void(^didFinishSelectImageModels)(NSMutableArray *models);

@end
