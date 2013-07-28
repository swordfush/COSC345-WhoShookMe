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
        
        hasUnsavedChanges = NO;
    }
    return self;
}

- (NSArray*)getLogEntries {
    return logEntries;
}

- (void)addEntry:(WSMDetectionInformation*)entry {
    [logEntries addObject:entry];
    hasUnsavedChanges = YES;
}

- (void)clearLog {
    NSLog(@"Clearing the log");
    logEntries = [[NSMutableArray alloc] init];
    
    // Force the changes to be saved before we delete all of the files
    hasUnsavedChanges = YES;
    [self saveLog];
    
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
    NSError *error = nil;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directory error:&error];
    
    if (error == nil) {
        for (NSString *file in files) {
            NSString *extension = [file pathExtension];
            
            if ([extension isEqualToString:@"jpg"] || [extension isEqualToString:@"m4a"]) {
                if ([[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", directory, file] error:&error]) {
                    NSLog(@"Removed the file: %@", file);
                } else {
                    NSLog(@"Failed to remove the file: %@", file);
                }
            }
        }
    } else {
        NSLog(@"Failed to open the documents directory while clearing the log");
    }
    
}

- (void)saveLog {
    if (hasUnsavedChanges) {
        NSLog(@"Saving log to file %@", [self logFilePath]);
        [[self serializeToJSON] writeToFile:[self logFilePath] atomically:YES];
    } else {
        NSLog(@"Log is not being saved as no changes have been made");
    }
}

- (NSData*)serializeToJSON {
    NSMutableArray *dataForLogEntries = [[NSMutableArray alloc] init];
    
    for (WSMDetectionInformation *logEntry in logEntries) {
        [dataForLogEntries addObject:[[NSString alloc] initWithData:[logEntry serializeToJSON] encoding:NSUTF8StringEncoding]];
    }    
    
    NSError *error = nil;
    return [NSJSONSerialization dataWithJSONObject:dataForLogEntries options:NSJSONWritingPrettyPrinted error:&error];
}


@end
