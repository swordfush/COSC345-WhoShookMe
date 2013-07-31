//
//  WSMDetectionMethod.h
//  WhoShookMeSkeleton
//
//  Created by Stuart Johnston on 3/05/13.
//  Copyright (c) 2013 Stuart Johnston. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * The protocol for which methods of user detection must adhere to. 
 */
@protocol WSMDetectionMethod <NSObject>

/** 
 * Reflection is used to instantiate instances of this class, and each
 * instance is initialized using the default init method. 
 *
 * After initialization the detection method will begin detecting.
 */
- (id)init;

/**
 * Determines whether the detection method has detected a user. 
 */
- (BOOL)hasDetectedUser;

/**
 * Resets the detection method so that it can once again detect.
 *
 * Note that this is to be called before running detections, so that 
 * methods can avoid doing work when they have triggered a detection 
 * that is running.
 */
- (void)reset;

@end
