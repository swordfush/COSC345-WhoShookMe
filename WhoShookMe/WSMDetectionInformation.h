//
//  WSMLogEntry.h
//  WhoShookMe
//
//  Created by Maddy Mills on 17/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSMDetectionInformation : NSObject {
    NSDictionary *dict;
}

- (id)initUsingInformationSources:(NSMutableArray*)infoSources;

- (NSString*)getInformationItemWithKey:(NSString*)key;

- (NSData*)serializeToJSON;
- (id)initWithJSONData:(NSData*)jsonData;


@end
