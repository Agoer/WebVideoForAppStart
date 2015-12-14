//
//  ViewController.m
//  WebVideoForAppStart
//
//  Created by chanli on 15/12/12.
//  Copyright © 2015年 Beijing ChunFengShiLi Technology Co., Ltd. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface ViewController ()

@property (nonatomic ,strong) AVPlayer *player;
@property (nonatomic ,strong) AVPlayerItem *playerItem;


@property (nonatomic ,strong) MPMoviePlayerController *moviePlayer;


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Launch" ofType:@"m4v"];
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    AVPlayerItem * playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    
    _player = [AVPlayer playerWithPlayerItem:playerItem];
                        
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    playerLayer.frame = self.view.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:playerLayer];
    [_player play];
    
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(runLoopTheMovie:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)runLoopTheMovie:(NSNotification *)n{
    //注册的通知  可以自动把 AVPlayerItem 对象传过来，只要接收一下就OK
    
    AVPlayerItem * p = [n object];
    //关键代码
    [p seekToTime:kCMTimeZero];
    
    [_player play];
    NSLog(@"重播");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
