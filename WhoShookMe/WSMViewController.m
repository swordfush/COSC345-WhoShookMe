//
//  WSMViewController.m
//  WhoShookMe
//
//  Created by P Dev on 3/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMViewController.h"

#import "WSMAppDelegate.h"

#import "WSMGradientBackgrounds.h"

#import "WSMAuthenticationPin.h"
#import "WSMSetPinViewController.h"

@interface WSMViewController ()

@end

@implementation WSMViewController


const double kLogoutDelay = 30.0;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appMinimized) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appRestored) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    hasRunInitialAuthentication = NO;
}

- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:UIApplicationDidEnterBackgroundNotification];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    if (!gradient) {
        gradient = [WSMGradientBackgrounds reverseBlackGradient];
        [WSMGradientBackgrounds useBackground:gradient forController:self];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    // Force gradient to draw correctly, it doesn't the first time around
    gradient.frame = self.view.bounds;
    
    if (!hasRunInitialAuthentication) {
        if (![[WSMAuthenticationPin instance] pinExists]) {
            NSLog(@"Application pin does not exist. Prompting user for pin.");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WhoShookMe Requires a Pin Number" message:@"WhoShookMe uses a pin number to identify the real user.\nPin numbers are 4 digits long, and should be different to any other pin numbers you use on your device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            [self performSegueWithIdentifier:@"ChangePinSegueID" sender:self];
        } else {
            [self performSegueWithIdentifier:@"RequiresAuthenticationSegueID" sender:self];
        }
        
        hasRunInitialAuthentication = true;
    }
    
    [self invalidateLogoutTimer];
    
    logoutTimer = [NSTimer scheduledTimerWithTimeInterval:kLogoutDelay target:self selector:@selector(logOut) userInfo:nil repeats:NO];
}


- (void)viewDidDisappear:(BOOL)animated {
    [self invalidateLogoutTimer];
}

- (void)appMinimized {
    [self invalidateLogoutTimer];
}

- (void)appRestored {
    NSLog(@"Restored");
    [self dismissViewControllerAnimated:NO completion:nil];
    [self performSegueWithIdentifier:@"RequiresAuthenticationSegueID" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logOut {
    if ([self presentedViewController] == nil) {
        NSLog(@"Logging out the user as they have been inactive on the main menu for over %.0f seconds", kLogoutDelay);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Inactive For Too Long" message:[NSString stringWithFormat:@"You have been inactive for over %.0f seconds, and will need to re-enter your pin number to use WhoShookMe.", kLogoutDelay] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [self performSegueWithIdentifier:@"RequiresAuthenticationSegueID" sender:self];
    }
}

- (void)invalidateLogoutTimer {
    if (logoutTimer != nil) {
        [logoutTimer invalidate];
        logoutTimer = nil;
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    gradient.frame = self.view.bounds;
}

- (IBAction)helpButtonPressed:(id)sender {
    NSString *description = @"WhoShookMe is an app to catch undesired people using your device.";
    NSString *howItWorks = @"It uses the accelerometer and device usage to detect a user. If they fail to enter the pin, or take too long, then it takes a picture of them, records audio and their GPS coordinates.";
    NSString *operation = @"To run the app, hit the run button. You have until the progress bar completes to put the device down. After that it is running. \n\nYou can view detections by viewing the log. Here you can see the information recorded when the detection occurred.";
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WhoShookMe Help" message:[NSString stringWithFormat:@"%@\n\n%@\n\n%@", description, howItWorks, operation] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert setDelegate:self];
    [self invalidateLogoutTimer];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    logoutTimer = [NSTimer scheduledTimerWithTimeInterval:kLogoutDelay target:self selector:@selector(logOut) userInfo:nil repeats:NO];
}

@end
