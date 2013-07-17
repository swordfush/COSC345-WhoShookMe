//
//  WSMGPSInformation.h
//  WhoShookMe
//
//  Created by P Dev on 10/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "WSMInformationSource.h"

@interface WSMGPSInformation : NSObject <WSMInformationSource,CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation *loc;
}

- (void)prepareInfo;
- (NSString*)getInfo;
- (void)dumpInfo;
+ (NSString*)infoTypeName;

@end
