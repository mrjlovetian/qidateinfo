//
//  EditViewController.m
//  DateInfo
//
//  Created by MRJ on 2019/3/9.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "EditViewController.h"
#import <YYText.h>
#import <YYModel.h>
#import <Masonry.h>
#import <IQKeyboardManager.h>
#import "RiModel/RiJiModel.h"
#import "FileManager/FileManager.h"
#import "NSDate+Extension.h"
#import <TZImagePickerController.h>

@interface EditViewController ()<TZImagePickerControllerDelegate>

@property (nonatomic, strong)UITextField *titleTextField;
@property (nonatomic, strong)YYTextView *contentTextView;
@property (nonatomic, strong)UIImageView *addImageView;
@property (nonatomic, strong)NSMutableArray *dataSources;
@property (nonatomic, assign)CGFloat imageWidth;
@property (nonatomic, assign)CGFloat startX;
@property (nonatomic, assign)CGFloat startY;

@property (nonatomic, strong)NSMutableArray *imageArr;
@property (nonatomic, strong)NSMutableArray *imageNameArr;
@property (nonatomic, copy)NSArray *imagePathArr;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:self.titleTextField];
    [self.view addSubview:self.contentTextView];
    [self.view addSubview:self.addImageView];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addRiji) forControlEvents:UIControlEventTouchUpInside];
    addBtn.frame = CGRectMake(0, 110, 40, 40);
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = barItem;
    
    self.imageWidth = ScreenSzie.width/3.0;
    self.dataSources = [NSMutableArray arrayWithCapacity:1];
    self.imageArr = [NSMutableArray arrayWithCapacity:1];
    self.imageNameArr = [NSMutableArray arrayWithCapacity:1];
    
    [self.titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(NavBarHeight+10);
        make.height.mas_equalTo(40);
    }];
    
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleTextField);
        make.top.equalTo(self.titleTextField.mas_bottom).offset(10);
        make.height.mas_equalTo(100);
    }];
    
    [self.addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.equalTo(self.contentTextView.mas_bottom).offset(10);
        make.height.width.mas_equalTo(self.imageWidth);
    }];
    
}

#pragma mark method
- (void)refreshAddImageView {
    
    __weak typeof(self) weakSelf = self;
    if (self.dataSources.count == 0) {
        [self.addImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(0);
        }];
    } else {
        [self.addImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.dataSources.count%3*weakSelf.imageWidth);
            make.top.mas_equalTo(weakSelf.contentTextView.mas_bottom).offset(10 + weakSelf.dataSources.count/3*weakSelf.imageWidth);
            make.width.height.mas_equalTo(self.imageWidth);
        }];
    }
}

- (void)addImage {
    __weak typeof(self) weakSelf = self;
    TZImagePickerController *vc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    [vc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        if (self.dataSources.count == 0) {
            weakSelf.startX = weakSelf.addImageView.frame.origin.x;
            weakSelf.startY = weakSelf.addImageView.frame.origin.y;
        }
        
        int i = 0;
        for (UIImage *image in photos) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.imageWidth, self.imageWidth)];
            imageView.image = image;
            [self.dataSources addObject:imageView];
            [self.imageNameArr addObject:[[assets objectAtIndex:i] filename]];
            [self.imageArr addObject:image];
            i ++;
        }
        
        for (int i = 0; i < self.dataSources.count; i++) {
            UIImageView *imageView = self.dataSources[i];
            imageView.frame = CGRectMake(weakSelf.startX + (i%3)*self.imageWidth, weakSelf.startY + (i/3)*self.imageWidth, self.imageWidth, self.imageWidth);
            [self.view addSubview:imageView];
        }
        
        [self refreshAddImageView];
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)addRiji {
    RiJiModel *model = [RiJiModel new];
    model.title = self.titleTextField.text;
    model.content = self.contentTextView.text;
    model.dateTime = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSinceNow]];
    
    NSString *today = [[NSDate date] formatYMD];
    
    [[FileManager shareManager] saveImages:self.imageArr imageName:self.imageNameArr complete:^(NSArray<NSString *> *imageUrls) {
        NSLog(@"----------.........%@", imageUrls);
        model.images = imageUrls;
    }];
    
    
    
    NSMutableArray *datasArr = [NSMutableArray arrayWithCapacity:1];
    [datasArr addObjectsFromArray:[NSArray yy_modelArrayWithClass:RiJiInfo.class json:[[FileManager shareManager] readFileNameForKey:@"mrjdata"]]];
    NSMutableArray *modelarr = [NSMutableArray arrayWithCapacity:1];
    BOOL hasModel = NO;
    for (RiJiInfo *temInfo in datasArr) {
        if ([temInfo.date isEqualToString:today] && temInfo.datas && temInfo.datas.count > 0) {
            [modelarr addObjectsFromArray:temInfo.datas];
            [modelarr addObject:model];
            temInfo.datas = modelarr;
            hasModel = YES;
            break;
        }
    }
    if (!hasModel) {
        RiJiInfo *info = [RiJiInfo new];
        info.date = today;
        info.datas = @[model];
        [datasArr addObject:info];
    }
    
    NSString *content = [datasArr yy_modelToJSONString];
    [[FileManager shareManager] saveFile:content fileName:@"riji" complete:^(NSString *fileUrl) {
        [[FileManager shareManager] saveFileName:fileUrl ForKey:@"mrjdata"];
    }];
}

#pragma mark addImage
- (UITextField *)titleTextField {
    if (!_titleTextField) {
        _titleTextField = [UITextField new];
        _titleTextField.placeholder = @"起个名字吧！";
    }
    return _titleTextField;
}

- (YYTextView *)contentTextView {
    if (!_contentTextView) {
        _contentTextView = [YYTextView new];
        _contentTextView.placeholderText = @"今天写点什么呢？";
    }
    return _contentTextView;
}

- (UIImageView *)addImageView {
    if (!_addImageView) {
        _addImageView = [UIImageView new];
        [_addImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImage)]];
        _addImageView.backgroundColor = [UIColor grayColor];
        _addImageView.userInteractionEnabled = YES;
    }
    return _addImageView;
}

@end
