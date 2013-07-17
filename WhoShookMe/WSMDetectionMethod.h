//
//  WSMDetectionMethod.h
//  WhoShookMeSkeleton
//
//  Created by Stuart Johnston on 3/05/13.
//  Copyright (c) 2013 Stuart Johnston. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WSMDetectionMethod <NSObject>

- (BOOL)hasDetectedUser;
- (NSString*)methodName;
- (NSString*)methodDescription;
- (void)reset;

@end
