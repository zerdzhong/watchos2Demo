//
//  InterfaceController.m
//  watchos2 WatchKit Extension
//
//  Created by zhongzhendong on 15/9/16.
//  Copyright © 2015年 tudou.com. All rights reserved.
//

#import "InterfaceController.h"
#import "RowController.h"

static NSString * kItemKeyTitle       = @"title";
static NSString * kItemKeyDetail      = @"detail";
static NSString * kItemKeyClassPrefix = @"prefix";


@interface InterfaceController()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;

@property (nonatomic, strong)NSArray *items;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    
    self.items = @[
                   @{
                       kItemKeyTitle: @"Audio Rec & Play",
                       kItemKeyDetail: @"Record and play audio.",
                       kItemKeyClassPrefix: @"AudioRecAndPlay",
                       },
                   @{
                       kItemKeyTitle: @"Picker Styles",
                       kItemKeyDetail: @"WKInterfacePicker styles catalog.",
                       kItemKeyClassPrefix: @"PickerStyles",
                       },
                   
                   @{
                       kItemKeyTitle: @"Alert",
                       kItemKeyDetail: @"Present an alert or action sheet.",
                       kItemKeyClassPrefix: @"Alert",
                       },
                   @{
                       kItemKeyTitle: @"Interactive Messaging",
                       kItemKeyDetail: @"Sending message to phone and receiving from phone demo with WatchConnectivity.",
                       kItemKeyClassPrefix: @"MessageToPhone",
                       },
                   @{
                       kItemKeyTitle: @"Open System URL",
                       kItemKeyDetail: @"Open Tel or SMS app using openSystemURL: method.",
                       kItemKeyClassPrefix: @"OpenSystemURL",
                       },
                   @{
                       kItemKeyTitle: @"Audio File Player",
                       kItemKeyDetail: @"Play an audio file with WKAudioFilePlayer.",
                       kItemKeyClassPrefix: @"AudioFilePlayer",
                       }
                   ];
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    [self loadTableItems];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

#pragma mark- private

- (void)loadTableItems
{
    [self.table setNumberOfRows:[self.items count] withRowType:@"Cell"];
    
    for (NSInteger i = 0; i < [self.items count]; i++) {
        RowController *row = [self.table rowControllerAtIndex:i];
        [row showItemTitle:[[self.items objectAtIndex:i] objectForKey:kItemKeyTitle] detail:[[self.items objectAtIndex:i] objectForKey:kItemKeyDetail]];
    }
}

#pragma mark- WKInterfaceTableDelegate
-(void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex
{
    NSString *classPrefix = [[self.items objectAtIndex:rowIndex] objectForKey:kItemKeyClassPrefix];
    [self pushControllerWithName:classPrefix context:nil];
}

@end



