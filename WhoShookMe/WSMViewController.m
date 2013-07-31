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
        [self requireAuthentication];
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
    [self dismissViewControllerAnimated:NO completion:^ {
        [self requireAuthentication];
    }];
}
    
- (void)requireAuthentication {
    if ([[WSMAuthenticationPin instance] pinExists]) {
        [self performSegueWithIdentifier:@"RequiresAuthenticationSegueID" sender:self];
    } else {
        NSLog(@"Application pin does not exist. Prompting user for pin.");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WhoShookMe Requires a Pin Number" message:@"WhoShookMe uses a pin number to identify the real user.\nPin numbers are 4 digits long, and should be different to any other pin numbers you use on your device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

        [self performSegueWithIdentifier:@"ChangePinSegueID" sender:self];
    }
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

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    logoutTimer = [NSTimer scheduledTimerWithTimeInterval:kLogoutDelay target:self selector:@selector(logOut) userInfo:nil repeats:NO];
}

@end
