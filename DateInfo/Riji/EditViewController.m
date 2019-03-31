//
//  EditViewController.m
//  DateInfo
//
//  Created by MRJ on 2019/3/9.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "EditViewController.h"
#import "YYText.h"
#import "YYModel.h"
#import "Masonry.h"
#import "IQKeyboardManager.h"
#import "RiJiModel.h"
#import "FileManager.h"
#import "NSDate+Extension.h"
#import "TZImagePickerController.h"
#import "RijiManager.h"
#import "ImageCell.h"
#import "MWPhoto.h"
#import "MWPhotoBrowser.h"

static NSString *indetif = @"image";

@interface EditViewController ()<TZImagePickerControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MWPhotoBrowserDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong)UITextField *titleTextField;
@property (nonatomic, strong)YYTextView *contentTextView;
//@property (nonatomic, strong)UIImageView *addImageView;
//@property (nonatomic, strong)NSMutableArray *dataSources;
//@property (nonatomic, assign)CGFloat imageWidth;
//@property (nonatomic, assign)CGFloat startX;
//@property (nonatomic, assign)CGFloat startY;
@property (nonatomic, assign)NSInteger maxCount;

@property (nonatomic, strong)NSMutableArray *imageArr;
@property (nonatomic, strong)NSMutableArray *imageNameArr;
@property (nonatomic, copy)NSArray *imagePathArr;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增日志";
    self.view.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
    self.maxCount = 6;

    [self.view addSubview:self.titleTextField];
    [self.view addSubview:self.contentTextView];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addRiji:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.frame = CGRectMake(0, 0, 60, 40);
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = barItem;

    self.imageArr = [NSMutableArray arrayWithCapacity:1];
    self.imageNameArr = [NSMutableArray arrayWithCapacity:1];
    
    UIImage *addImage = [UIImage imageNamed:@"addRealNameCard"];
    [self.imageArr addObject:addImage];
    [self.view addSubview:self.collectionView];
}

