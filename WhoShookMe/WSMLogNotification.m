//
//  WSMLogNotification.m
//  WhoShookMe
//
//  Created by P Dev on 10/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMLog.h"

#import "WSMLogNotification.h"

#import "WSMDetectionInformation.h"
#import "WSMTimeInformation.h"
#import "WSMGPSInformation.h"

#import <objc/runtime.h>

@implementation WSMLogNotification

- (id)init {
    self = [super init];
    
    return self;
}

- (void)notifyWithInformation:(WSMDetectionInformation*)info {
    WSMLog *log = [WSMLog instance];
    [log addEntry:info];
}

- (NSString*)methodName {
    return @"Log Notification";
}

- (NSString*)methodDescription {
    return @"Writes information to the program log";
}


@end
