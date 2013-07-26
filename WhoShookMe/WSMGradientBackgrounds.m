//
//  WSMGradientBackgrounds.m
//  WhoShookMe
//
//  Created by Maddy Mills on 26/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

// Taken from http://danielbeard.wordpress.com/2012/02/25/gradient-background-for-uiview-in-ios/


#import "WSMGradientBackgrounds.h"

@implementation WSMGradientBackgrounds

+ (CAGradientLayer*)twoColorGradientWithFirstColor:(UIColor*)colorOne andSecondColor:(UIColor*)colorTwo {
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    
    return headerLayer;
}

+ (CAGradientLayer*)greyGradient {
    UIColor *colorOne = [UIColor colorWithWhite:0.9 alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.25 alpha:1.0];
    
    return [WSMGradientBackgrounds twoColorGradientWithFirstColor:colorOne andSecondColor:colorTwo];
}

+ (CAGradientLayer*)blueGradient {
    UIColor *colorOne = [UIColor colorWithRed:(120/255.0) green:(135/255.0) blue:(150/255.0) alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.25 alpha:1.0];
    
    return [WSMGradientBackgrounds twoColorGradientWithFirstColor:colorOne andSecondColor:colorTwo];
}

+ (CAGradientLayer*)reverseBlackGradient {
    UIColor *colorOne = [UIColor colorWithRed:(0.0) green:(0.0) blue:(0.0) alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithRed:(57/255.0)  green:(79/255.0)  blue:(96/255.0)  alpha:1.0];
    
    return [WSMGradientBackgrounds twoColorGradientWithFirstColor:colorOne andSecondColor:colorTwo];
}

+ (void)useBackground:(CAGradientLayer*)background forController:(UIViewController*)controller {
    background.frame = controller.view.bounds;
    [controller.view.layer insertSublayer:background atIndex:0];
}

@end
