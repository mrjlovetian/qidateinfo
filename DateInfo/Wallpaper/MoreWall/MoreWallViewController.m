//
//  MoreWallViewController.m
//  XWallpaper
//
//  Created by MRJ on 2020/8/1.
//  Copyright © 2020 MRJ. All rights reserved.
//

#import "MoreWallViewController.h"
#import "WallCatageModel.h"
#import "WallpaperCell.h"
#import "YBImageBrowser.h"
#import "StoryMakeImageEditorViewController.h"

@interface MoreWallViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MoreWallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *datas = [NSMutableArray array];
    [self.dataSource enumerateObjectsUsingBlock:^(ImageModel *imageModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        WallpaperCell *cell = (WallpaperCell *)[collectionView cellForItemAtIndexPath:indexPath];
        YBIBImageData *data = [YBIBImageData new];
        data.projectiveView = cell.iconImageView;
        // 这里放的是原图地址（实际业务中请按需关联）
        NSString *thumUrl = [NSString stringWithFormat:@"http://wallpapers.claritywallpaper.com/%@?imageMogr2/auto-orient/thumbnail/750x/blur/1x0/quality/100", imageModel.url];
        NSString *imageUrl = [NSString stringWithFormat:@"http://wallpapers.claritywallpaper.com/%@", imageModel.url];
        data.imageURL = [NSURL URLWithString:imageUrl];
        data.thumbURL = [NSURL URLWithString:thumUrl];

        [datas addObject:data];
        
    }];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = datas;
    browser.currentPage = indexPath.row;
    [browser show];
    
    YBIBSheetAction *action = [YBIBSheetAction actionWithName:@"Edit" action:^(id<YBIBDataProtocol>  _Nonnull data) {
        StoryMakeImageEditorViewController *storyMakerVc = [[StoryMakeImageEditorViewController alloc] initWithImage:((YBIBImageData *)data).originImage];
        storyMakerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:storyMakerVc animated:YES completion:nil];
        [browser hide];
    }];
    [browser.defaultToolViewHandler.sheetView.actions addObject:action];
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WallpaperCell *cell = (WallpaperCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellmore" forIndexPath:indexPath];
    cell.imageModel = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
//        layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
        //该方法也可以设置itemSize
        CGFloat itemSizeWidth = (ScreenWidth - 50)/3.0;
        layout.itemSize =CGSizeMake(itemSizeWidth, itemSizeWidth * (4/3.0));
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithRed:13/255.0 green:16/255.0 blue:65/255.0 alpha:1.0];
        _collectionView.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
        [_collectionView registerClass:[WallpaperCell class] forCellWithReuseIdentifier:@"cellmore"];
        
        //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
        
        _collectionView.collectionViewLayout = layout;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
