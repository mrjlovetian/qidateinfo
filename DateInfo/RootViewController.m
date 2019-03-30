//
//  ViewController.m
//  DateInfo
//
//  Created by MRJ on 2019/3/3.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "RootViewController.h"
#import "FSCalendar.h"
#import "StarWars-Swift.h"
#import <EventKit/EventKit.h>
#import "LunarFormatter.h"
#import "NSDate+Extension.h"
#import "MRJCalendarWeekdayView.h"
#import "JumpDateView.h"
#import "NSDate+Reporting.h"

@interface RootViewController () <FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, JumpDateViewDelegate>

@property (nonatomic, strong)FSCalendar *calendar;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSDate *minimumDate;
@property (strong, nonatomic) NSDate *maximumDate;
@property (strong, nonatomic) NSCache *cache;
@property (nonatomic, strong)JumpDateView *jumpDateView;

@property (strong, nonatomic) LunarFormatter *lunarFormatter;
@property (strong, nonatomic) NSArray<EKEvent *> *events;
@property (strong, nonatomic) NSDictionary *holiyDay;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.lee_theme.LeeAddBackgroundColor(@"main", MAINCOLOR);
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"日子";
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addRiji) forControlEvents:UIControlEventTouchUpInside];
    addBtn.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = barItem;
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setTitle:@"选择" forState:UIControlStateNormal];
    [selectBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selectDay) forControlEvents:UIControlEventTouchUpInside];
    selectBtn.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *selectItem = [[UIBarButtonItem alloc] initWithCustomView:selectBtn];
    self.navigationItem.leftBarButtonItem = selectItem;
    
    UIButton *todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [todayBtn setTitle:@"今" forState:UIControlStateNormal];
    [todayBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [todayBtn addTarget:self action:@selector(today) forControlEvents:UIControlEventTouchUpInside];
    todayBtn.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *todayBtnItem = [[UIBarButtonItem alloc] initWithCustomView:todayBtn];
    self.navigationItem.rightBarButtonItems = @[barItem, todayBtnItem];
    
    MRJCalendarWeekdayView *weekHeaderView = [[MRJCalendarWeekdayView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, 40.0)];
    [weekHeaderView configureAppearance];
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/3*2)];
    calendar.dataSource = self;
    calendar.headerHeight = 40.0;
    calendar.weekdayHeight = 40.0;
    calendar.delegate = self;

    calendar.appearance.headerDateFormat = @"YYYY 年 MM 月";
    calendar.appearance.headerTitleColor = [UIColor whiteColor];
    [calendar.calendarWeekdayView removeFromSuperview];
    [calendar addSubview:weekHeaderView];
    [self.view addSubview:calendar];
    [calendar selectDate:[NSDate date]];
    calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    self.calendar = calendar;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    self.minimumDate = [self.dateFormatter dateFromString:@"1994-10-03"];
    self.maximumDate = [self.dateFormatter dateFromString:@"2099-12-31"];
    self.lunarFormatter = [[LunarFormatter alloc] init];
    [self loadCalendarEvents];
    [self.calendar reloadData];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"holiday" ofType:@"json"];
    NSData *data = [[NSData data] initWithContentsOfFile:path];
    self.holiyDay = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)addRiji {
    UIViewController *vc = [[NSClassFromString(@"EditViewController") alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    if ([[self.calendar.selectedDate formatYMD] isEqualToString:[[NSDate date] formatYMD]]) {
//        UIViewController *vc = [[NSClassFromString(@"EditViewController") alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//        return;
//    }
//    [TSMessage showNotificationWithTitle:@"选择错误" subtitle:@"只能增加今天的日志" type:(TSMessageNotificationTypeError)];
}

- (void)selectDay {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self.jumpDateView];
}

- (void)today {
    [self.calendar setCurrentPage:[NSDate date] animated:YES];
}

#pragma mark JumpDateViewDelegate

- (void)JumpDateViewSelectDate:(NSDate *)date {
    [self.calendar selectDate:date scrollToDate:YES];
}

#pragma mark - FSCalendarDataSource

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar {
    return self.minimumDate;
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar {
    return self.maximumDate;
}

- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date {
    NSString *dateStr = [date stringWithFormat:@"MM-dd"];
    if ([self.holiyDay objectForKey:@"holiday"] && ([date year] == [[NSDate date] year])) {
        if ([[self.holiyDay objectForKey:@"holiday"] objectForKey:dateStr]) {
            return [[[self.holiyDay objectForKey:@"holiday"] objectForKey:dateStr] objectForKey:@"name"];
        }
    }
    
    EKEvent *event = [self eventsForDate:date].firstObject;
    if (event) {
        return event.title;
    }
    return [self.lunarFormatter stringFromDate:date];
}

#pragma mark - FSCalendarDelegate

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    NSLog(@"did select %@",[self.dateFormatter stringFromDate:date]);
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar {
    NSLog(@"did change page %@",[self.dateFormatter stringFromDate:calendar.currentPage]);
}

- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date {
//    if (!self.showsEvents) return 0;
    if (!self.events) return 0;
    NSArray<EKEvent *> *events = [self eventsForDate:date];
    return events.count;
}

- (NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date {
//    if (!self.showsEvents) return nil;
    if (!self.events) return nil;
    NSArray<EKEvent *> *events = [self eventsForDate:date];
    NSMutableArray<UIColor *> *colors = [NSMutableArray arrayWithCapacity:events.count];
    [events enumerateObjectsUsingBlock:^(EKEvent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [colors addObject:[UIColor colorWithCGColor:obj.calendar.CGColor]];
    }];
    return colors.copy;
}

#pragma mark - Private methods

- (void)loadCalendarEvents {
    __weak typeof(self) weakSelf = self;
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        
        if(granted) {
            NSDate *startDate = [[NSDate date] previousMonth:12];
            NSDate *endDate = [[NSDate date] nextMonth:12];
            NSPredicate *fetchCalendarEvents = [store predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
            NSArray<EKEvent *> *eventList = [store eventsMatchingPredicate:fetchCalendarEvents];
            NSArray<EKEvent *> *events = [eventList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable event, NSDictionary<NSString *,id> * _Nullable bindings) {
                return event.calendar.subscribed;
            }]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!weakSelf) return;
                weakSelf.events = events;
                [weakSelf.calendar reloadData];
            });
            
        } else {
            
            // Alert
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Permission Error" message:@"Permission of calendar is required for fetching events." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}

- (NSArray<EKEvent *> *)eventsForDate:(NSDate *)date {
    NSArray<EKEvent *> *events = [self.cache objectForKey:date];
    if ([events isKindOfClass:[NSNull class]]) {
        return nil;
    }
    NSArray<EKEvent *> *filteredEvents = [self.events filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject.occurrenceDate isEqualToDate:date];
    }]];
    if (filteredEvents.count) {
        [self.cache setObject:filteredEvents forKey:date];
    } else {
        [self.cache setObject:[NSNull null] forKey:date];
    }
    return filteredEvents;
}

