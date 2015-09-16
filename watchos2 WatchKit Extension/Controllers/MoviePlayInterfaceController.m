//
//  RemoteMovieInterfaceController.m
//  watchos2
//
//  Created by zhongzhendong on 15/9/16.
//  Copyright © 2015年 tudou.com. All rights reserved.
//

#import "MoviePlayInterfaceController.h"

@interface MoviePlayInterfaceController ()<NSURLSessionDownloadDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceGroup *progressGroup;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *picker;

@end

@implementation MoviePlayInterfaceController

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

- (IBAction)onLocalTapped {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sample_clip1.m4v" ofType:nil];
    
    [self presentMediaPlayerControllerWithURL:[NSURL fileURLWithPath:filePath] options:nil completion:^(BOOL didPlayToEnd, NSTimeInterval endTime, NSError * _Nullable error) {
        NSLog(@"didPlaytoEnd:%@,error:%@",@(didPlayToEnd),error);
    }];
}

- (IBAction)onRemoteTapped {
//    [self downloadVideo:@"http://10.155.56.206:10240/welcome_video.mp4"];
    [self downloadVideo:@"https://github.com/randomite/AppleWatchTutorialSeries/blob/master/Tutorial_7_NativeWatchApp(VideoPlayer)/ObjC/NativeWatchApp/NativeWatchApp/test.mov?raw=true"];
}

#pragma mark- private

- (void)showProgressAnimation
{
    
//    [self.progressGroup setHidden:NO];
//    [self.picker setHidden:NO];
//    
//    NSMutableArray *images = [NSMutableArray array];
//    NSMutableArray *pickerItems = [NSMutableArray array];
//    for (NSInteger i=0; i<=36; i++) {
//        
//        NSString *name = [NSString stringWithFormat:@"progress-%d",i];
//        [images addObject:[UIImage imageNamed:name]];
//        
//        WKPickerItem *pickerItem = [[WKPickerItem alloc] init];
//        pickerItem.title = [NSString stringWithFormat:@"%d",i];
//        
//        [pickerItems addObject:pickerItem];
//    }
//    UIImage *progressImages = [UIImage animatedImageWithImages:images duration:0.0];
//    [self.progressGroup setBackgroundImage:progressImages];
//    [self.picker setCoordinatedAnimations:pickerItems];
//    
//    [self.picker setItems:pickerItems];
}


- (void)downloadVideo:(NSString *)urlString
{    
    NSURL *onlineURL = [NSURL URLWithString:urlString];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject
                                                                 delegate:self
                                                            delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDownloadTask *downloadTask = [defaultSession downloadTaskWithRequest:[[NSURLRequest alloc] initWithURL:onlineURL]];
    
    [downloadTask resume];
}

- (NSURL *)videoFileURL
{
    NSTimeInterval time = [[NSDate date] timeIntervalSinceReferenceDate];
    NSString *fileName = [NSString stringWithFormat:@"%d.mp4",(int)time];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *containerURL = [fileManager containerURLForSecurityApplicationGroupIdentifier:@"group.watchos2Demo.mediaGroup"];
    return [containerURL URLByAppendingPathComponent:fileName];
}

#pragma mark- NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    NSData *data = [NSData dataWithContentsOfURL:location];
    [data writeToURL:[self videoFileURL] atomically:NO];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentMediaPlayerControllerWithURL:[self videoFileURL] options:nil completion:^(BOOL didPlayToEnd, NSTimeInterval endTime, NSError * _Nullable error) {
            NSLog(@"didPlaytoEnd:%@,error:%@",@(didPlayToEnd),error);
        }];
    });
    NSLog(@"finish");
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    double   currentProgress = totalBytesWritten / ( double )totalBytesExpectedToWrite;
    NSLog(@"progress:%f",currentProgress);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showProgressAnimation];
    });
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"completed; error: %@", error);
}

@end



