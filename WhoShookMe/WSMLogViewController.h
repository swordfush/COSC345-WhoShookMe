//
//  WSMLogViewController.h
//  WhoShookMe
//
//  Created by P Dev on 11/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSMLogViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *logText;

- (IBAction)clearLogButton:(id)sender;

@end
