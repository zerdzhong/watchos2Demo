//
//  ComplicationController.m
//  watchos2 WatchKit Extension
//
//  Created by zhongzhendong on 15/9/16.
//  Copyright © 2015年 tudou.com. All rights reserved.
//

#import "ComplicationController.h"

@interface ComplicationController ()

@end

@implementation ComplicationController

#pragma mark - Timeline Configuration

- (void)getSupportedTimeTravelDirectionsForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTimeTravelDirections directions))handler {
    handler(CLKComplicationTimeTravelDirectionForward|CLKComplicationTimeTravelDirectionBackward);
}

- (void)getTimelineStartDateForComplication:(CLKComplication *)complication withHandler:(void(^)(NSDate * __nullable date))handler {
    handler(nil);
}

- (void)getTimelineEndDateForComplication:(CLKComplication *)complication withHandler:(void(^)(NSDate * __nullable date))handler {
    handler(nil);
}

- (void)getPrivacyBehaviorForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationPrivacyBehavior privacyBehavior))handler {
    handler(CLKComplicationPrivacyBehaviorShowOnLockScreen);
}

#pragma mark - Timeline Population

- (void)getCurrentTimelineEntryForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTimelineEntry * __nullable))handler {
    // Call the handler with the current timeline entry
    
    // Get the current complication data from the extension delegate.
    
    CLKComplicationTimelineEntry* entry = nil;
    NSDate* now = [NSDate date];
    
    // Create the template and timeline entry.
    if (complication.family == CLKComplicationFamilyModularLarge) {
        CLKComplicationTemplateModularLargeStandardBody* t =
        [[CLKComplicationTemplateModularLargeStandardBody alloc] init];
        t.headerTextProvider = [CLKSimpleTextProvider textProviderWithText:@"Hello World"];
        t.body1TextProvider = [CLKSimpleTextProvider textProviderWithText:@"now"];
        t.body2TextProvider = [CLKTimeIntervalTextProvider textProviderWithStartDate:[NSDate date] endDate:[NSDate dateWithTimeIntervalSinceNow:((6*60*60)+(18*60))]];
        
        // Create the entry.
        entry = [CLKComplicationTimelineEntry entryWithDate:now
                                       complicationTemplate:t];
    }
    else {
        // ...configure entries for other complication families.
    }
    
    // Pass the timeline entry back to ClockKit.
    handler(entry);
}

- (void)getTimelineEntriesForComplication:(CLKComplication *)complication beforeDate:(NSDate *)date limit:(NSUInteger)limit withHandler:(void(^)(NSArray<CLKComplicationTimelineEntry *> * __nullable entries))handler {
    // Call the handler with the timeline entries prior to the given date
    handler(nil);
}

- (void)getTimelineEntriesForComplication:(CLKComplication *)complication afterDate:(NSDate *)date limit:(NSUInteger)limit withHandler:(void(^)(NSArray<CLKComplicationTimelineEntry *> * __nullable entries))handler {
    // Call the handler with the timeline entries after to the given date
    
    CLKComplicationTimelineEntry* entry1 = nil;
    CLKComplicationTimelineEntry* entry2 = nil;
    NSDate* oneMin = [NSDate dateWithTimeInterval:60*10 sinceDate:date];
    NSDate* twoMin = [NSDate dateWithTimeIntervalSinceNow:60*2];
    
    // Create the template and timeline entry.
    if (complication.family == CLKComplicationFamilyModularLarge) {
        CLKComplicationTemplateModularLargeStandardBody* t =
        [[CLKComplicationTemplateModularLargeStandardBody alloc] init];
        t.headerTextProvider = [CLKSimpleTextProvider textProviderWithText:@"Hello World"];
        t.body1TextProvider = [CLKSimpleTextProvider textProviderWithText:@"十分钟过去了"];
        
        // Create the entry.
        entry1 = [CLKComplicationTimelineEntry entryWithDate:oneMin
                                       complicationTemplate:t];
        
        CLKComplicationTemplateModularLargeStandardBody* t1 =
        [[CLKComplicationTemplateModularLargeStandardBody alloc] init];
        t1.headerTextProvider = [CLKSimpleTextProvider textProviderWithText:@"Hello World"];
        t1.body1TextProvider = [CLKSimpleTextProvider textProviderWithText:@"两分钟过去了"];
        
        // Create the entry.
        entry2 = [CLKComplicationTimelineEntry entryWithDate:twoMin
                                       complicationTemplate:t1];
    }
    else {
        // ...configure entries for other complication families.
    }

    
    
    handler(@[entry1,entry2]);
}

#pragma mark Update Scheduling

- (void)getNextRequestedUpdateDateWithHandler:(void(^)(NSDate * __nullable updateDate))handler {
    // Call the handler with the date when you would next like to be given the opportunity to update your complication content
    handler(nil);
}

#pragma mark - Placeholder Templates

- (void)getPlaceholderTemplateForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTemplate * __nullable complicationTemplate))handler {
    // This method will be called once per supported complication, and the results will be cached
    handler(nil);
}

@end
