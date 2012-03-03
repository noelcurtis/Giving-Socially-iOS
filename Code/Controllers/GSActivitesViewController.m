//
//  GSActivitesViewController.m
//  GivingSocially
//
//  Created by Noel Curtis on 3/1/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//


#import "GSActivitesViewController.h"
#import "GSGiftList.h"
#import "GSGiftListViewController.h"
#import "GSActivity.h"

@interface GSActivitesViewController ()

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) NSArray* activities;

@end

@implementation GSActivitesViewController

@synthesize tableView = _tableView;
@synthesize activities = _activities;

- (void)dealloc 
{
    [_tableView release];
    [_activities release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _activities = [[NSArray alloc] init];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor purpleColor]];
    
    _tableView = [[UITableView alloc] initWithFrame:(CGRect){0, 0, self.view.frame.size.width, self.view.frame.size.height - 44} style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/activities" delegate:self];
}

- (void)setupTable
{
    self.activities = [GSActivity findAll];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.activities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = @"GiftListCellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    GSActivity* activity  = [self.activities objectAtIndex:indexPath.row];
    NSLog(@"Activity id:%@, descriptor:%@", activity.activityID, activity.friendlyDescription);
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", activity.friendlyDescription]];
    return cell;
}

#pragma mark - UITableViewDelegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

#pragma mark - RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error
{
    NSLog(@"Error loading lists");
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects
{
    [self setupTable];
}

@end
