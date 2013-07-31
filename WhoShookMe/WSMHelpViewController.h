//
//  WSMHelpViewController.h
//  WhoShookMe
//
//  Created by Maddy Mills on 31/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface WSMHelpViewController : UIViewController {
    CAGradientLayer *gradient;
}


@property (weak, nonatomic) IBOutlet UILabel *helpTextLabel;
- (IBAction)backButtonPressed:(id)sender;

@end
