//
//  RijiDetailViewController.m
//  DateInfo
//
//  Created by MRJ on 2019/3/30.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "RijiDetailViewController.h"
#import "RiJiModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FileManager.h"
#import "MWPhotoBrowser.h"
#import "RijiManager.h"

@interface RijiDetailViewController ()<MWPhotoBrowserDelegate>

@property (nonatomic, strong)UILabel *timeLab;
@property (nonatomic, strong)YYLabel *contentLab;
@property (nonatomic, strong)UIScrollView *mainView;
@property (nonatomic, copy)NSArray *photos;

@end

@implementation RijiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(0, 0, 50, 40);
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteRiji) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:deleteBtn];
    self.navigationItem.rightBarButtonItem = item;
    
    self.view.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
    [self.view addSubview:self.mainView];
    [self.mainView addSubview:self.timeLab];
    [self.mainView addSubview:self.contentLab];
    self.title = self.rijiModel.title;
    self.timeLab.text = self.rijiModel.dateStr;
    YYTextContainer *contentContarer = [YYTextContainer new];
    //限制宽度
    contentContarer.size = CGSizeMake(ScreenWidth - 20, CGFLOAT_MAX);
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:self.rijiModel.content];
    att.yy_font = [UIFont systemFontOfSize:17.0];
    att.yy_color = [UIColor whiteColor];
    att.yy_alignment = NSTextAlignmentJustified;
    //设置行间距
    att.yy_lineSpacing = 5;
    
    YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:contentContarer text:att];
    self.contentLab.textLayout = textLayout;
    self.contentLab.height = textLayout.textBoundingSize.height;
    
    
    CGFloat iamgeWidth = (ScreenSzie.width - 30)/3.0;
    CGFloat bottom = self.contentLab.bottom + 20;
    for (int i = 0; i < _rijiModel.images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.frame = CGRectMake(10 + (i%3)*(iamgeWidth + 5), _contentLab.bottom + 5 + (i/3)*(iamgeWidth + 5), iamgeWidth, iamgeWidth);
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [self checkImageIndex:i rijiModel:self.rijiModel];
        }]];
        [imageView sd_setImageWithURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@%@", [[FileManager shareManager] getMianPath], _rijiModel.images[i]]]];
        [self.mainView addSubview:imageView];
        bottom = imageView.bottom + 20;
    }
    self.mainView.contentSize = CGSizeMake(0, bottom);
    // Do any additional setup after loading the view.
}

#pragma mark method
- (void)checkImageIndex:(NSInteger)index rijiModel:(RiJiModel *)model {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
    for (NSString *imageUrl in model.images) {
        NSURL *url = [[NSURL alloc] initFileURLWithPath:[NSString stringWithFormat:@"%@%@", [[FileManager shareManager] getMianPath] , imageUrl]];
        MWPhoto *photo = [[MWPhoto alloc] initWithURL:url];
        [arr addObject:photo];
    }
    self.photos = arr;
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    [browser setCurrentPhotoIndex:index];
    [self.navigationController pushViewController:browser animated:YES];
}

- (void)deleteRiji {
    UIAlertController *alert = [[UIAlertController alloc] init];
    alert.title = @"删除日志";
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        
//        NSArray *allRijiArr = [[[RijiManager shareRijiManager] rijiArr] yy_modelToJSONObject];
//        NSDictionary *modelDic = [self.rijiModel yy_modelToJSONObject];
//        for (NSDictionary *yearDic in allRijiArr) {
//            if ([yearDic objectForKey:[self.rijiModel.dateStr substringFromIndex:4]]) {
//                NSDictionary *monthDic = [yearDic objectForKey:[self.rijiModel.dateStr substringWithRange:NSMakeRange(4, 2)]];
//                if ([monthDic objectForKey:self.rijiModel.dateStr]) {
//                    NSDictionary *dayDic = [monthDic objectForKey:self.rijiModel.dateStr];
//
//                }
//            }
//        }
        
        for (RiJiYear *rijiyear in [[RijiManager shareRijiManager] rijiArr]) {
            if ([rijiyear.year isEqualToString:[self.rijiModel.dateStr substringToIndex:4]]) {
                for (RiJiMonth *rijiMonth in rijiyear.datas) {
                    if ([rijiMonth.month integerValue] == [[self.rijiModel.dateStr substringWithRange:NSMakeRange(5, 2)] integerValue]) {
                        for (RiJiDay *rijiDay in rijiMonth.datas) {
                            if ([rijiDay.date isEqualToString:self.rijiModel.dateStr]) {
                                for (RiJiModel *rijModel in rijiDay.datas) {
                                    if ([rijModel.dateTime isEqualToString:self.rijiModel.dateTime]) {
                                        NSMutableArray *temArr = [NSMutableArray arrayWithCapacity:1];
                                        [temArr addObjectsFromArray:rijiDay.datas];
                                        [temArr removeObject:rijModel];
                                        rijiDay.datas = temArr;
                                    }
                                }
                                if (rijiDay.datas.count == 0) {
                                    NSMutableArray *temArr = [NSMutableArray arrayWithCapacity:1];
                                    [temArr addObjectsFromArray:rijiMonth.datas];
                                    [temArr removeObject:rijiDay];
                                    rijiMonth.datas = temArr;
                                }
                                
                            }
                        }
                        if (rijiMonth.datas.count == 0) {
                            NSMutableArray *temArr = [NSMutableArray arrayWithCapacity:1];
                            [temArr addObjectsFromArray:rijiyear.datas];
                            [temArr removeObject:rijiMonth];
                            rijiyear.datas = temArr;
                        }
                    }
                }
            }
        }
        
        
        
        NSString *content = [[[RijiManager shareRijiManager] rijiArr] yy_modelToJSONString];
        [[FileManager shareManager] saveFile:content fileName:@"riji" complete:^(NSString *fileUrl) {
            [[FileManager shareManager] saveFileName:fileUrl ForKey:@"mrjdata"];
            [TSMessage showNotificationWithTitle:@"删除日志" subtitle:@"成功删除改日志" type:(TSMessageNotificationTypeSuccess)];
            [[RijiManager shareRijiManager] reloadData];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    return [self.photos objectAtIndex:index];
}

#pragma mark get
- (UIScrollView *)mainView {
    if (!_mainView) {
        _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavBarHeight)];
    }
    return _mainView;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth - 20, 15)];
        _timeLab.textColor = [UIColor whiteColor];
        _timeLab.textAlignment = NSTextAlignmentRight;
        _timeLab.font = [UIFont systemFontOfSize:14.0];
    }
    return _timeLab;
}

- (YYLabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [[YYLabel alloc] initWithFrame:CGRectMake(_timeLab.left, _timeLab.bottom + 10, _timeLab.width, 0)];
    }
    return _contentLab;
}

@end
