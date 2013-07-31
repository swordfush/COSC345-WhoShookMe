//
//  WSMReflection.h
//  WhoShookMeSkeleton
//
//  Created by Maddy Mills on 3/05/13.
//  Copyright (c) 2013 Stuart Johnston. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSMReflection : NSObject

/**
 * Creates a single instance of every class that implements the protocol provided.
 *
 * The default init method is used to initialize each instance.
 */
+ (NSMutableArray*)createAnInstanceOfEveryImplementingClass:(Protocol*)proto;

@end
