//
//  WSMLogNotification.m
//  WhoShookMe
//
//  Created by P Dev on 10/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMLogNotification.h"

#import "WSMDetectionInformation.h"
#import "WSMTimeInformation.h"
#import "WSMGPSInformation.h"

#import <objc/runtime.h>

@implementation WSMLogNotification

- (id)init {
    self->files = [[NSFileManager alloc] init];
    self->tempDir = NSTemporaryDirectory();
    self->fileName = @"Activity_Log.txt";
    
    // If the file does not exist create it
    NSString *path = [self->tempDir stringByAppendingPathComponent:self->fileName];
    
    if (![self->files fileExistsAtPath:path]) {
        [@"" writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    
    return self;
}

- (void)writeToFile:(NSString *)data{
    NSString *path = [self->tempDir stringByAppendingPathComponent:fileName];
    NSLog(@"Writing to log file %@", path);
    NSString *contentsOfFile = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    data = [data stringByAppendingString:@"\n"];
    NSString *addingData = [contentsOfFile stringByAppendingString:data];
    [addingData writeToFile:path atomically:NO encoding:NSUTF8StringEncoding error:nil];
}

- (void)notifyWithInformation:(WSMDetectionInformation*)info {
    NSString *logString = @"Detection occurred:\n";
    
    NSDictionary *dict = [info getInfo];
    
    logString = [WSMLogNotification extractEntryItemFromDictionary:dict WithKey:[WSMTimeInformation infoTypeName] AndHeader:@"Time" ToLogString:logString];
    
    logString = [WSMLogNotification extractEntryItemFromDictionary:dict WithKey:[WSMGPSInformation infoTypeName] AndHeader:@"GPS Coordinates" ToLogString:logString];
    
    [self writeToFile:logString];
}

- (NSString*)methodName {
    return @"Log Notification";
}
- (NSString*)methodDescription {
    return @"Writes information to the program log";
}

+ (NSString*)extractEntryItemFromDictionary:(NSDictionary*)dict WithKey:(NSString*)key AndHeader:(NSString*)header ToLogString:(NSString*)logString {
    if ([dict objectForKey:key] != nil) {
        logString = [logString stringByAppendingString:[NSString stringWithFormat:@"\n\t%@: ", header]];
        logString = [logString stringByAppendingString:[dict objectForKey:key]];
    }
    return logString;
}

@end
