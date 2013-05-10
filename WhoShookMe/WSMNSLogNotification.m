//
//  WSMNSLogNotification.m
//  WhoShookMe
//
//  Created by P Dev on 10/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMNSLogNotification.h"
#import "WSMNotificationInfo.h"

#import <objc/runtime.h>

@implementation WSMNSLogNotification

- (void)notifyWithInformation:(NSMutableArray*)info {
    NSLog(@"Creating log notification");
    NSString *logString = @"Detection occurred; ";
    
    for (id<WSMNotificationInfo> i in info) {
        if ([i isKindOfClass:[NSDate class]]) {
            // Add the time to the message
            NSDate *time = (NSDate*)i;
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            
            NSString *timeString = [NSString stringWithFormat:@"Time: %@, ", [dateFormatter stringFromDate:time]];
            logString = [logString stringByAppendingString:timeString];
        } else if ([i isKindOfClass:[NSString class]]) {
            // GPS coords
            NSString *str = (NSString *)i;
            logString = [NSString stringWithFormat:@"Location: %@, ", [logString stringByAppendingString:str]];
        } else {
            const char* className = class_getName([i class]);
            NSLog(@"The information given was not recognised! It is of type %s", className);
        }
    }
    
    NSLog(@"%@", logString);
}

- (NSString*)methodName {
    return @"Log Notification";
}

- (NSString*)methodDescription {
    return @"Writes detection information to the NSLog stream. Used for testing.";
}

@end
