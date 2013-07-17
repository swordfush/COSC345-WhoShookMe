//
//  WSMNotifier.m
//  WhoShookMe
//
//  Created by P Dev on 10/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMNotifier.h"

#import "WSMNotificationMethod.h"
#import "WSMInformationSource.h"

@implementation WSMNotifier

- (id)initWithNotificationMethods:(NSMutableArray *)methods {
    self->notificationMethods = methods;
    return self;
}

- (void)notifyWithInformationSources:(NSMutableArray *)infoSources {
    NSLog(@"Notifying user");
    
    WSMDetectionInformation *info = [[WSMDetectionInformation alloc] initWithNotificationSources:infoSources];
    
    // Provide the information to each notification method
    for (id<WSMNotificationMethod> method in self->notificationMethods) {
        [method notifyWithInformation:info];
    }
}

@end
