# SelectVideoAndConvert

Sorry,一直没来得及写说明文档，导致加了很多同行的QQ。


运行demo后你会发现界面一片空白，这是正常的。我用的触发方法是touchesBegan，所以你只需点击空白界面就会有反应。

每个人的需求会不一样，这也是我没把它做成framework的原因

在GCMGroupCell.m里，allAssets代表所有相册文件，allPhotos代表所有图片，allVideos代表所有视频
```
 [group setAssetsFilter:[ALAssetsFilter allAssets]];
```
在GCMCollectionViewController.m里，只需要注意这个方法，根据需要把对应的注释掉
```
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
```
视频压缩部分我就不做解说了，简书上对应有所说明

注：视频上传部分代码里没有，不过我已经将你所需要上传data放在Model里了，你拿着Model和接口对接一下就可以了。
    请使用真机调试。
    请认真看本人简书里《iOS存储之沙盒存储常用方法》这篇文章，这篇文章与这个功能的实现有莫大的关系，所以请务必要看。

