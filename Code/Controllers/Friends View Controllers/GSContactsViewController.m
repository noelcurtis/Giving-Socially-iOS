//
//  GSContactsViewController.m
//  GivingSocially
//
//  Created by Noel Curtis on 3/6/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSContactsViewController.h"
#import <AddressBook/AddressBook.h>
#import "GSContact.h"
#import "GSUser.h"

@interface GSContactsViewController ()
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray* contacts;
@property (nonatomic, retain) NSMutableArray* emailAddresses;
@property (nonatomic, retain) NSArray* potentialFriends;

@end

@implementation GSContactsViewController
@synthesize tableView = _tableView;
@synthesize contacts = _contacts;
@synthesize emailAddresses = _emailAddresses;
@synthesize potentialFriends = _potentialFriends;

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
    self.potentialFriends = [[NSArray alloc] init];
    [self getAllContacts];
    [self postEmailAddresses];
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
    
    [_potentialFriends release];
    [_contacts release];
    [_emailAddresses release];
    [_tableView release];
    [super dealloc];
}

-(void) getAllContacts{
    _emailAddresses = [[NSMutableArray alloc] init];
    _contacts = [[NSMutableArray alloc] init];
    
    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    for (CFIndex i = 0; i< CFArrayGetCount(people) ; i++) {
        ABRecordRef *personRecord = (ABRecordRef*)CFArrayGetValueAtIndex(people, i);
        GSContact* newContact = [[GSContact alloc] init];
        [newContact setEmailAddresses:[[NSMutableArray alloc]init]];
        ABMultiValueRef emails = ABRecordCopyValue(personRecord, kABPersonEmailProperty);
        for (CFIndex j=0; j < ABMultiValueGetCount(emails); j++) {
            NSString* email = (NSString*)ABMultiValueCopyValueAtIndex(emails, j);
            [_emailAddresses addObject:email];
            [newContact.emailAddresses addObject:email];
            [email release];
        }
        NSString* firstName = (NSString*)ABRecordCopyValue(personRecord, kABPersonFirstNameProperty);
        NSString* lastName = (NSString*)ABRecordCopyValue(personRecord, kABPersonLastNameProperty);
        [newContact setLastName:lastName];
        [newContact setFirstName:firstName];
        [_contacts addObject:newContact];
        [firstName release];
        [lastName release];
        CFRelease(emails);
    }
}

-(void) postEmailAddresses{
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/friends/find.json" usingBlock:^(RKObjectLoader *loader) {
        loader.delegate = self;
        loader.method = RKRequestMethodPOST;
        
        NSDictionary* userParams;
        
        userParams = [NSDictionary dictionaryWithObjectsAndKeys:
                          _emailAddresses, @"email_addresses",
                          nil];
                
        loader.params = userParams;
    }];

}

#pragma mark - UITableViewDataSource

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Contacts using GiftApp";
    }else if (section == 1) {
        return @"Invite to GiftApp";
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
        {
            if(self.potentialFriends.count > 0)
                return self.potentialFriends.count;
            else
                return 0;
            break;
        }
        case 1:
        {
            return _contacts.count - _potentialFriends.count;
            break;
        }
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
    
    if (indexPath.section == 0) {
        [cell.textLabel setText:((GSUser*)[self.potentialFriends objectAtIndex:indexPath.row]).fullName];
    }else {
        [cell.textLabel setText:((GSContact*)[self.contacts objectAtIndex:indexPath.row]).firstName];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error
{
    NSLog(@"Failed to load potential friends: %@", [error localizedDescription]);
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects
{
    if ([objects count] > 0) {
        self.potentialFriends = [NSArray arrayWithArray:objects];
    }
    [self.tableView reloadData];
}


@end
