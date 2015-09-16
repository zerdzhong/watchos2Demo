//
//  RowController.m
//  watchos2
//
//  Created by zhongzhendong on 15/9/16.
//  Copyright © 2015年 tudou.com. All rights reserved.
//

#import "RowController.h"

@interface RowController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *textLabel;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *detailLabel;
@end

@implementation RowController

- (void)showItemTitle:(NSString *)titleString detail:(NSString *)detailString
{
    [self.textLabel setText:titleString];
    [self.detailLabel setText:detailString];
}

@end
