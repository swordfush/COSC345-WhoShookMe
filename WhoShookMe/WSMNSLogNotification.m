//
//  WSMNSLogNotification.m
//  WhoShookMe
//
//  Created by P Dev on 10/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMNSLogNotification.h"

#import "WSMInformationSource.h"
#import "WSMTimeInformation.h"
#import "WSMGPSInformation.h"

#import "WSMLogNotification.h"

#import <objc/runtime.h>

@implementation WSMNSLogNotification



- (void)notifyWithInformation:(WSMDetectionInformation*)info {
    NSString *logString = @"Detection occurred:\n";
    
    NSDictionary *dict = [info getInfo];
    
    logString = [WSMLogNotification extractEntryItemFromDictionary:dict WithKey:[WSMTimeInformation infoTypeName] AndHeader:@"Time" ToLogString:logString];
    
    logString = [WSMLogNotification extractEntryItemFromDictionary:dict WithKey:[WSMGPSInformation infoTypeName] AndHeader:@"GPS Coordinates" ToLogString:logString];
    
    NSLog(@"%@", logString);
}

- (NSString*)methodName {
    return @"Debug Log Notification";
}

- (NSString*)methodDescription {
    return @"Writes detection information to the NSLog stream. Used for testing.";
}

@end
