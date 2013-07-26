//
//  WSMNSLogNotification.h
//  WhoShookMe
//
//  Created by P Dev on 10/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WSMNotificationMethod.h"

@interface WSMNSLogNotification : NSObject <WSMNotificationMethod>

- (void)notifyWithInformation:(WSMDetectionInformation*)info;
- (NSString*)methodName;
- (NSString*)methodDescription;

@end