#pragma mark - <FSCalendarDelegateAppearance>
- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date {
    NSString *dateStr = [date stringWithFormat:@"MM-dd"];
    if ([self.holiyDay objectForKey:@"holiday"] && ([date year] == [[NSDate date] year])) {
        if ([[self.holiyDay objectForKey:@"holiday"] objectForKey:dateStr]) {
            if ([[self.holiyDay objectForKey:@"holiday"] objectForKey:dateStr]) {
                if ([[[[self.holiyDay objectForKey:@"holiday"] objectForKey:dateStr] objectForKey:@"holiday"] boolValue]) {
                    return [UIColor greenColor];
                }
                return [UIColor orangeColor];
            }
        }
    }
    return [UIColor whiteColor];
}

/**
 * Asks the delegate for day text color in selected state for the specific date.
 */
- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance subtitleDefaultColorForDate:(NSDate *)date{
    NSString *dateStr = [date stringWithFormat:@"MM-dd"];
    if ([self.holiyDay objectForKey:@"holiday"] && ([date year] == [[NSDate date] year])) {
        if ([[self.holiyDay objectForKey:@"holiday"] objectForKey:dateStr]) {
            if ([[self.holiyDay objectForKey:@"holiday"] objectForKey:dateStr]) {
                if ([[[[self.holiyDay objectForKey:@"holiday"] objectForKey:dateStr] objectForKey:@"holiday"] boolValue]) {
                    return [UIColor greenColor];
                }
                return [UIColor orangeColor];
            }
        }
    }
    return [UIColor whiteColor];
}

#pragma mark ui
- (JumpDateView *)jumpDateView {
    if (!_jumpDateView) {
        _jumpDateView = [[JumpDateView alloc] initWithFrame:[UIScreen mainScreen].bounds maxDate:self.maximumDate minDate:self.minimumDate];
        _jumpDateView.delegate = self;
    }
    return _jumpDateView;
}

@end
