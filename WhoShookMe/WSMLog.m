//
//  WSMLog.m
//  WhoShookMe
//
//  Created by Purushottam Dev on 19/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMLog.h"

#import "WSMAppDelegate.h"

@implementation WSMLog

static WSMLog* singletonLogInstance;

+ (void)initialize {
    static BOOL initialized = NO;
    if (!initialized) {
        singletonLogInstance = [[WSMLog alloc] init];
        initialized = YES;
    }
}

+ (WSMLog*)instance {
    return singletonLogInstance;
}

- (NSString*)logFilePath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/WSMLog.json"];
}

- (id)init {
    self = [super init];
    if (self) {
        logEntries = [[NSMutableArray alloc] init];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:[self logFilePath]]) {
            
            NSData *jsonData = [[NSData alloc] initWithContentsOfFile:[self logFilePath]];
            
            NSError *error = nil;
            NSArray *dataForLogEntries = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
            
            logEntries = [[NSMutableArray alloc] init];
            
            for (NSString *jsonDataEntry in dataForLogEntries) {
                [logEntries addObject:[[WSMDetectionInformation alloc] initWithJSONData:[jsonDataEntry dataUsingEncoding:NSUTF8StringEncoding]]];
            }
        }
        
    }
    return self;
}

- (NSArray*)getLogEntries {
    return logEntries;
}

- (void)addEntry:(WSMDetectionInformation*)entry {
    NSLog(@"Added entry");
    [logEntries addObject:entry];
}

- (void)clearLog {
    logEntries = [[NSMutableArray alloc] init];
}

- (void)saveLog {
    NSLog(@"Saving log to file %@", [self logFilePath]);
    [[self serializeToJSON] writeToFile:[self logFilePath] atomically:YES];
}

- (NSData*)serializeToJSON {
    NSMutableArray *dataForLogEntries = [[NSMutableArray alloc] init];
    
    for (WSMDetectionInformation *logEntry in logEntries) {
        [dataForLogEntries addObject:[[NSString alloc] initWithData:[logEntry serializeToJSON] encoding:NSUTF8StringEncoding]];
    }    
    
    NSError *error = nil;
    return [NSJSONSerialization dataWithJSONObject:dataForLogEntries options:NSJSONWritingPrettyPrinted error:&error];
}

+ (NSString*)extractEntryItemFromDictionary:(NSDictionary*)dict WithKey:(NSString*)key AndHeader:(NSString*)header ToLogString:(NSString*)logString {
    if ([dict objectForKey:key] != nil) {
        logString = [logString stringByAppendingString:[NSString stringWithFormat:@"\n\t%@: ", header]];
        logString = [logString stringByAppendingString:[dict objectForKey:key]];
    }
    return logString;
}


@end
