//
//  WSMTimeInformation.m
//  WhoShookMe
//
//  Created by Stuart Johnston on 10/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMTimeInformation.h"

@implementation WSMTimeInformation

- (void)prepareInfo {
    detectionTime = [NSDate date];
}

- (NSString*)getInfo {
    // Return the current time
    NSAssert(detectionTime != nil, @"prepareInfo was not called, it is required to obtain the time.");
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    return [dateFormatter stringFromDate:detectionTime];
}

- (void)dumpInfo {
    detectionTime = nil;
}

- (NSString*)informationTypeIdentifier {
    return [WSMTimeInformation informationTypeIdentifier];
}

+ (NSString*)informationTypeIdentifier {
    return @"DetectionTime";
}

@end
