//
//  WSMLogViewController.m
//  WhoShookMe
//
//  Created by P Dev on 11/05/13.
//  Copyright (c) 2013 P Dev. All rights reserved.
//

#import "WSMLogViewController.h"

#import "WSMLog.h"
#import "WSMDetectionInformation.h"
#import "WSMLogEntryViewController.h"

#import "WSMTimeInformation.h"
#import "WSMPhotoInformation.h"

@interface WSMLogViewController ()

@end

@implementation WSMLogViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clearLogButton:(id)sender {
    [[WSMLog instance] clearLog];
    [[self logEntryTableView] reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[WSMLog instance] getLogEntries] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableID = @"tableID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableID];
    }
    
    WSMDetectionInformation *detectionInfo = [[[WSMLog instance] getLogEntries] objectAtIndex:indexPath.row];
    cell.textLabel.text = [detectionInfo getInformationItemWithKey:[WSMTimeInformation informationTypeIdentifier]];
    
    NSString *imageFilePath = [detectionInfo getInformationItemWithKey:[WSMPhotoInformation informationTypeIdentifier]];
    
    if (imageFilePath != nil && [[NSFileManager defaultManager] fileExistsAtPath:imageFilePath]) {
        cell.imageView.image = [UIImage imageWithContentsOfFile:imageFilePath];
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ViewLogEntrySegueID"]) {
        NSAssert(selectedEntry != nil, @"No entry has been selected");
        
        WSMLogEntryViewController *logEntry = [segue destinationViewController];
        [logEntry setDetectionInformation:selectedEntry];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedEntry = [[[WSMLog instance] getLogEntries] objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ViewLogEntrySegueID" sender:self];
}



- (void)viewDidUnload {
    [self setLogEntryTableView:nil];
    [super viewDidUnload];
}
@end
