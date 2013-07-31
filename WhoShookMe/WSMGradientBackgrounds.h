//
//  WSMGradientBackgrounds.h
//  WhoShookMe
//
//  Created by Maddy Mills on 26/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

/**
 * Provides class methods that implement gradient backgrounds for views.
 */
@interface WSMGradientBackgrounds : NSObject

/**
 * A grey gradient, brighter at the top.
 */
+ (CAGradientLayer*)greyGradient;

/**
 * A blue gradient, brighter at the top.
 */
+ (CAGradientLayer*)blueGradient;

/**
 * A gradient which is black at the top, and a blueish grey at the bottom.
 */
+ (CAGradientLayer*)reverseBlackGradient;

/**
 * Sets the gradient as the background for the view.
 *
 * @param background The gradient to use as a background.
 * @param controller The controller for the view whose background will be set.
 */
+ (void)useBackground:(CAGradientLayer*)background forController:(UIViewController*)controller;

@end
