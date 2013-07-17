//
//  WSMNotificationMethod.h
//  WhoShookMeSkeleton
//
//  Created by Stuart Johnston on 3/05/13.
//  Copyright (c) 2013 Stuart Johnston. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WSMNotificationMethod <NSObject>

- (void)notifyWithInformation:(NSMutableArray*)info;
- (NSString*)methodName;
- (NSString*)methodDescription;

@end
