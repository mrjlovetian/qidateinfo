//
//  MRJCalendarWeekdayView.m
//  DateInfo
//
//  Created by MRJ on 2019/3/26.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "MRJCalendarWeekdayView.h"

@implementation MRJCalendarWeekdayView

- (void)configureAppearance {
    NSArray *weeks = @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    for (int i = 0; i < weeks.count; i++) {
        UILabel *label = self.weekdayLabels[i];
        label.font = [UIFont systemFontOfSize:14.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = weeks[i];
        label.textColor = [UIColor orangeColor];
    }
}

@end
