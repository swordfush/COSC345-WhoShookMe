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
    NSMutableArray *notificationInfo = [WSMReflection createAnInstanceOfEveryImplementingClass:@protocol(WSMNotificationInfo)];
    NSMutableArray *notificationMethods = [WSMReflection createAnInstanceOfEveryImplementingClass:@protocol(WSMNotificationMethod)];
    
    // Initialise the detector and notifier
    self->detector = [[WSMDetector alloc] initWithDetectionMethods:detectionMethods AndInformationSources:notificationInfo];
    self->notifier = [[WSMNotifier alloc] initWithNotificationMethods:notificationMethods];
    
    NSLog(@"Found %i detection methods.", [detectionMethods count]);
    NSLog(@"Found %i notification information sources.", [notificationInfo count]);
    NSLog(@"Found %i notification methods.", [notificationMethods count]);
    
    // Begin running the detector
    [self runDetector];
}

- (void)runDetector {
    if (self->pollTimer == nil) {
        self->pollTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(checkForDetection) userInfo:nil repeats:YES];
    } else {
        NSLog(@"The detector was already running!");
    }
}

- (void)checkForDetection {
    // Obtain the detection info, if nil then no detection occurred
    NSMutableArray *info = [detector poll];
    if (info != nil) {
        NSLog(@"Detection occurred!");
        
        // Stop the timer, i.e. disable the detector
        [self->pollTimer invalidate];
        self->pollTimer = nil;
        
        // Notify the user
        [notifier notifyWithInformationSources:info];
        
        // Reset the detector so that we can simply start it again by calling [self runDetector]
        [detector reset];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@synthesize xCoord = _xCoord;
@synthesize yCoord = _yCoord;
@synthesize zCoord = _zCoord;


- (IBAction)clearButton:(id)sender {
    
}

- (void) viewDidAppear:(BOOL)animated {
    
}

- (void) viewDidDisappear:(BOOL)animated {
}



@end
