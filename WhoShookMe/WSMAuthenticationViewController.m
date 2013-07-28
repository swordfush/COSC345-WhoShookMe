//
//  WSMAuthenticationViewController.m
//  WhoShookMe
//
//  Created by Maddy Mills on 25/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMAuthenticationViewController.h"

#import "WSMAuthenticationPin.h"
#import "WSMDetector.h"

#import "WSMGradientBackgrounds.h"

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

- (void)viewWillAppear:(BOOL)animated {
    if (!gradient) {
        gradient = [WSMGradientBackgrounds greyGradient];
        [WSMGradientBackgrounds useBackground:gradient forController:self];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    gradient.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)attemptAuthentication:(id)sender {
    if ([[[self pinInputTextField] text] length] == 4) {
        if ([[WSMAuthenticationPin instance] authenticate:[[self pinInputTextField] text]]) {
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
    
    [self performSegueWithIdentifier:@"AuthenticatedSegueID" sender:self];
}

- (void)failedAuthentication {
    NSLog(@"Failed authentication");
    
    [[self pinInputTextField] setText:@""];
    
    if ([[WSMDetector instance] hasPendingDetection]) {
        [[WSMDetector instance] forceNotification];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Pin" message:@"The pin number entered is incorrect." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidUnload {
    [self setPinInputTextField:nil];
    [super viewDidUnload];
}

@end
