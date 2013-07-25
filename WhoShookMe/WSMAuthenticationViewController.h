//
//  WSMAuthenticationViewController.h
//  WhoShookMe
//
//  Created by Maddy Mills on 25/07/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSMAuthenticationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *pinInputTextField;

@property (weak, nonatomic) IBOutlet UIButton *authenticateButton;


- (IBAction)attemptAuthentication:(id)sender;
- (IBAction)button1Pressed:(id)sender;
- (IBAction)button2Pressed:(id)sender;
- (IBAction)button3Pressed:(id)sender;
- (IBAction)button4Pressed:(id)sender;
- (IBAction)button5Pressed:(id)sender;
- (IBAction)button6Pressed:(id)sender;
- (IBAction)button7Pressed:(id)sender;
- (IBAction)button8Pressed:(id)sender;
- (IBAction)button9Pressed:(id)sender;
- (IBAction)button0Pressed:(id)sender;
- (IBAction)clearButtonPressed:(id)sender;

@end
