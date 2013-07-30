//
//  WSMLogEntry.m
//  WhoShookMe
//
//  Created by Maddy Mills on 17/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMDetectionInformation.h"

#import "WSMInformationSource.h"


@implementation WSMDetectionInformation

- (id)initUsingInformationSources:(NSMutableArray*)infoSources {
    self = [super init];
    
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    
    for (id<WSMInformationSource> i in infoSources) {
        NSString *info = [i getInfo];
        
        if (info != nil) {
            [keys addObject:[i informationTypeIdentifier]];
            [objects addObject:info];
        }
    }
    
    dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    return self;
}

- (NSString*)getInformationItemWithKey:(NSString*)key {
    return [dict objectForKey:key];
}

- (NSData*)serializeToJSON {
    NSError *error = nil;
    return [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
}

- (id)initWithJSONData:(NSData*)jsonData {
    self = [super init];
    NSError *error = nil;
    dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    return self;
}


@end
