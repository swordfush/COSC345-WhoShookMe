//
//  WSMLog.h
//  WhoShookMe
//
//  Created by Purushottam Dev on 19/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WSMDetectionInformation.h"

@interface WSMLog : NSObject {
    NSMutableArray *logEntries;
}

+ (WSMLog*)instance;

- (NSArray*)getLogEntries;
- (void)addEntry:(WSMDetectionInformation*)entry;
- (void)clearLog;

- (void)saveLog;

+ (NSString*)appendFormattedInformationItemFromDetection:(WSMDetectionInformation*)info WithKey:(NSString*)key UsingHeader:(NSString*)header ToString:(NSString*)logString;


@end