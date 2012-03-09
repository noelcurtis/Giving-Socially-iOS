//
//  GSGiftListViewController.m
//  GivingSocially
//
//  Created by Scott Penrose on 2/12/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSGiftListViewController.h"
#import "GSGift.h"
#import "GSGiftListView.h"
#import "GSAddGiftViewController.h"

@interface GSGiftListViewController ()

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) GSGiftList* giftList;
@property (nonatomic, retain) NSArray* gifts;
@property (nonatomic, retain) GSGiftListView* giftListHeaderView;

@end

@implementation GSGiftListViewController

@synthesize tableView = _tableView;
@synthesize giftList = _giftList, gifts = _gifts;
@synthesize giftListHeaderView = _giftListHeaderView;

- (void)dealloc 
{
    [_tableView release];
    [_giftList release];
    [_gifts release];
    [_giftListHeaderView release];
    [super dealloc];
}

- (id)initWithGiftList:(GSGiftList*)giftList
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _giftList = [giftList retain];
        _gifts = [[NSArray alloc] init];
    }
    return self;
}

- (void)loadView
{
    self.view = [[[UIView alloc] initWithFrame:(CGRect){0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 20}] autorelease];
    
    [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGiftButtonTouched:)] autorelease]];
    
    _giftListHeaderView = [[GSGiftListView alloc] initWithFrame:CGRectZero giftList:self.giftList];
    
    _tableView = [[UITableView alloc] initWithFrame:(CGRect){ 0, 0, self.view.frame.size } style:UITableViewStylePlain];
    [self.tableView setTableHeaderView:self.giftListHeaderView];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"/gift_lists/%@/gifts", self.giftList.giftListID] delegate:self];
}

#pragma mark - Button Actions

- (void)addGiftButtonTouched:(id)sender
{
    GSAddGiftViewController* addGiftVC = [[[GSAddGiftViewController alloc] initWithGiftListID:self.giftList.giftListID] autorelease];
    UINavigationController* navController = [[[UINavigationController alloc] initWithRootViewController:addGiftVC] autorelease];
    [self presentModalViewController:navController animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.gifts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = @"GiftsCellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    GSGift* gift= (GSGift*)[self.gifts objectAtIndex:indexPath.row];
    NSLog(@"Gift id: %@, name: %@", gift.giftID, gift.name);
    [cell.textLabel setText:gift.name];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (0 == section) {
        return 44.0f;
    }
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (0 == section) {
        UIView* headerView = [[[UIView alloc] initWithFrame:(CGRect){0, 0, tableView.frame.size.width, 44}] autorelease];
        
        UIButton* allButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [allButton setFrame:(CGRect){0, 0, 105, 44}];
        [allButton setTitle:@"All" forState:UIControlStateNormal];
        [headerView addSubview:allButton];
        
        UIButton* availableButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [availableButton setFrame:(CGRect){105, 0, 105, 44}];
        [availableButton setTitle:@"Available" forState:UIControlStateNormal];
        [headerView addSubview:availableButton];
        
        UIButton* boughtButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [boughtButton setFrame:(CGRect){210, 0, 105, 44}];
        [boughtButton setTitle:@"Bought" forState:UIControlStateNormal];
        [headerView addSubview:boughtButton];
        
        return headerView;
    }
    return nil;
}

#pragma mark - RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error
{
    NSLog(@"Error loading gifts");
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects
{
    [_gifts release];
    _gifts = [objects retain];
    [self.tableView reloadData];
}

@end
