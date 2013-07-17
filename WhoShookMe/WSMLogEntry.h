//
//  WSMLogEntry.h
//  WhoShookMe
//
//  Created by Maddy Mills on 17/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSMLogEntry : NSObject {
    NSDictionary *dict;
}

- (id)initWithNotificationInfo:(NSMutableArray*)info;
- (NSDictionary*)getInfo;

- (NSData*)serializeToJSON;
- (id)initWithJSONData:(NSData*)jsonData;


@end
