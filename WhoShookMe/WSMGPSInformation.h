//
//  WSMGPSInformation.h
//  WhoShookMe
//
//  Created by P Dev on 10/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "WSMNotificationInfo.h"

@interface WSMGPSInformation : NSObject <WSMNotificationInfo,CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation *loc;
}

- (id)getInfo;

@end
