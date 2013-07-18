//
//  WSMViewController.m
//  WhoShookMe
//
//  Created by P Dev on 3/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMViewController.h"

#import "WSMReflection.h"
#import "WSMDetector.h"


@interface WSMViewController ()

@end

@implementation WSMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectionOccurred) name:[WSMDetector detectionOccurredName] object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectionNotified) name:[WSMDetector detectionNotifiedName] object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectionCancelled) name:[WSMDetector detectionCancelledName] object:nil];
}

- (void)detectionOccurred {
    [self.runButton setTitle:@"[Requires Authentication]" forState:UIControlStateNormal];
}

- (void)detectionNotified {
    [self.runButton setTitle:@"Run [Notified]" forState:UIControlStateNormal];
}

- (void)detectionCancelled {
    [self.runButton setTitle:@"Run [Authenticated]" forState:UIControlStateNormal];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)viewLogButtonClicked:(id)sender {

}

- (IBAction)runButtonClicked:(id)sender {
    if ([[WSMDetector instance] isDetectorRunning]) {
        [[WSMDetector instance] forceDetection];
    } else if ([[WSMDetector instance] hasPendingDetection]) {
        [[WSMDetector instance] cancelPendingDetection];
    } else {
        [self.runButton setTitle:@"[Running]" forState:UIControlStateNormal];
        [[WSMDetector instance] run];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    
}

- (void) viewDidDisappear:(BOOL)animated {
}



@end
