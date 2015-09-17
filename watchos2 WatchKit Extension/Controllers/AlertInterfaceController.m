
//
//  AlertInterfaceController.m
//  watchos2
//
//  Created by zhongzhendong on 15/9/16.
//  Copyright © 2015年 tudou.com. All rights reserved.
//

#import "AlertInterfaceController.h"

@interface AlertInterfaceController ()

@end

@implementation AlertInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

#pragma mark- action
- (IBAction)onAlertTapped {
    [self showAlertControllerWithStyle:WKAlertControllerStyleAlert];
}

- (IBAction)onSideTapped {
    [self showAlertControllerWithStyle:WKAlertControllerStyleSideBySideButtonsAlert];
}

- (IBAction)onActionSheetTapped {
    [self showAlertControllerWithStyle:WKAlertControllerStyleActionSheet];
}

#pragma mark- private

- (void)showAlertControllerWithStyle:(WKAlertControllerStyle)style
{
    WKAlertAction *defaultAction = [WKAlertAction actionWithTitle:@"Default" style:WKAlertActionStyleDefault handler:^{
        NSLog(@"default");
    }];
    
    WKAlertAction *cancleAction = [WKAlertAction actionWithTitle:@"Cancle" style:WKAlertActionStyleCancel handler:^{
        NSLog(@"candle");
    }];
    
    WKAlertAction *destructiveAction = [WKAlertAction actionWithTitle:@"Destructive" style:WKAlertActionStyleDestructive handler:^{
        NSLog(@"Destructive");
    }];
    
    NSMutableArray *actions = [NSMutableArray arrayWithArray:@[defaultAction, destructiveAction]];
    
    // exactly two actions are needed for WKAlertControllerStyleSideBySideButtonsAlert
    if (style != WKAlertControllerStyleSideBySideButtonsAlert) {
        [actions addObject:cancleAction];
    }
    
    [self presentAlertControllerWithTitle:@"Hi Alert" message:@"Alert Message" preferredStyle:style actions:actions];
}

@end



