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
#import "WSMPhotoInformation.h"
#import "WSMAudioInformation.h"

#import "WSMLog.h"

#import <objc/runtime.h>

@implementation WSMNSLogNotification



- (NSString*)appendFormattedInformationItemFromDetection:(WSMDetectionInformation*)info WithKey:(NSString*)key UsingHeader:(NSString*)header ToString:(NSString*)logString {
    NSString *infoText = [info getInformationItemWithKey:key];
    
    if (infoText) {
        return [logString stringByAppendingFormat:@"\n\t%@\n\t\t%@", header, infoText];
    } else {
        return logString;
    }
}


- (void)notifyWithInformation:(WSMDetectionInformation*)info {
    NSString *logString = @"Detection occurred:";
    
    logString = [self appendFormattedInformationItemFromDetection:info WithKey:[WSMTimeInformation informationTypeIdentifier] UsingHeader:@"Time" ToString:logString];
    
    logString = [self appendFormattedInformationItemFromDetection:info WithKey:[WSMGPSInformation informationTypeIdentifier] UsingHeader:@"GPS Coordinates" ToString:logString];
    
    logString = [self appendFormattedInformationItemFromDetection:info WithKey:[WSMPhotoInformation informationTypeIdentifier] UsingHeader:@"Image File" ToString:logString];
    
    logString = [self appendFormattedInformationItemFromDetection:info WithKey:[WSMAudioInformation informationTypeIdentifier] UsingHeader:@"Audio File" ToString:logString];
    
    NSLog(@"%@\n", logString);
}


@end
