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
    
    _accountHeaderView = [[GSAccountHeaderView alloc] initWithFrame:(CGRect){0, 0, self.view.frame.size.width, 29}];
    
    _tableView = [[UITableView alloc] initWithFrame:(CGRect){ 0, 0, self.view.frame.size } style:UITableViewStylePlain];
    [self.tableView setTableHeaderView:_accountHeaderView];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = @"AccountSettingsCellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];
    }
    [cell.textLabel setText:@"Sign In"];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:@"Sign In"]) {
        GSLoginViewController* loginVC = [[[GSLoginViewController alloc] init] autorelease];
        [self presentModalViewController:loginVC animated:YES];
    }
}

@end