- (void)addImage {
    TZImagePickerController *vc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxCount-self.imageArr.count+1 delegate:self];
    [vc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        [self.imageArr removeLastObject];
        [self.imageArr addObjectsFromArray:photos];
        UIImage *addImage = [UIImage imageNamed:@"addRealNameCard"];
        [self.imageArr addObject:addImage];
        [self.collectionView reloadData];

        for (int i = 0; i < assets.count; i++) {
             [self.imageNameArr addObject:[[assets objectAtIndex:i] filename]];
        }
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)addRiji:(UIButton *)btn {
    btn.enabled = NO;
    NSString *today = [[NSDate date] formatYMD];
    NSInteger year = [[NSDate date] year];
    NSInteger month = [[NSDate date] month];
    
    RiJiModel *rijiModel = [RiJiModel new];
    rijiModel.title = self.titleTextField.text;
    rijiModel.content = self.contentTextView.text;
    rijiModel.dateStr = today;
    rijiModel.dateTime = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
    
    if ([self.titleTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0 && [self.contentTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0 && self.imageArr.count == 1) {
        
        [TSMessage showNotificationWithTitle:@"内容错误" subtitle:@"至少添加一项内容吧" type:(TSMessageNotificationTypeError)];
        return;
    }
    
    
    
    if (self.imageArr.count > 0) {
        [self.imageArr removeLastObject];
    }
    [[FileManager shareManager] saveImages:self.imageArr imageName:self.imageNameArr complete:^(NSArray<NSString *> *imageUrls) {
        rijiModel.images = imageUrls;
    }];
    
    
    NSMutableArray *datasArr = [NSMutableArray arrayWithCapacity:1];
    [datasArr addObjectsFromArray:[RijiManager shareRijiManager].rijiArr];
    NSMutableArray *modelarr = [NSMutableArray arrayWithCapacity:1];
    
    
    BOOL hasDay = NO;
    BOOL hasMonth = NO;
    BOOL hasYear = NO;
    RiJiDay *rijiDay = nil;
    RiJiMonth *rijiMonth = nil;
    RiJiYear *rijiYear = nil;
    for (RiJiYear *rijiYear in datasArr) {
        if ([rijiYear.year integerValue] == year && rijiYear.datas && rijiYear.datas.count > 0) {
            for (RiJiMonth *rijiMonth in rijiYear.datas) {
                if ([rijiMonth.month integerValue] == month && rijiMonth.datas && rijiMonth.datas.count > 0) {
                    for (RiJiDay *rijiDay in rijiMonth.datas) {
                        if ([rijiDay.date isEqualToString:today] && rijiDay.datas && rijiDay.datas.count > 0) {
                            [modelarr addObjectsFromArray:rijiDay.datas];
                            [modelarr insertObject:rijiModel atIndex:0];
                            rijiDay.datas = modelarr;
                            hasDay = YES;
                            break;
                        }
                    }
                    if (!hasDay) {
                        rijiDay = [RiJiDay new];
                        rijiDay.date = today;
                        rijiDay.datas = @[rijiModel];
                        NSMutableArray *dayArr = [NSMutableArray arrayWithCapacity:1];
                        [dayArr addObjectsFromArray:rijiMonth.datas];
                        [dayArr insertObject:rijiDay atIndex:0];
                        rijiMonth.datas = dayArr;
                    }
                    hasMonth = YES;
                    break;
                }
            }
            if (!hasMonth) {
                rijiMonth = [RiJiMonth new];
                rijiMonth.month = [NSString stringWithFormat:@"%ld", month];
                rijiMonth.datas = @[rijiDay];
                NSMutableArray *monthArr = [NSMutableArray arrayWithCapacity:1];
                [monthArr addObjectsFromArray:rijiYear.datas];
                [monthArr insertObject:rijiDay atIndex:0];
                rijiYear.datas = monthArr;
            }
            hasYear = YES;
            break;
        }
    }
    
    if (!hasYear) {
        rijiYear = [RiJiYear new];
        rijiMonth = [RiJiMonth new];
        rijiDay = [RiJiDay new];
        rijiYear.datas = @[rijiMonth];
        rijiYear.year = [NSString stringWithFormat:@"%ld", (long)year];
        rijiMonth.datas = @[rijiDay];
        rijiMonth.month = [NSString stringWithFormat:@"%ld", (long)month];
        rijiDay.datas = @[rijiModel];
        rijiDay.date = today;
        [datasArr insertObject:rijiYear atIndex:0];
    }
    
    NSString *content = [datasArr yy_modelToJSONString];
    [[FileManager shareManager] saveFile:content fileName:@"riji" complete:^(NSString *fileUrl) {
        [[FileManager shareManager] saveFileName:fileUrl ForKey:@"mrjdata"];
        [TSMessage showNotificationWithTitle:@"添加成功" subtitle:@"可以到日志列表看看今天新增的日志哦" type:(TSMessageNotificationTypeSuccess)];
        [[RijiManager shareRijiManager] reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}

#pragma mark addImage
- (UITextField *)titleTextField {
    if (!_titleTextField) {
        _titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth - 20, 30)];
        _titleTextField.placeholder = @"起个名字吧！";
        _titleTextField.textColor = [UIColor whiteColor];
    }
    return _titleTextField;
}

- (YYTextView *)contentTextView {
    if (!_contentTextView) {
        _contentTextView = [[YYTextView alloc] initWithFrame:CGRectMake(_titleTextField.left, _titleTextField.bottom + 10, _titleTextField.width, 100)];
        _contentTextView.placeholderText = @"今天写点什么呢？";
        _contentTextView.textColor = [UIColor whiteColor];
    }
    return _contentTextView;
}

#pragma mark MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.imageArr.count-1;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    MWPhoto *photo = [MWPhoto photoWithImage:self.imageArr[index]];
    return photo;
}

#pragma mark UICollectionViewDelegate

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.imageArr.count >  self.maxCount) {
        return  self.maxCount;
    }
    return self.imageArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indetif forIndexPath:indexPath];
    cell.isHideCloseBtn = (indexPath.row+1 == self.imageArr.count);
    cell.indexPath = indexPath;
    cell.image = self.imageArr[indexPath.row];
    
    cell.imageCellColseBlock = ^{
        [self.imageArr removeObjectAtIndex:indexPath.row];
        [self.collectionView reloadData];
    };
    cell.imageCellTapBlock = ^(NSIndexPath *indexPath) {
        if (indexPath.row+1 == self.imageArr.count) {
            MRJLog(@"添加图片");
            [self addImage];
        } else {
            MRJLog(@"点击图片");
            MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
            browser.displayActionButton = YES;
            [browser setCurrentPhotoIndex:indexPath.row];
            [self.navigationController pushViewController:browser animated:YES];
        }
    };
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.contentTextView.bottom + 10, ScreenWidth, ScreenHeight - NavBarHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:indetif];
        _collectionView.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
        _collectionView.contentInset = UIEdgeInsetsMake(10, 10, 0, 10);
        layout.itemSize = CGSizeMake(80, 100);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 20;
    }
    return _collectionView;
}

@end
