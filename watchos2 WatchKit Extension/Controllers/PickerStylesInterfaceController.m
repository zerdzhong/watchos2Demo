//
//  PickerStylesInterfaceController.m
//  watchos2
//
//  Created by zhongzhendong on 15/9/16.
//  Copyright © 2015年 tudou.com. All rights reserved.
//

#import "PickerStylesInterfaceController.h"

@interface PickerStylesInterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *listPicker;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *stackPicker;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *sequencePicker;

@property (nonatomic, strong) NSMutableArray *pickerItems;

@end

@implementation PickerStylesInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    
    self.pickerItems = [NSMutableArray array];
    
    for (NSInteger i=1; i<=10; i++) {
        WKPickerItem *pickerItem = [[WKPickerItem alloc] init];
        
        NSString *imageName = [NSString stringWithFormat:@"m%d",i];
        WKImage *image = [WKImage imageWithImageName:imageName];
        
        // Text to show when the item is being displayed in a picker with the 'List' style.
        pickerItem.title = imageName;
        
        // Caption to show for the item when focus style includes a caption callout.
        pickerItem.caption = imageName;
        
        // An accessory image to show next to the title in a picker with the 'List' style.
        // Note that the image will be scaled and centered to fit within an 13×13pt rect.
        pickerItem.accessoryImage = image;
        
        // A custom image to show for the item, used instead of the title + accessory
        // image when more flexibility is needed, or when displaying in the stack or
        // sequence style. The image will be scaled and centered to fit within the
        // picker's bounds or item row bounds.
        pickerItem.contentImage = image;
        
        [self.pickerItems addObject:pickerItem];
    }
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    [self.listPicker setItems:self.pickerItems];
    [self.sequencePicker setItems:self.pickerItems];
    [self.stackPicker setItems:self.pickerItems];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



