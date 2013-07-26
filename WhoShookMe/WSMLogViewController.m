//
//  WSMLogViewController.m
//  WhoShookMe
//
//  Created by P Dev on 11/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMLogViewController.h"

#import "WSMLog.h"

#import "WSMDetectionInformation.h"

#import "WSMTimeInformation.h"
#import "WSMGPSInformation.h"

@interface WSMLogViewController ()

@end

@implementation WSMLogViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString*)getLogEntryText:(WSMDetectionInformation*)entry {
    NSString *logString = @"Detection occurred:";
    
    logString = [WSMLog appendFormattedInformationItemFromDetection:entry WithKey:[WSMTimeInformation informationTypeIdentifier] UsingHeader:@"Time" ToString:logString];
    
    logString = [WSMLog appendFormattedInformationItemFromDetection:entry WithKey:[WSMGPSInformation informationTypeIdentifier] UsingHeader:@"GPS Coordinates" ToString:logString];
    
    return logString;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString* logText = [[NSString alloc] init];
    
    for (WSMDetectionInformation *info in [[WSMLog instance] getLogEntries]) {
        logText = [logText stringByAppendingString:[self getLogEntryText:info]];
        logText = [logText stringByAppendingString:@"\n"];
    }
    
    
    [self.logText setText:logText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clearLogButton:(id)sender {
    [[WSMLog instance] clearLog];
    [self.logText setText:@""];
}

@end
