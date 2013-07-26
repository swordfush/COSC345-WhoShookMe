//
//  WSMDetectionMethod.h
//  WhoShookMeSkeleton
//
//  Created by Stuart Johnston on 3/05/13.
//  Copyright (c) 2013 Stuart Johnston. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WSMDetectionMethod <NSObject>

/**
 * Determines whether the detection method has detected a user. 
 */
- (BOOL)hasDetectedUser;

- (NSString*)methodName;
- (NSString*)methodDescription;

/**
 * Resets the detection method so that it can once again detect.
 * This is to be called before running detections, so that methods
 * can avoid doing work when they have triggered a detection that 
 * is running.
 */
- (void)reset;

@end
