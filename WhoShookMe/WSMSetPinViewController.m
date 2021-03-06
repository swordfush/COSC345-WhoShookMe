//
//  WSMSetPinViewController.m
//  WhoShookMe
//
//  Created by Maddy Mills on 26/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMSetPinViewController.h"

#import "WSMAuthenticationPin.h"

#import "WSMGradientBackgrounds.h"

@interface WSMSetPinViewController ()

@end

@implementation WSMSetPinViewController


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

- (void)attemptPinNumberEntry:(int)chr {
    NSAssert(chr >= 0 && chr <= 9, @"The character should be an integer from 0 to 9");
    if ([[[self pinTextField] text] length] < 4) {
        [[self pinTextField] setText:[[[self pinTextField] text] stringByAppendingFormat:@"%i", chr]];
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
    [[self pinTextField] setText:@""];
}

- (IBAction)saveButtonPressed:(id)sender {
    if ([[[self pinTextField] text] length] == 4) {
        NSString *pinChangedMessage = [NSString stringWithFormat:@"WhoShookMe authentication pin changed to %@.", [[self pinTextField] text]];
        
        NSLog(@"%@", pinChangedMessage);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WhoShookMe Pin Changed" message:pinChangedMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        [[WSMAuthenticationPin instance] setPin:[[self pinTextField] text]];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Pin" message:@"The authentication pin must be 4 digits long." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    if (!gradient) {
//        gradient = [WSMGradientBackgrounds greyGradient];
        gradient = [WSMGradientBackgrounds reverseBlackGradient];
        [WSMGradientBackgrounds useBackground:gradient forController:self];
    }
    
    [[self backButton] setHidden:![[WSMAuthenticationPin instance] pinExists]];
    
    if ([[WSMAuthenticationPin instance] pinExists]) {
        [[self titleLabel] setText:@"Change Pin"];
    } else {
        [[self titleLabel] setText:@"Set Pin"];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    // This is needed as the gradient is initially oriented the wrong way when maximizing the app
    gradient.frame = self.view.bounds;
}

- (void)viewDidUnload {
    [self setPinTextField:nil];
    [self setBackButton:nil];
    [self setTitleLabel:nil];
    [super viewDidUnload];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    gradient.frame = self.view.bounds;
}

@end
