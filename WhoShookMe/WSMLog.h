//
//  WSMLog.h
//  WhoShookMe
//
//  Created by Purushottam Dev on 19/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WSMDetectionInformation.h"

/**
 * Provides methods to manipulate and access the log used to 
 * record detections.
 *
 * Note that this class is implemented as a singleton.
 */
@interface WSMLog : NSObject {
    NSMutableArray *logEntries;
    BOOL hasUnsavedChanges;
}

/**
 * Returns a reference to the singleton instance.
 */
+ (WSMLog*)instance;

/**
 * Gets the entries (instances of WSMDetectionInformation) in the log.
 */
- (NSArray*)getLogEntries;

/**
 * Appends the entry supplied to the log.
 */
- (void)addEntry:(WSMDetectionInformation*)entry;

/**
 * Clears all entries in the log.
 */
- (void)clearLog;

/**
 * Saves the log. The log class never does this itself, but will only save
 * if no changes have been made to the log.
 */
- (void)saveLog;


@end
