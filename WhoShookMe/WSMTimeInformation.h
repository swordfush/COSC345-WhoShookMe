//
//  WSMTimeInformation.h
//  WhoShookMe
//
//  Created by Stuart Johnston on 10/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WSMNotificationInfo.h"

@interface WSMTimeInformation : NSObject <WSMNotificationInfo>

- (id)getInfo;

@end
