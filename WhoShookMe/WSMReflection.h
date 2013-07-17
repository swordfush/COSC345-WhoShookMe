//
//  WSMReflection.h
//  WhoShookMeSkeleton
//
//  Created by Maddy Mills on 3/05/13.
//  Copyright (c) 2013 Stuart Johnston. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSMReflection : NSObject

+ (NSMutableArray*)createAnInstanceOfEveryImplementingClass:(Protocol*)proto;

@end
