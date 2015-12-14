//
//  VideoCutter.m
//  WebVideoForAppStart
//
//  Created by chanli on 15/12/12.
//  Copyright © 2015年 Beijing ChunFengShiLi Technology Co., Ltd. All rights reserved.
//

#import "VideoCutter.h"
#import <AVFoundation/AVFoundation.h>

@implementation VideoCutter

- (void)cropVideoWithUrl:(NSURL *)videoUrl startTime:(CGFloat)startTime duration:(CGFloat)durationTime completion:(completionUrlBlock)block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        AVURLAsset *asset = [[AVURLAsset alloc]initWithURL:videoUrl options:nil];
        AVAssetExportSession *exportSesstion = [[AVAssetExportSession alloc]initWithAsset:asset presetName:@"AVAssetExportPresetHighestQuality"];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, true);
        
        NSString *outPutURL = paths[0];
        
        NSFileManager *filemanager = [NSFileManager defaultManager];
        
        NSError *error;
        [filemanager createDirectoryAtPath:outPutURL withIntermediateDirectories:YES attributes:nil error:&error];
        
        outPutURL = [outPutURL stringByAppendingPathComponent:@"output.mp4"];
        
        [filemanager removeItemAtPath:outPutURL error:&error];
        
        [exportSesstion setOutputURL:[NSURL fileURLWithPath:outPutURL]];
        
        exportSesstion.shouldOptimizeForNetworkUse = YES;
        
        exportSesstion.outputFileType = AVFileTypeMPEG4;
        
        CMTime start = CMTimeMakeWithSeconds((Float64)startTime, 600);
        CMTime duration = CMTimeMakeWithSeconds((Float64)durationTime, 600);
        
        CMTimeRange range = CMTimeRangeMake(start, duration);
        
        exportSesstion.timeRange = range;
        [exportSesstion exportAsynchronouslyWithCompletionHandler:^{
            switch (exportSesstion.status) {
                case AVAssetExportSessionStatusCompleted:
                    block(exportSesstion.outputURL,error);
                    break;
                case AVAssetExportSessionStatusFailed:
                    NSLog(@"Failed:%@",exportSesstion.error);
                    break;
                case AVAssetExportSessionStatusCancelled:
                     NSLog(@"Failed:%@",exportSesstion.error);
                    break;
                default:
                     NSLog(@"default:Failed");
                    break;
            }
            
        }];
        
      dispatch_async(dispatch_get_main_queue(), ^{
          
      });
        
    });
    
}

@end
