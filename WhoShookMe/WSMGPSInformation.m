//
//  WSMGPSInformation.m
//  WhoShookMe
//
//  Created by P Dev on 10/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMGPSInformation.h"


@implementation WSMGPSInformation

- (id)init {
    self = [super init];
    if(!locationManager){
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 0.5;
        locationManager.delegate = self;
    }
    [locationManager startUpdatingLocation];
    [locationManager startMonitoringSignificantLocationChanges];

    return self;
}

- (void)prepareInfo {
    loc = locationManager.location;
}

- (NSString*)getInfo {
    NSAssert(loc != nil, @"prepareInfo was not called, so the location has not been obtained");
    return [NSString stringWithFormat:@"Latitude: %f, Longitude: %f, Altitude: %f", loc.coordinate.latitude, loc.coordinate.longitude, loc.altitude];
}
            
- (void)dumpInfo {
    loc = nil;
}

+ (NSString*)infoTypeName {
    return @"GPSCoordinates";
}

@end
