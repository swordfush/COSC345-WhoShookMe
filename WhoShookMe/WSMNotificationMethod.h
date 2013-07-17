//
//  WSMNotificationMethod.h
//  WhoShookMeSkeleton
//
//  Created by Stuart Johnston on 3/05/13.
//  Copyright (c) 2013 Stuart Johnston. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WSMDetectionInformation.h"

@protocol WSMNotificationMethod <NSObject>

- (void)notifyWithInformation:(WSMDetectionInformation*)info;
- (NSString*)methodName;
- (NSString*)methodDescription;

@end
