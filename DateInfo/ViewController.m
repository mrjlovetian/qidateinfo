//
//  ViewController.m
//  DateInfo
//
//  Created by MRJ on 2019/3/3.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "ViewController.h"
#import "FSCalendar.h"
#import "StarWars-Swift.h"

@interface ViewController () <FSCalendarDelegate, FSCalendarDataSource>

@property (nonatomic, strong)FSCalendar *calendar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addRiji) forControlEvents:UIControlEventTouchUpInside];
    addBtn.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = barItem;
    
    UIButton *showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showBtn setTitle:@"+" forState:UIControlStateNormal];
    [showBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [showBtn addTarget:self action:@selector(showRiji) forControlEvents:UIControlEventTouchUpInside];
    showBtn.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:showBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:self.view.bounds];
    calendar.dataSource = self;
    calendar.delegate = self;
    [self.view addSubview:calendar];
    self.calendar = calendar;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)addRiji {
    UIViewController *vc = [[NSClassFromString(@"EditViewController") alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showRiji {
    UIViewController *vc = [[NSClassFromString(@"ShowRijiViewController") alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark FSCalendarDelegate

#pragma mark FSCalendarDataSource


@end
