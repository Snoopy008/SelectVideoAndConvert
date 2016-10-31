//
//  GCMCollectionViewController.m
//  SelectMediumFile
//
//  Created by macavilang on 16/6/28.
//  Copyright © 2016年 Snoopy. All rights reserved.
//

#import "GCMCollectionViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "GCMAssetModel.h"
#import "GCMImagePickerController.h"
#import <MediaPlayer/MediaPlayer.h>
static const NSInteger MARGIN = 10;
static const NSInteger COL = 4;
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)



@interface GCMShowCell : UICollectionViewCell
@property (nonatomic,weak) UIButton *selectedButton;
@end

@implementation GCMShowCell

@end

@interface GCMCollectionViewController ()
@property (nonatomic,strong) NSMutableArray *assetModels;
//选中的模型
@property (nonatomic,strong) NSMutableArray *selectedModels;
@end

@implementation GCMCollectionViewController
{
    UIButton *bigImg;
    UIView *cover;
}


static NSString * const reuseIdentifier = @"Cell";
//设置类型
- (instancetype)init
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = MARGIN;
    flowLayout.minimumInteritemSpacing = MARGIN;
    CGFloat cellHeight = (SCREEN_WIDTH - (COL + 1) * MARGIN) / COL;
    flowLayout.itemSize = CGSizeMake(cellHeight, cellHeight);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    return [super initWithCollectionViewLayout:flowLayout];
}


- (NSMutableArray *)assetModels{
    if (_assetModels == nil) {
        _assetModels = [NSMutableArray array];
    }
    return _assetModels;
}
- (NSMutableArray *)selectedModels{
    if (_selectedModels == nil) {
        _selectedModels = [NSMutableArray array];
    }
    return _selectedModels;
}
- (void)setGroup:(ALAssetsGroup *)group{
    _group = group;
    [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        if (asset == nil) return ;
        GCMAssetModel *model = [[GCMAssetModel alloc] init];
        if (![[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {//不是图片
            model.thumbnail = [UIImage imageWithCGImage:asset.thumbnail];
            model.imageURL = asset.defaultRepresentation.url;
            model.isImage = NO;
            [self.assetModels addObject:model];
        }else{//图片
            model.thumbnail = [UIImage imageWithCGImage:asset.thumbnail];
            model.imageURL = asset.defaultRepresentation.url;
            model.isImage = YES;
            [self.assetModels addObject:model];
        }
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[GCMShowCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //右侧完成按钮
    UIButton *editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [editButton setTitle:@"完成" forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(finishSelecting) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
}

//出口,选择完成图片
- (void)finishSelecting{
    
    if ([self.navigationController isKindOfClass:[GCMImagePickerController class]]) {
        GCMImagePickerController *picker = (GCMImagePickerController *)self.navigationController;
        if (picker.didFinishSelectImageModels) {
            
            for (GCMAssetModel *model in self.assetModels) {
                if (model.isSelected) {
                    [self.selectedModels addObject:model];
                }
            }
            
            if (picker.didFinishSelectImageModels) {
                picker.didFinishSelectImageModels(self.selectedModels);
            }
            
        }
    }
    
    //移除
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.assetModels.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GCMShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    GCMAssetModel *model = self.assetModels[indexPath.item];
    
    if (cell.backgroundView == nil) {//防止多次创建
        UIImageView *imageView = [[UIImageView alloc] init];
        cell.backgroundView = imageView;
    }
    UIImageView *backView = (UIImageView *)cell.backgroundView;
    backView.image = model.thumbnail;
    if (cell.selectedButton == nil) {//防止多次创建
        UIButton *selectButton = [[UIButton alloc] init];
        [selectButton setImage:[UIImage imageNamed:@"delect_02"] forState:UIControlStateNormal];
        [selectButton setImage:[UIImage imageNamed:@"add_01"] forState:UIControlStateSelected];
        CGFloat width = cell.bounds.size.width;
        selectButton.frame = CGRectMake(width - 30, 0, 30, 30);
        [cell.contentView addSubview:selectButton];
        cell.selectedButton = selectButton;
        [selectButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    cell.selectedButton.tag = indexPath.item;//重新绑定
    cell.selectedButton.selected = model.isSelected;//恢复设定状态
    return cell;
}
- (void)buttonClicked:(UIButton *)sender{
    sender.selected = !sender.selected;
    GCMAssetModel *model = self.assetModels[sender.tag];
    //因为冲用的问题,不能根据选中状态来记录
    if (sender.selected == YES) {//选中了记录
        model.isSelected = YES;
    }else{//否则移除记录
        model.isSelected = NO;
    }
}
#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GCMAssetModel *model = self.assetModels[indexPath.item];
    if (model.isImage == NO) {
        
        MPMoviePlayerViewController* playerView = [[MPMoviePlayerViewController alloc] initWithContentURL:model.imageURL];
        [self presentViewController:playerView animated:YES completion:nil];
    }else{
        
        cover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectview.frame = cover.frame;
        [cover addSubview:effectview];
        [self.view addSubview:cover];
        bigImg = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [bigImg addTarget:self action:@selector(removeBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bigImg];
        
        ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
        [lib assetForURL:model.imageURL resultBlock:^(ALAsset *asset) {
            ALAssetRepresentation *assetRep = [asset defaultRepresentation];
            CGImageRef imgRef = [assetRep fullResolutionImage];
            UIImage *img = [UIImage imageWithCGImage:imgRef
                                               scale:assetRep.scale
                                         orientation:(UIImageOrientation)assetRep.orientation];
            [bigImg setImage:img forState:UIControlStateNormal];
        } failureBlock:^(NSError *error) {
            NSLog(@"相册图片访问失败");
        }];
        
    }
}

//移走大图
- (void)removeBtn
{
    [cover removeFromSuperview];
    [bigImg removeFromSuperview];
    
}
@end

