//
//  GSFriendsViewController.m
//  GivingSocially
//
//  Created by Scott Penrose on 2/2/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSFriendsViewController.h"
#import "GSUser.h"
#import "GSAddFriendsViewController.h"

@interface GSFriendsViewController ()

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) NSArray* friends;

- (void)setupTable;

@end

@implementation GSFriendsViewController

@synthesize tableView = _tableView;
@synthesize friends = _friends;

- (void)dealloc
{
    [_tableView release];
    [_friends release];
    [super dealloc];
}

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _friends = [[NSArray alloc] init];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor blueColor]];
    
    _tableView = [[UITableView alloc] initWithFrame:(CGRect){44, 0, self.view.frame.size.width - 44, self.view.frame.size.height} style:UITableViewStylePlain];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [self.view addSubview:_tableView];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/friends" delegate:self];
}

- (void)setupTable
{
    GSUser* user = [GSUser currentUser];
    _friends = [[user.friends allObjects] retain];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row ==0 && indexPath.section == 0) {
        GSAddFriendsViewController* addFriendsViewController = [[[GSAddFriendsViewController alloc] init]autorelease];
        [self.navigationController pushViewController:addFriendsViewController animated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0: return 1;
        case 1: return [self.friends count];
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"AddFriendsCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    switch (indexPath.section) {
        case 0:
            [cell.textLabel setText:@"Add Friends"];
            break;
        case 1:
        {
            GSUser *user = (GSUser*)[self.friends objectAtIndex:indexPath.row];
            NSLog(@"User: %@, MOC: %@", user, user.managedObjectContext);
            [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName]];
            break;
        }
        default:
            break;
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 1:
            return [NSString stringWithFormat:@"%i friends", [self.friends count]];
            
        default:
            return nil;
    }
}

#pragma mark - RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Failed to load friends: %@", [error localizedDescription]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    NSLog(@"Friends loaded: %@", objects);
    GSUser *user = [GSUser currentUser];
    [user addFriends:[NSSet setWithArray:objects]];
    [self setupTable];
}

@end
