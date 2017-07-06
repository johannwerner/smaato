//
//  TimeHelper.m
//  Smaato
//
//  Created by Johann Werner on 06.07.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "TimeHelper.h"

@implementation TimeHelper

+ (NSString *)relativeDateStringForDate:(NSDate *)date
{
    NSCalendarUnit units = NSCalendarUnitMinute|NSCalendarUnitHour|NSCalendarUnitDay | NSCalendarUnitWeekOfYear |
    NSCalendarUnitMonth | NSCalendarUnitYear;
    
  
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units
                                                                   fromDate:date
                                                                     toDate:[NSDate date]
                                                                    options:0];
    
    if (components.year > 0) {
        NSString *localizedDateTime = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
        return localizedDateTime;
    } else if (components.month > 0) {
        return [NSString stringWithFormat:NSLocalizedString(@"MonthsAgoKey", nil), (long)components.month];
    } else if (components.weekOfYear > 0) {
        return [NSString stringWithFormat:NSLocalizedString(@"WeeksAgoKey", nil), (long)components.weekOfYear];
    } else if (components.day > 0) {
        if (components.day > 1) {
            return [NSString stringWithFormat:NSLocalizedString(@"DaysAgoKey", nil), (long)components.day];
        } else {
            return NSLocalizedString(@"YesterdayKey", nil);
        }
    }  else if (components.hour > 0) {
        return [NSString stringWithFormat:NSLocalizedString(@"HoursAgoKey", nil), (long)components.hour];
    } else if (components.minute > 0) {
        return [NSString stringWithFormat:NSLocalizedString(@"MinutesAgoKey", nil), (long)components.minute];
    }else {
        return NSLocalizedString(@"JustNowKey", nil);
    }
}

@end
