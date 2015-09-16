//
//  AudioRecAndPlayInterfaceController.m
//  watchos2
//
//  Created by zhongzhendong on 15/9/16.
//  Copyright © 2015年 tudou.com. All rights reserved.
//

#import "AudioRecAndPlayInterfaceController.h"

@interface AudioRecAndPlayInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *recordLabel;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *playLabel;
@end

@implementation AudioRecAndPlayInterfaceController

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

- (IBAction)onRecordTapped {
    
    [self presentAudioRecorderControllerWithOutputURL:[self recordFileURL] preset:WKAudioRecorderPresetNarrowBandSpeech options:nil completion:^(BOOL didSave, NSError * _Nullable error) {
        [self.recordLabel setText:[NSString stringWithFormat:@"didSave:%@,error:%@",@(didSave),error]];
    }];
    
}

- (IBAction)onPlayTapped {
    [self presentMediaPlayerControllerWithURL:[self recordFileURL] options:nil completion:^(BOOL didPlayToEnd, NSTimeInterval endTime, NSError * _Nullable error) {
        [self.playLabel setText:[NSString stringWithFormat:@"didPlayEnd:%@,error:%@",@(didPlayToEnd),error]];
    }];
}

#pragma mark- private

- (NSURL *)recordFileURL
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *containerURL = [fileManager containerURLForSecurityApplicationGroupIdentifier:@"group.watchos2Demo.mediaGroup"];
    return [containerURL URLByAppendingPathComponent:@"rec.m4a"];
}

@end



