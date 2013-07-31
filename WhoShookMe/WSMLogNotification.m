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


- (void)notifyWithInformation:(WSMDetectionInformation*)info {
    WSMLog *log = [WSMLog instance];
    [log addEntry:info];
}


@end
