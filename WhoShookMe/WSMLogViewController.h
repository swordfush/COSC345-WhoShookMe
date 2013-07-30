//
//  WSMLogViewController.h
//  WhoShookMe
//
//  Created by P Dev on 11/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "WSMDetectionInformation.h"

@interface WSMLogViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    WSMDetectionInformation *selectedEntry;
    CAGradientLayer *gradient;
}

@property (weak, nonatomic) IBOutlet UITableView *logEntryTableView;

- (IBAction)clearLogButton:(id)sender;
- (IBAction)backButtonPressed:(id)sender;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
