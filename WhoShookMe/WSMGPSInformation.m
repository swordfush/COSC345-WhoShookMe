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
    if (loc == nil) {
        return @"";
    } else {
        return [NSString stringWithFormat:@"Latitude: %f, Longitude: %f, Altitude: %f", loc.coordinate.latitude, loc.coordinate.longitude, loc.altitude];
    }
}

- (void)dumpInfo {
    loc = nil;
}

- (NSString*)informationTypeIdentifier {
    return [WSMGPSInformation informationTypeIdentifier];
}

+ (NSString*)informationTypeIdentifier {
    return @"GPSCoordinates";
}

@end
