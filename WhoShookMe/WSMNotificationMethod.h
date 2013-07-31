//
//  WSMNotificationMethod.h
//  WhoShookMeSkeleton
//
//  Created by Stuart Johnston on 3/05/13.
//  Copyright (c) 2013 Stuart Johnston. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WSMDetectionInformation.h"

/**
 * A method of notifying the user that a detection has occurred.
 */
@protocol WSMNotificationMethod <NSObject>

/** 
 * Notifies the user of a detection with the gathered information
 * provided.
 */
- (void)notifyWithInformation:(WSMDetectionInformation*)info;

@end
