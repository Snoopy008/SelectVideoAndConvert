//
//  GCMAssetsGroupController.h
//  SelectMediumFile
//
//  Created by macavilang on 16/6/28.
//  Copyright © 2016年 Snoopy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAssetsLibrary;
@interface GCMAssetsGroupController : UITableViewController

@property (nonatomic,strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic,strong) NSMutableArray *groups;

@end
