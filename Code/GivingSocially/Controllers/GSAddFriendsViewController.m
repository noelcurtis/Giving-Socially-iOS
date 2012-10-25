//
//  GSAddFriendsViewController.m
//  GivingSocially
//
//  Created by Noel Curtis on 3/6/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSAddFriendsViewController.h"
#import "GSContactsViewController.h"
#import "GSEmailInviteViewController.h"

@interface GSAddFriendsViewController ()
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GSAddFriendsViewController
@synthesize tableView = _tableView;

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

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}


#pragma mark - UITableViewDataSource

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"Friend Suggestions";
    }else {
        return nil;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 10;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = @"GiftListCellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    [cell.textLabel setText:@"Contacts"];
                    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                    break;
                case 1:
                    [cell.textLabel setText:@"Facebook"];
                    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                    break;
                case 2:
                    [cell.textLabel setText:@"Invite"];
                    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                    break;
                default:
                    break;
            }
            break;
        case 1:
            [cell.textLabel setText:@"Friend Suggestion"]; 
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            break; 
            
        default:
            break;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
            {
                GSContactsViewController* contactsViewController = [[GSContactsViewController alloc] initWithNibName:nil bundle:nil];
                [self.navigationController pushViewController:contactsViewController animated:YES];
                break; 
            }
            case 1:
            {
                // TODO: Push Facebook Friends Controller 
                break; 
            }
            case 2:
            {
                GSEmailInviteViewController* emailInviteViewController = [[GSEmailInviteViewController alloc] initWithNibName:nil bundle:nil];
                [self.navigationController pushViewController:emailInviteViewController animated:YES];
                break; 
            }
            
            default:
                break;
        }
    }else {
        return;
    }
    
}

@end
