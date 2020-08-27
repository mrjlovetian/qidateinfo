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
#import "YBImageBrowser.h"
//#import ""
//#import "MWPhoto.h"
//#import "MWPhotoBrowser.h"

static NSString *indetif = @"image";

@interface EditViewController ()<TZImagePickerControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong)UITextField *titleTextField;
@property (nonatomic, strong)YYTextView *contentTextView;
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
    [addBtn setTitleColor:[UIColor colorWithHexString:@"ff801a"] forState:UIControlStateNormal];
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
    vc.navigationBar.barTintColor = MAINCOLOR;
    vc.navigationBar.translucent = NO;
    vc.navigationItem.title = @"选择图片";
//    self.view.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)addRiji:(UIButton *)btn {
    btn.enabled = NO;
    NSString *today = [[NSDate date] formatYMD];
    NSInteger year = [[NSDate date] year];
    
    RiJiModel *rijiModel = [RiJiModel new];
    rijiModel.title = self.titleTextField.text;
    rijiModel.content = self.contentTextView.text;
    rijiModel.day = today;
    rijiModel.year = [NSString stringWithFormat:@"%ld", year];
    rijiModel.month = [[NSDate date] stringWithFormat:@"yyyy-MM"];
    
    if ([self.titleTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0 && [self.contentTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0 && self.imageArr.count == 1) {
        
        [TSMessage showNotificationWithTitle:@"内容错误" subtitle:@"至少添加一项内容吧" type:(TSMessageNotificationTypeError)];
        return;
    }
    
    if (self.imageArr.count > 0) {
        [self.imageArr removeLastObject];
    }
    [[FileManager shareManager] saveImages:self.imageArr imageName:self.imageNameArr complete:^(NSArray<NSString *> *imageUrls) {
        NSString *imageUrl = [imageUrls componentsJoinedByString:@"#"];
        rijiModel.imageUrls = imageUrl;
        BOOL result = [RiJiModel insertData:rijiModel];
        
        if (result) {
            [TSMessage showNotificationWithTitle:@"添加成功" subtitle:@"可以到日志列表看看今天新增的日志哦" type:(TSMessageNotificationTypeSuccess)];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    }];
}

#pragma mark addImage
- (UITextField *)titleTextField {
    if (!_titleTextField) {
        _titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth - 20, 30)];
        NSString *str = @"起个名字吧！";
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:str];
        [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0] range:NSMakeRange(0, str.length)];
        [att addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"afafaf"] range:NSMakeRange(0, str.length)];
        _titleTextField.attributedPlaceholder = att;
        _titleTextField.textColor = [UIColor whiteColor];
    }
    return _titleTextField;
}

- (YYTextView *)contentTextView {
    if (!_contentTextView) {
        _contentTextView = [[YYTextView alloc] initWithFrame:CGRectMake(_titleTextField.left, _titleTextField.bottom + 10, _titleTextField.width, 100)];
        _contentTextView.placeholderText = @"今天写点什么呢？";
        _contentTextView.placeholderTextColor = [UIColor colorWithHexString:@"afafaf"];
        _contentTextView.font = [UIFont systemFontOfSize:16.0];
        _contentTextView.placeholderFont = [UIFont systemFontOfSize:16.0];
        _contentTextView.textColor = [UIColor whiteColor];
    }
    return _contentTextView;
}

#pragma mark UICollectionViewDelegate

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


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
            NSMutableArray *datas = [NSMutableArray arrayWithCapacity:1];
            for (UIImage *image in self.imageArr) {
                YBIBImageData *data = [YBIBImageData new];
                data.image = ^UIImage * _Nullable{
                    return image;
                };
                [datas addObject:data];
            }
            
            YBImageBrowser *browser = [YBImageBrowser new];
            browser.dataSourceArray = datas;
            browser.currentPage = indexPath.row;
            [browser show];
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
        CGFloat iamgeWidth = (ScreenSzie.width - 41)/3.0;
        layout.itemSize = CGSizeMake(iamgeWidth, iamgeWidth);
    }
    return _collectionView;
}

@end
