//
//  WSMLogEntryViewController.m
//  WhoShookMe
//
//  Created by Maddy Mills on 27/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMLogEntryViewController.h"

#import "WSMTimeInformation.h"
#import "WSMGPSInformation.h"
#import "WSMAudioInformation.h"
#import "WSMPhotoInformation.h"

#import "WSMGradientBackgrounds.h"

@interface WSMLogEntryViewController ()

@end

@implementation WSMLogEntryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSAssert([self detectionInformation] != nil, @"No log entry was set to be displayed");
    
    NSString *time = [[self detectionInformation] getInformationItemWithKey:[WSMTimeInformation informationTypeIdentifier]];
    NSString *loc = [[self detectionInformation] getInformationItemWithKey:[WSMGPSInformation informationTypeIdentifier]];
    
    if (time) {
        [[self timeLabel] setText:time];
    } else {
        [[self timeLabel] setText:@"Unknown"];
    }
    
    if (loc) {
        [[self locationLabel] setText:loc];
    } else {
        [[self locationLabel] setText:@"Unknown"];
    }
    
    NSString *imageFilePath = [[self detectionInformation] getInformationItemWithKey:[WSMPhotoInformation informationTypeIdentifier]];

    if (imageFilePath && [[NSFileManager defaultManager] fileExistsAtPath:imageFilePath]) {
        [[self imageView] setImage:[UIImage imageWithContentsOfFile:imageFilePath]];
    } else {
        [[self imageView] setImage:[UIImage imageNamed:@"NoImage.jpg"]];
    }
    
    [[self playAudioButton] setHidden:YES];
    NSString *audioFilePath = [[self detectionInformation] getInformationItemWithKey:[WSMAudioInformation informationTypeIdentifier]];
    if (audioFilePath && [[NSFileManager defaultManager] fileExistsAtPath:audioFilePath]) {
        NSError *error = nil;
        
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
        
        if (error == nil) {
            audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audioFilePath] error:&error];
            
            if (error == nil) {
                [audioPlayer setDelegate:self];
                
                [[self playAudioButton] setHidden:NO];
                [[self playAudioButton] setTitle:@"Play Audio" forState:UIControlStateNormal];
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@synthesize detectionInformation = _detectionInformation;

- (void)viewDidUnload {
    [self setImageView:nil];
    [self setTimeLabel:nil];
    [self setLocationLabel:nil];
    [self setPlayAudioButton:nil];
    [super viewDidUnload];
}

- (IBAction)playAudioPressed:(id)sender {
    NSAssert(audioPlayer, @"The play audio button was visible when there was no audio available.");
    if (audioPlayer.isPlaying) {
        [audioPlayer stop];
        
        [[self playAudioButton] setTitle:@"Resume Playback" forState:UIControlStateNormal];
    } else {
        [audioPlayer play];
        
        [[self playAudioButton] setTitle:@"Pause Playback" forState:UIControlStateNormal];
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    if (audioPlayer && [audioPlayer isPlaying]) {
        [audioPlayer stop];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag {
    [[self playAudioButton] setTitle:@"Play Again" forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {
    if (!gradient) {
        gradient = [WSMGradientBackgrounds reverseBlackGradient];
        [WSMGradientBackgrounds useBackground:gradient forController:self];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    gradient.frame = self.view.bounds;
}

@end
