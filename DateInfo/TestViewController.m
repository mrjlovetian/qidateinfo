//
//  TestViewController.m
//  DateInfo
//
//  Created by MRJ on 2019/3/10.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "TestViewController.h"
#import <YYImage/YYImage.h>
#import "YYAnimatedImageView.h"
#import <YYWebImage/YYWebImage.h>

@interface TestViewController ()

@property (nonatomic, strong)YYAnimatedImageView *imageView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageView];
    
//    NSURL * url = [[NSURL alloc] initWithString:@"http://simg.sydzyb.com/images/20190331/bba6b60995de9e3bfb95c147607a8c1a_2000_1333.jpg"];
//    YYImage *image = [YYImage imageWithData:data];
//    self.imageView.image = image;
    self.imageView.yy_imageURL = [NSURL URLWithString:@"http://simg.sydzyb.com/images/20190331/bba6b60995de9e3bfb95c147607a8c1a_2000_1333.jpg"];
    // Do any additional setup after loading the view.
}

- (YYAnimatedImageView *)imageView {
    if (!_imageView) {
        _imageView = [[YYAnimatedImageView alloc] initWithFrame:self.view.bounds];
    }
    return _imageView;
}

@end
