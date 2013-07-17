//
//  WSMLogNotification.h
//  WhoShookMe
//
//  Created by P Dev on 10/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WSMNotificationMethod.h"

@interface WSMLogNotification : NSObject <WSMNotificationMethod> {
    NSFileManager *files;
    NSString *tempDir;
    NSString *fileName;
}

- (void)notifyWithInformation:(WSMDetectionInformation*)info;
- (NSString*)methodName;
- (NSString*)methodDescription;
+ (NSString*)extractEntryItemFromDictionary:(NSDictionary*)dict WithKey:(NSString*)key AndHeader:(NSString*)header ToLogString:(NSString*)logString;

@end
