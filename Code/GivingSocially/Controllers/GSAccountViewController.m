//
//  GSAccountViewController.m
//  GivingSocially
//
//  Created by Scott Penrose on 2/2/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSAccountViewController.h"
#import "GSLoginViewController.h"
#import "GSAccountHeaderView.h"
#import "IIViewDeckController.h"
#import "GSActivitesViewController.h"
#import "GSHomeViewController.h"
#import "GSAppDelegate.h"

@interface GSAccountViewController ()

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) GSAccountHeaderView* accountHeaderView;

@end

@implementation GSAccountViewController

@synthesize tableView = _tableView;
@synthesize accountHeaderView = _accountHeaderView;

- (void)dealloc 
{
    [_tableView release];
    [_accountHeaderView release];
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    _accountHeaderView = [[GSAccountHeaderView alloc] initWithFrame:(CGRect){0, 0, self.view.frame.size.width - 44, 29}];
    
    _tableView = [[UITableView alloc] initWithFrame:(CGRect){0, 0, self.view.frame.size.width - 44, self.view.frame.size.height} style:UITableViewStylePlain];
    [self.tableView setTableHeaderView:_accountHeaderView];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = @"AccountSettingsCellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];
    }
    switch (indexPath.row) {
        case 0:
            [cell.textLabel setText:@"Activity"];
            break;
        case 1:
            [cell.textLabel setText:@"Gift Lists"];
            break;
        case 2:
            [cell.textLabel setText:@"Settings"];
            break;
        case 3:
            [cell.textLabel setText:@"Sign Out"];
            break;
        default:
            break;
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GSAppDelegate* appDelegateInstance = (GSAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:@"Sign Out"]) {
        GSLoginViewController* loginVC = [[[GSLoginViewController alloc] init] autorelease];
        [self presentModalViewController:loginVC animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:@"Activity"]) {
        GSActivitesViewController *activitiesViewController = [[[GSActivitesViewController alloc] init] autorelease];
        appDelegateInstance.deckControllerInstance.centerController =  [[[UINavigationController alloc] initWithRootViewController:activitiesViewController] autorelease];
    }
    else if ([cell.textLabel.text isEqualToString:@"Gift Lists"]) {
        GSHomeViewController *giftListController = [[[GSHomeViewController alloc] init] autorelease];
        appDelegateInstance.deckControllerInstance.centerController =  [[[UINavigationController alloc] initWithRootViewController:giftListController] autorelease];
    }
    else if ([cell.textLabel.text isEqualToString:@"Settings"]) {
        
    }else {
        NSLog(@"I dont have a View Controller to that matches this type!");
    }
}


@end
