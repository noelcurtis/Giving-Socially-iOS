//
//  GSHomeViewController.m
//  GivingSocially
//
//  Created by Scott Penrose on 2/2/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSHomeViewController.h"
#import "GSGiftList.h"
#import "GSGiftListViewController.h"
#import "GSAddGiftListViewController.h"

@interface GSHomeViewController ()

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) NSArray* giftLists;

@end

@implementation GSHomeViewController

@synthesize tableView = _tableView;
@synthesize giftLists = _giftLists;

- (void)dealloc 
{
    [_tableView release];
    [_giftLists release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _giftLists = [[NSArray alloc] init];
    }
    return self;
}

- (void)loadView
{
    self.view = [[[UIView alloc] initWithFrame:(CGRect){0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 20}] autorelease];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createGiftList:)] autorelease]];
    
    _tableView = [[UITableView alloc] initWithFrame:(CGRect){0, 0, self.view.frame.size.width, self.view.frame.size.height - 44} style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/gift_lists" delegate:self];
}

- (void)setupTable
{
    self.giftLists = [GSGiftList findAll];
    [self.tableView reloadData];
}

#pragma mark - Buttons

- (void)createGiftList:(id)sender
{
    NSLog(@"Create gift lists");
    GSAddGiftListViewController *addGiftListVC = [[[GSAddGiftListViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    [addGiftListVC setDismissHandler:^(UIViewController *viewController) {
        [viewController dismissModalViewControllerAnimated:YES];
    }];
    UINavigationController* navController = [[[UINavigationController alloc] initWithRootViewController:addGiftListVC] autorelease];
    [self presentModalViewController:navController animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.giftLists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"GiftListCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    GSGiftList *giftList = (GSGiftList*)[self.giftLists objectAtIndex:indexPath.row];
    NSLog(@"Gift list id:%@, name:%@", giftList.giftListID, giftList.name);
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", giftList.name]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GSGiftList *giftList = (GSGiftList*)[self.giftLists objectAtIndex:indexPath.row];
    GSGiftListViewController* giftListVC = [[[GSGiftListViewController alloc] initWithGiftList:giftList] autorelease];
    [self.navigationController pushViewController:giftListVC animated:YES];
}

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