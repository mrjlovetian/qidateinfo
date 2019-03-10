//
//  TestViewController.m
//  DateInfo
//
//  Created by MRJ on 2019/3/10.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageView];
    NSData *data = [NSData dataWithContentsOfURL:self.imagUrl];
    self.imageView.image = [UIImage imageWithData:data];
    // Do any additional setup after loading the view.
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    }
    return _imageView;
}

@end
