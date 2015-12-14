//
//  VideoSplashViewController.h
//  WebVideoForAppStart
//
//  Created by chanli on 15/12/12.
//  Copyright © 2015年 Beijing ChunFengShiLi Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,kScalingMode) {
    
    kScalingModeResize,
    kScalingModeResizeAspect,
    kScalingModeResizeAspectFill,
};


@interface VideoSplashViewController : UIViewController


@property (strong, nonatomic)NSURL *contentURL;

@property (assign, nonatomic)CGRect videoFrame;

@property (assign, nonatomic)CGFloat startTime;

@property (assign, nonatomic)CGFloat duration;

@property (strong, nonatomic)UIColor *backgroundColor;

@property (assign, nonatomic)BOOL sound;

@property (assign, nonatomic)CGFloat alpha;

@property (assign, nonatomic)BOOL alwaysRepeat;

@property (assign, nonatomic)kScalingMode fillMode;

@property (assign, nonatomic)BOOL restartForeground;

- (void)playVideo;

@end
