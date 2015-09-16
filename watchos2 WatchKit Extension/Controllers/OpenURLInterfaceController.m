//
//  OpenURLInterfaceController.m
//  watchos2
//
//  Created by zhongzhendong on 15/9/16.
//  Copyright © 2015年 tudou.com. All rights reserved.
//

#import "OpenURLInterfaceController.h"

@interface OpenURLInterfaceController ()

@end

@implementation OpenURLInterfaceController

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

- (IBAction)onPhoneTapped {
    NSURL *url = [[NSURL alloc] initWithString:@"tel:"];
    [[WKExtension sharedExtension] openSystemURL:url];
}

- (IBAction)onSMSTapped {
    NSURL *url = [[NSURL alloc] initWithString:@"sms:"];
    [[WKExtension sharedExtension] openSystemURL:url];
}

@end



