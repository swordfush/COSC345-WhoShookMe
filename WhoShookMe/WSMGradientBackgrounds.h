//
//  WSMGradientBackgrounds.h
//  WhoShookMe
//
//  Created by Maddy Mills on 26/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


@interface WSMGradientBackgrounds : NSObject

+ (CAGradientLayer*)greyGradient;
+ (CAGradientLayer*)blueGradient;
+ (CAGradientLayer*)reverseBlackGradient;

+ (void)useBackground:(CAGradientLayer*)background forController:(UIViewController*)controller;

@end
