//
//  WSMHelpViewController.m
//  WhoShookMe
//
//  Created by Maddy Mills on 31/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMHelpViewController.h"

@interface WSMHelpViewController ()

@end

@implementation WSMHelpViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    NSString *description = @"WhoShookMe is an app to catch undesired people using your device.";
    NSString *howItWorks = @"It uses the accelerometer and device usage to detect a user. If they fail to enter the pin, or take too long, then it takes a picture of them, records audio and their GPS coordinates.";
    NSString *operation = @"To run the app, hit the run button. You have until the progress bar completes to put the device down. After that it is running. \n\nYou can view detections by viewing the log. Here you can see the information recorded when the detection occurred.";
    
    [[self helpTextLabel] setText:[NSString stringWithFormat:@"%@\n\n%@\n\n%@", description, howItWorks, operation]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidUnload {
    [self setHelpTextLabel:nil];
    [super viewDidUnload];
}

@end
