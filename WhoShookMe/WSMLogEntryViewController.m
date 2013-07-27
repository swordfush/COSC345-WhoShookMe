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
    }
    
    NSString *audioFilePath = [[self detectionInformation] getInformationItemWithKey:[WSMAudioInformation informationTypeIdentifier]];
    if (audioFilePath && [[NSFileManager defaultManager] fileExistsAtPath:audioFilePath]) {
        [[self playAudioButton] setHidden:NO];
        [[self playAudioButton] setTitle:@"Play Audio" forState:UIControlStateNormal];
        
        // XXX TODO: set up audio playback
    } else {
        [[self playAudioButton] setHidden:YES];
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
}

@end
