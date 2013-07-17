//
//  WSMNotifier.h
//  WhoShookMe
//
//  Created by P Dev on 10/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSMNotifier : NSObject {
    NSMutableArray *notificationMethods;
}

- (id)initWithNotificationMethods:(NSMutableArray *)methods;
- (void)notifyWithInformationSources:(NSMutableArray *)infoSources;

@end
