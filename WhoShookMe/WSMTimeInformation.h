//
//  WSMTimeInformation.h
//  WhoShookMe
//
//  Created by Stuart Johnston on 10/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WSMInformationSource.h"

@interface WSMTimeInformation : NSObject <WSMInformationSource> {
    NSDate *detectionTime;
}

- (void)prepareInfo;
- (NSString*)getInfo;
- (void)dumpInfo;
- (NSString*)informationTypeIdentifier;
+ (NSString*)informationTypeIdentifier;

@end
