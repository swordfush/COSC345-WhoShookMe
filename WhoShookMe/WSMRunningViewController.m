//
//  WSMRunningViewController.m
//  WhoShookMe
//
//  Created by Maddy Mills on 25/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMRunningViewController.h"

#import "WSMAuthenticationViewController.h"

#import "WSMDetector.h"

@interface WSMRunningViewController ()

@end

@implementation WSMRunningViewController

const double kInitializationDelay = 5.0;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectionOccurred) name:[WSMDetector detectionOccurredEventName] object:nil];
    
    secondsElapsed = 0;
    [[self countdownProgressBar] setProgress:0.0];
    [[self countdownProgressBar] setHidden:NO];
    secondTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown) userInfo:nil repeats:NO];
}

- (void)countdown {
    secondsElapsed++;
    
    if (secondsElapsed >= kInitializationDelay) {
        [[self countdownProgressBar] setHidden:YES];
        [[WSMDetector instance] run];
    } else {
        [[self countdownProgressBar] setProgress:(secondsElapsed / kInitializationDelay) animated:YES];
        
        secondTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown) userInfo:nil repeats:NO];
    }
}

- (void)detectionOccurred {
    [self performSegueWithIdentifier:@"NeedsAuthenticationSegueID" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)triggerDetection:(id)sender {
    if (![[WSMDetector instance] isDetectorRunning]) {
        [secondTimer invalidate];
        secondTimer = nil;
        [[WSMDetector instance] run];
    }
    [[WSMDetector instance] triggerDetection];
}

- (void)viewDidUnload {
    [self setCountdownProgressBar:nil];
    [super viewDidUnload];
}

@end
