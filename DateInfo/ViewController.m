//
//  ViewController.m
//  DateInfo
//
//  Created by MRJ on 2019/3/3.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "ViewController.h"
#import <FSCalendar.h>

@interface ViewController () <FSCalendarDelegate, FSCalendarDataSource>

@property (nonatomic, strong)FSCalendar *calendar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:self.view.bounds];
    calendar.dataSource = self;
    calendar.delegate = self;
    [self.view addSubview:calendar];
    self.calendar = calendar;
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark FSCalendarDelegate

#pragma mark FSCalendarDataSource


@end
