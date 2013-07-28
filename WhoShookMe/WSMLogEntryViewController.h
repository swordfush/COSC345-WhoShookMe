//
//  WSMLogEntryViewController.h
//  WhoShookMe
//
//  Created by Maddy Mills on 27/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "WSMDetectionInformation.h"

@interface WSMLogEntryViewController : UIViewController <AVAudioPlayerDelegate> {
    AVAudioPlayer *audioPlayer;
}

@property WSMDetectionInformation *detectionInformation;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UIButton *playAudioButton;
- (IBAction)playAudioPressed:(id)sender;



@end
