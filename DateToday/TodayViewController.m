//
//  TodayViewController.m
//  DateToday
//
//  Created by MRJ on 2019/4/4.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "FSCalendar.h"
#import <EventKit/EventKit.h>
#import "NSDate+Extension.h"
#import "NSDate+Reporting.h"
#import "YYCategories.h"

@interface TodayViewController () <NCWidgetProviding, FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance>

@property (weak  , nonatomic) IBOutlet FSCalendar *calendar;
@property (weak  , nonatomic) IBOutlet UIButton *prevButton;
@property (weak  , nonatomic) IBOutlet UIButton *nextButton;
@property (weak  , nonatomic) IBOutlet NSLayoutConstraint *calendarHeight;

@property (strong, nonatomic) NSCache *cache;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSCalendar *lunarCalendar;
@property (strong, nonatomic) NSArray<NSString *> *lunarChars;
@property (strong, nonatomic) NSArray<EKEvent *> *events;
@property (strong, nonatomic) NSDictionary *holiyDay;

@end

@implementation TodayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.calendar.today = nil;
    self.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    self.calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    self.calendar.appearance.headerMinimumDissolvedAlpha = 0;
    self.lunarCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    self.calendar.dataSource = self;
    self.calendar.delegate = self;
    [self.calendar selectDate:[NSDate date]];
    self.lunarCalendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    self.lunarChars = @[@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",@"二一",@"二二",@"二三",@"二四",@"二五",@"二六",@"二七",@"二八",@"二九",@"三十"];
    
    NSURL *dateUrl = [NSURL URLWithString:@"https://raw.githubusercontent.com/mrjlovetian/jsonData/master/holiday.json"];
    NSData *data = [[NSData data] initWithContentsOfURL:dateUrl];
    self.holiyDay = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    if ([self.extensionContext respondsToSelector:@selector(setWidgetLargestAvailableDisplayMode:)]) {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    } else {
        self.preferredContentSize = CGSizeMake(0, self.calendarHeight.constant);
    }
    [self loadCalendarEvents];
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        [self.calendar setScope:FSCalendarScopeWeek animated:YES];
        self.preferredContentSize = maxSize;
    } else if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
        [self.calendar setScope:FSCalendarScopeMonth animated:YES];
        self.preferredContentSize = CGSizeMake(maxSize.width, self.calendarHeight.constant);
    }
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    completionHandler(NCUpdateResultNewData);
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsZero;
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated {
    self.calendarHeight.constant = CGRectGetHeight(bounds);
    [self.view layoutIfNeeded];
    self.preferredContentSize = CGSizeMake(calendar.frame.size.width, self.calendarHeight.constant);
}

#pragma mark - <FSCalendarDelegateAppearance>
- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date {
    NSString *dateStr = [date stringWithFormat:@"MM-dd"];
    if ([self.holiyDay objectForKey:@"holiday"] && ([date year] == [[NSDate date] year])) {
        if ([[self.holiyDay objectForKey:@"holiday"] objectForKey:dateStr]) {
            if ([[self.holiyDay objectForKey:@"holiday"] objectForKey:dateStr]) {
                if ([[[[self.holiyDay objectForKey:@"holiday"] objectForKey:dateStr] objectForKey:@"holiday"] boolValue]) {
                    return [UIColor colorWithHexString:@"38c88a"];
                }
                return [UIColor colorWithHexString:@"ff801a"];
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
                    return [UIColor colorWithHexString:@"38c88a"];
                }
                return [UIColor colorWithHexString:@"ff801a"];
            }
        }
    }
    return [UIColor whiteColor];
}


//- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderDefaultColorForDate:(NSDate *)date {
//    return [self.gregorian isDateInToday:date] ? appearance.todayColor : nil;
//}

//- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillSelectionColorForDate:(NSDate *)date {
//    return [UIColor clearColor];
//}

//- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderSelectionColorForDate:(NSDate *)date {
//    return appearance.selectionColor;
//}

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
    NSInteger day = [_lunarCalendar components:NSCalendarUnitDay fromDate:date].day;
    return _lunarChars[day-1];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    if (monthPosition != FSCalendarMonthPositionCurrent) {
        [calendar setCurrentPage:date animated:YES];
    }
}

- (IBAction)prevClicked:(id)sender {
    NSCalendarUnit unit = (self.calendar.scope==FSCalendarScopeMonth) ? NSCalendarUnitMonth : NSCalendarUnitWeekOfYear;
    NSDate *prevPage = [self.gregorian dateByAddingUnit:unit value:-1 toDate:self.calendar.currentPage options:0];
    [self.calendar setCurrentPage:prevPage animated:YES];
    
}

- (IBAction)nextClicked:(id)sender {
    NSCalendarUnit unit = (self.calendar.scope==FSCalendarScopeMonth) ? NSCalendarUnitMonth : NSCalendarUnitWeekOfYear;
    NSDate *nextPage = [self.gregorian dateByAddingUnit:unit value:1 toDate:self.calendar.currentPage options:0];
    [self.calendar setCurrentPage:nextPage animated:YES];
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

@end
