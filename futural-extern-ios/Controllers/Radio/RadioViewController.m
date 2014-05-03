//
//  RadioViewController.m
//  Lundakarneval
//
//  Created by Richard Luong on 2014-05-03.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "RadioViewController.h"
#import "LKLayout.h"
#import <AVFoundation/AVFoundation.h>

@interface RadioViewController ()
@property (strong, nonatomic) AVPlayer *player;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@end

@implementation RadioViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [LKLayout defaultTitle];
    
}

- (IBAction)playButtonPressed:(id)sender {
    
    [self togglePlayPause];
    
}

- (void)togglePlayPause {
    
    BOOL isPlaying = (self.player.rate == 1.0);
    
    if(isPlaying) {
        [self.player pause];
        [self.playPauseButton setImage:[UIImage imageNamed:@"radio-play"] forState:UIControlStateNormal];
    } else {
        [self.playPauseButton setImage:[UIImage imageNamed:@"radio-pause"] forState:UIControlStateNormal];
        [self.player play];
    }
    
}

-(AVPlayer *)player {
    NSURL *fileURL = [[NSURL alloc] initWithString:@"http://webradio.af.lu.se:8000/;stream/1"];
    
    if (!_player) _player = [[AVPlayer alloc] initWithURL:fileURL];
    return _player;
}

@end
