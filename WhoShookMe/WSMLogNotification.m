//
//  WSMLogNotification.m
//  WhoShookMe
//
//  Created by P Dev on 10/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMLogNotification.h"

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

- (void)notifyWithInformation:(NSMutableArray*)info {
    NSString *logInfo = @"";
    
    for (id i in info) {
        if ([i isKindOfClass:[NSDate class]]) {
            // Add the time to the message
            NSDate *time = (NSDate*)i;
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSString *timeString = [NSString stringWithFormat:@"time:%@\t", [dateFormatter stringFromDate:time]];
            logInfo = [logInfo stringByAppendingString:timeString];
        } else if ([i isKindOfClass:[NSString class]]) {
            NSString *str = (NSString *)i;
            logInfo = [NSString stringWithFormat:@"location:%@\t", [logInfo stringByAppendingString:str]];
        } else {
            const char* className = class_getName([i class]);
            NSLog(@"The information given was not recognised! It is of type %s", className);
        }
    }
    
    [self writeToFile:logInfo];
}

- (NSString*)methodName {
    return @"Log Notification";
}
- (NSString*)methodDescription {
    return @"Writes information to the program log";
}

@end
