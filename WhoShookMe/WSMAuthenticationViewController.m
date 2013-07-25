//
//  WSMAuthenticationViewController.m
//  WhoShookMe
//
//  Created by Maddy Mills on 25/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMAuthenticationViewController.h"

#import "WSMViewController.h"

#import "WSMDetector.h"

@interface WSMAuthenticationViewController ()

@end

@implementation WSMAuthenticationViewController

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
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)attemptAuthentication:(id)sender {
    if ([[[self pinInputTextField] text] length] == 4) {
        if ([[[self pinInputTextField] text] isEqual:@"1234"]) {
            [self successfulAuthentication];
        } else {
            [self failedAuthentication];
        }
    }
}

- (void)attemptPinNumberEntry:(int)chr {
    NSAssert(chr >= 0 && chr <= 9, @"The character should be an integer from 0 to 9");
    if ([[[self pinInputTextField] text] length] < 4) {
        [[self pinInputTextField] setText:[[[self pinInputTextField] text] stringByAppendingFormat:@"%i", chr]];
    }
}

- (IBAction)button1Pressed:(id)sender {
    [self attemptPinNumberEntry:1];
}

- (IBAction)button2Pressed:(id)sender {
    [self attemptPinNumberEntry:2];
}

- (IBAction)button3Pressed:(id)sender {
    [self attemptPinNumberEntry:3];
}

- (IBAction)button4Pressed:(id)sender {
    [self attemptPinNumberEntry:4];
}

- (IBAction)button5Pressed:(id)sender {
    [self attemptPinNumberEntry:5];
}

- (IBAction)button6Pressed:(id)sender {
    [self attemptPinNumberEntry:6];
}

- (IBAction)button7Pressed:(id)sender {
    [self attemptPinNumberEntry:7];
}

- (IBAction)button8Pressed:(id)sender {
    [self attemptPinNumberEntry:8];
}

- (IBAction)button9Pressed:(id)sender {
    [self attemptPinNumberEntry:9];
}

- (IBAction)button0Pressed:(id)sender {
    [self attemptPinNumberEntry:0];
}

- (IBAction)clearButtonPressed:(id)sender {
    [[self pinInputTextField] setText:@""];
}

- (void)successfulAuthentication {
    if ([[WSMDetector instance] hasPendingDetection]) {
        [[WSMDetector instance] cancelPendingDetection];
    }
    
    WSMViewController *controller = (WSMViewController*)[[self storyboard] instantiateViewControllerWithIdentifier:@"MainViewID"];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)failedAuthentication {
    NSLog(@"Failed authentication");
    if ([[WSMDetector instance] hasPendingDetection]) {
        [[WSMDetector instance] forceDetection];
    }
}

- (void)viewDidUnload {
    [self setPinInputTextField:nil];
    [self setAuthenticateButton:nil];
    [super viewDidUnload];
}

@end
