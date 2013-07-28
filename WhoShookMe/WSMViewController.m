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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appRestored) name:[WSMAppDelegate appRestoredEventName] object:nil];
}

- (void)appRestored {
    if ([[WSMAuthenticationPin instance] pinExists]) {
        [self performSegueWithIdentifier:@"RequiresAuthenticationSegueID" sender:self];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WhoShookMe Requires a Pin Number" message:@"WhoShookMe uses a pin number to identify the real user. Pin numbers are 4 digits long, and should be different to any pin numbers you use on your device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [self performSegueWithIdentifier:@"RequiresPinSegueID" sender:self];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    if (logoutTimer != nil) {
        [logoutTimer invalidate];
        logoutTimer = nil;
    }
    logoutTimer = [NSTimer scheduledTimerWithTimeInterval:kLogoutDelay target:self selector:@selector(logOut) userInfo:nil repeats:NO];
}

- (void) viewDidDisappear:(BOOL)animated {
    [logoutTimer invalidate];
    logoutTimer = nil;
}

- (void)logOut {
    if ([self presentedViewController] == nil) {
        NSLog(@"Logging out user");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Inactive For Too Long" message:[NSString stringWithFormat:@"You have been inactive for over %.0f seconds, and will need to re-enter your pin number to use WhoShookMe.", kLogoutDelay] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [self performSegueWithIdentifier:@"RequiresAuthenticationSegueID" sender:self];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    if (!gradient) {
        gradient = [WSMGradientBackgrounds reverseBlackGradient];
        [WSMGradientBackgrounds useBackground:gradient forController:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ChangePinPressedSegueID"]) {
        WSMSetPinViewController *pinController = [segue destinationViewController];
        [pinController setCanUseBackButton:YES];
    } else if ([[segue identifier] isEqualToString:@"RequiresPinSegueID"]) {
        WSMSetPinViewController *pinController = [segue destinationViewController];
        [pinController setCanUseBackButton:NO];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    gradient.frame = self.view.bounds;
}


@end
