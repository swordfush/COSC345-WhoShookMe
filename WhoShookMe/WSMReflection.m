//
//  WSMReflection.m
//  WhoShookMeSkeleton
//
//  Created by Maddy Mills on 3/05/13.
//  Copyright (c) 2013 Stuart Johnston. All rights reserved.
//

#import "WSMReflection.h"

#import <objc/runtime.h>

@implementation WSMReflection

+ (NSMutableArray*)createAnInstanceOfEveryImplementingClass:(Protocol *)proto {
    int numClasses = objc_getClassList(nil, 0);
    NSMutableArray *instances;
    
    // Check we actually have some classes to work with
    if (numClasses > 0) {
        // Allocate memory for the reflection info and the instances
        Class *classes = (Class*)malloc(sizeof(Class) * numClasses);
        instances = [[NSMutableArray alloc] initWithCapacity:numClasses];
        
        // Obtain the class list
        numClasses = objc_getClassList(classes, numClasses);
//        NSLog(@"Found %i classes in the assembly.", numClasses);
        
        // Find all classes that conform to the protocol
        for (int i = 0; i < numClasses; i++) {
//            NSLog(@"Testing class %s for conformance to protocol %s", class_getName(classes[i]), protocol_getName(proto));
            if (class_conformsToProtocol(classes[i], proto)) {
                // Create an instance of the class using the init selector
//                NSLog(@"Class conforms; creating instance");
                [instances addObject:[[classes[i] alloc] init]];
            }
        }
        
        free(classes);
    
        return instances;
    } else {
        return nil;
    }   
}

@end
