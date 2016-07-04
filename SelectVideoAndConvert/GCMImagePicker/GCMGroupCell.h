//
//  GCMGroupCell.h
//  SelectMediumFile
//
//  Created by macavilang on 16/6/28.
//  Copyright © 2016年 Snoopy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface GCMGroupCell : UITableViewCell

@property (nonatomic,strong) ALAssetsGroup *group;
+ (instancetype)groupCell:(UITableView *)tableView;
@end
