//
//  WSMRunningViewController.m
//  WhoShookMe
//
//  Created by Maddy Mills on 25/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMRunningViewController.h"

#import "WSMAuthenticationViewController.h"

#import "WSMDetector.h"

@interface WSMRunningViewController ()

@end

@implementation WSMRunningViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectionOccurred) name:[WSMDetector detectionOccurredName] object:nil];
    
    [[WSMDetector instance] run];
}

- (void)detectionOccurred {
    authViewController = (WSMAuthenticationViewController*)[[self storyboard] instantiateViewControllerWithIdentifier:@"AuthenticationViewID"];
    [self presentViewController:authViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)triggerDetection:(id)sender {
    [[WSMDetector instance] triggerDetection];
}

@end
