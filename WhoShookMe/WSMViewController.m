//
//  WSMViewController.m
//  WhoShookMe
//
//  Created by P Dev on 3/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMViewController.h"

#import "WSMReflection.h"


@interface WSMViewController ()

@end

@implementation WSMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Use reflection to create an instance of every detection method, notification information source, and notification method.
    // This works well since we only ever need a single instance of each.
    NSMutableArray *detectionMethods = [WSMReflection createAnInstanceOfEveryImplementingClass:@protocol(WSMDetectionMethod)];
    self->infoSources = [WSMReflection createAnInstanceOfEveryImplementingClass:@protocol(WSMInformationSource)];
    NSMutableArray *notificationMethods = [WSMReflection createAnInstanceOfEveryImplementingClass:@protocol(WSMNotificationMethod)];
    
    // Initialise the detector and notifier
    self->detector = [[WSMDetector alloc] initWithDetectionMethods:detectionMethods];
    self->notifier = [[WSMNotifier alloc] initWithNotificationMethods:notificationMethods];
    
    NSLog(@"Found %i detection methods.", [detectionMethods count]);
    NSLog(@"Found %i notification information sources.", [self->infoSources count]);
    NSLog(@"Found %i notification methods.", [notificationMethods count]);
    
    self->requiresAuthentication = false;
}

- (void)runDetector {
    if (self->pollTimer == nil) {
        self->pollTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(beginDetecting) userInfo:nil repeats:NO];
        NSLog(@"Detection started");
        [self.runButton setTitle:@"Initializing" forState:UIControlStateNormal];
    } else {
        NSLog(@"The detector was already running!");
    }
}

- (void)failedToAuthenticate {
    // Notify the user
    [notifier notifyWithInformationSources:self->infoSources];
    [self.runButton setTitle:@"Run (Detected)" forState:UIControlStateNormal];
}

- (void)authenticate {
    // Invalidate the authentication timer
    if (self->authTimer != nil) {
        [self->authTimer invalidate];
        self->authTimer = nil;
        [self.runButton setTitle:@"Run" forState:UIControlStateNormal];
    }
}

- (void)beginDetecting {
    NSLog(@"Starting detector");
    [self.runButton setTitle:@"Running" forState:UIControlStateNormal];
    if (self->pollTimer != nil) {
        [self->pollTimer invalidate];
        self->pollTimer = nil;
    }
    self->pollTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(checkForDetection) userInfo:nil repeats:YES];
}

- (void)checkForDetection {
    // Obtain the detection info, if nil then no detection occurred
    if ([detector poll]) {
        NSLog(@"Detection occurred! Waiting on user authentication.");
        [self.runButton setTitle:@"Authenticating" forState:UIControlStateNormal];
        
        // Stop the timer, i.e. disable the detector
        [self->pollTimer invalidate];
        self->pollTimer = nil;
        
        // Reset the detector so that we can simply start it again by calling [self runDetector]
        [detector reset];
        
        // Start the authetication timer
        self->authTimer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(failedToAuthenticate) userInfo:nil repeats:false];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)viewLogButtonClicked:(id)sender {

}

- (IBAction)runButtonClicked:(id)sender {
    if (self->authTimer != nil) {
        [self authenticate];
    } else {
        [self runDetector];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    
}

- (void) viewDidDisappear:(BOOL)animated {
}



@end
