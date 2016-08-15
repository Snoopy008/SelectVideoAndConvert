//
//  GCMGroupCell.m
//  SelectMediumFile
//
//  Created by macavilang on 16/6/28.
//  Copyright © 2016年 Snoopy. All rights reserved.
//

#import "GCMGroupCell.h"
#define MARGIN 10

@implementation GCMGroupCell

+ (instancetype)groupCell:(UITableView *)tableView{
    NSString *reusedId = @"groupCell";
    GCMGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedId];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedId];
    }
    return cell;
}
- (void)setGroup:(ALAssetsGroup *)group{
    //中文
    NSString *groupName = [group valueForProperty:ALAssetsGroupPropertyName];
    if ([groupName isEqualToString:@"Camera Roll"]) {
        groupName = @"相机";
    } else if ([groupName isEqualToString:@"My Photo Stream"]) {
        groupName = @"我的照片";
    }
    //设置属性
    
    
    [group setAssetsFilter:[ALAssetsFilter allAssets]];
    
    
    
    NSInteger groupCount = [group numberOfAssets];
    self.textLabel.text = [NSString stringWithFormat:@"%@ (%ld)",groupName, (long)groupCount];
    UIImage *image =[UIImage imageWithCGImage:group.posterImage] ;
    [self.imageView setImage:image];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat cellHeight = self.frame.size.height - 2 * MARGIN;
    self.imageView.frame = CGRectMake(MARGIN, MARGIN, cellHeight, cellHeight);
}

@end
