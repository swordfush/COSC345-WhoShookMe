//
//  WSMLogEntry.m
//  WhoShookMe
//
//  Created by Maddy Mills on 17/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMLogEntry.h"

#import "WSMNotificationInfo.h"


@implementation WSMLogEntry

- (id)initWithNotificationInfo:(NSMutableArray*)info {
    self = [super init];
    
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    
    for (id<WSMNotificationInfo> i in info) {
        [keys addObject:[i infoTypeName]];
        [objects addObject:[i getInfo]];
    }
    
    dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    return self;
}

- (NSDictionary*)getInfo {
    return dict;
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
