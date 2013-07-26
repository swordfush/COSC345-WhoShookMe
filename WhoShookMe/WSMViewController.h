//
//  WSMViewController.h
//  WhoShookMe
//
//  Created by P Dev on 3/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSMViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *runButton;

- (IBAction)runButtonClicked:(id)sender;
- (IBAction)viewLogButtonClicked:(id)sender;


@end
