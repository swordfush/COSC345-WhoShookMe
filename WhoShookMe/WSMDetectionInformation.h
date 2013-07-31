//
//  WSMLogEntry.h
//  WhoShookMe
//
//  Created by Maddy Mills on 17/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * A structure which contains information regarding a user detection.
 */
@interface WSMDetectionInformation : NSObject {
    NSDictionary *dict;
}

/**
 * Initializes a new instance which sources detection data from the information 
 * sources provided.
 */
- (id)initUsingInformationSources:(NSMutableArray*)infoSources;

/**
 * Gets the information associated with a particular key. The key is given by
 * the informationTypeIdentifier: method of WSMInformationSource instances.
 *
 * @return A string detailing a particular piece of information about the detection, 
 *  or nil if there is no information for the key provided.
 */
- (NSString*)getInformationItemWithKey:(NSString*)key;

/**
 * Serializes the object to JSON data.
 */
- (NSData*)serializeToJSON;
/**
 * Initializes an instance using JSON data.
 */
- (id)initWithJSONData:(NSData*)jsonData;


@end
