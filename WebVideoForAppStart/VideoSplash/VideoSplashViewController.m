//
//  VideoSplashViewController.m
//  WebVideoForAppStart
//
//  Created by chanli on 15/12/12.
//  Copyright © 2015年 Beijing ChunFengShiLi Technology Co., Ltd. All rights reserved.
//

#import "VideoSplashViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "VideoCutter.h"

@interface VideoSplashViewController ()

@property (strong, nonatomic)AVPlayerViewController *moviePlayer;

@property (assign, nonatomic)CGFloat moviePlayerSoundLevel;



@end

@implementation VideoSplashViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.moviePlayer.view.frame = self.videoFrame;
    self.moviePlayer.showsPlaybackControls = false;
    self.moviePlayer.view.userInteractionEnabled = false;
    [self.view addSubview:(self.moviePlayer.view)];
    [self.view sendSubviewToBack:(self.moviePlayer.view)];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setContentURL:(NSURL *)contentURL
{
    
//    NSString * resourcePath = [[NSBundle mainBundle] resourcePath];
//    NSString * videoPath = [resourcePath stringByAppendingPathComponent:@"test.mp4"];
//    NSURL* videoURL = [NSURL fileURLWithPath:videoPath];
//    
//     self.moviePlayer.player = [AVPlayer playerWithURL:videoURL];
//    
//    return;
    
    VideoCutter *videpCutter = [[VideoCutter alloc]init];
    [videpCutter cropVideoWithUrl:contentURL startTime:_startTime duration:_duration completion:^(NSURL *videoPath, NSError *error) {
        
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                    self.moviePlayer.player = [AVPlayer playerWithURL:contentURL];
                    [self.moviePlayer.player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];

                    
                });
                
        
            });

    }];
    
    
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    self.view.backgroundColor = backgroundColor;
}

- (void)setSound:(BOOL)sound
{
    self.moviePlayerSoundLevel = sound;
}

- (void)setAlpha:(CGFloat)alpha
{
    self.moviePlayer.view.alpha = alpha;
}

- (void)setAlwaysRepeat:(BOOL)alwaysRepeat
{
    if (alwaysRepeat) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:self.moviePlayer.player.currentItem];
        
    }
}

- (void)setFillMode:(kScalingMode)fillMode
{
    switch (fillMode) {
        case kScalingModeResize:
            self.moviePlayer.videoGravity = AVLayerVideoGravityResize;
            break;
        case kScalingModeResizeAspect:
            self.moviePlayer.videoGravity = AVLayerVideoGravityResizeAspect;
            break;

        case kScalingModeResizeAspectFill:
            self.moviePlayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            break;
    }
}

- (void)setRestartForeground:(BOOL)restartForeground
{
    if (restartForeground) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
}




- (void)playerItemDidReachEnd
{
    [self.moviePlayer.player seekToTime:kCMTimeZero];
    [self.moviePlayer.player play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (object == nil) {
        return;
    }
    
    if (![object isKindOfClass:[AVPlayer class]]) {
        return;
    }
    
    if (object != self.moviePlayer || ![keyPath  isEqual: @"status"]) {
        return;
    }
    
    if (self.moviePlayer.player.status == AVPlayerStatusReadyToPlay) {
        [self movieReadyToPlay];
    }
  
    
}

- (void)dealloc{

    [self.moviePlayer.player removeObserver:self forKeyPath:@"status"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)movieReadyToPlay
{
    
}

- (void)playVideo
{
    [self.moviePlayer.player play];
}

- (void)pauseVideo
{
    [self.moviePlayer.player pause];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
