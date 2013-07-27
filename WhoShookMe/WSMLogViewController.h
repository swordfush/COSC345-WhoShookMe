//
//  WSMLogViewController.h
//  WhoShookMe
//
//  Created by P Dev on 11/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WSMDetectionInformation.h"

@interface WSMLogViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    WSMDetectionInformation *selectedEntry;
}

@property (weak, nonatomic) IBOutlet UITextView *logText;

- (IBAction)clearLogButton:(id)sender;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end
