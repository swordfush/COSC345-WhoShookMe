//
//  WSMPhotoInformation.h
//  WhoShookMe
//
//  Created by Maddy Mills on 26/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#import "WSMInformationSource.h"

@interface WSMPhotoInformation : NSObject <WSMInformationSource> {
    NSString *filePath;
    NSData *imageData;
}

- (void)prepareInfo;
- (NSString*)getInfo;
- (void)dumpInfo;
- (NSString*)informationTypeIdentifier;
+ (NSString*)informationTypeIdentifier;


@end
