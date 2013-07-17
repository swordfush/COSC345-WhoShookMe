//
//  WSMNotifier.m
//  WhoShookMe
//
//  Created by P Dev on 10/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMNotifier.h"

#import "WSMNotificationMethod.h"
#import "WSMNotificationInfo.h"

@implementation WSMNotifier

- (id)initWithNotificationMethods:(NSMutableArray *)methods {
    self->notificationMethods = methods;
    return self;
}

- (void)notifyWithInformationSources:(NSMutableArray *)infoSources {
    NSLog(@"Notifying user");
    
    // Obtain the information from each source
    NSMutableArray *info = [[NSMutableArray alloc] init];
    for (id<WSMNotificationInfo> i in infoSources) {
        [info addObject:[i getInfo]];
    }
    
    // Provide the information to each notification method
    for (id<WSMNotificationMethod> method in self->notificationMethods) {
        [method notifyWithInformation:info];
    }
}

@end
