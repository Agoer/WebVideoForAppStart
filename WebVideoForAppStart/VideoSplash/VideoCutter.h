//
//  VideoCutter.h
//  WebVideoForAppStart
//
//  Created by chanli on 15/12/12.
//  Copyright © 2015年 Beijing ChunFengShiLi Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef  void (^completionUrlBlock)(NSURL *videoPath, NSError *error);

@interface VideoCutter : NSObject

- (void)cropVideoWithUrl:(NSURL *)videoUrl startTime:(CGFloat)startTime duration:(CGFloat)duration completion:(completionUrlBlock)block;

@end
