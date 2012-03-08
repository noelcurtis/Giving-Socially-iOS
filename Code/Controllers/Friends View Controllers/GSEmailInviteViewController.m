//
//  GSEmailInviteViewController.m
//  GivingSocially
//
//  Created by Noel Curtis on 3/7/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSEmailInviteViewController.h"

@interface GSEmailInviteViewController ()
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) UITextField *firstNameTextField;
@property (nonatomic, retain) UITextField *lastNameTextField;
@property (nonatomic, retain) UITextField *emailTextField;

@end

@implementation GSEmailInviteViewController
@synthesize tableView = _tableView;
@synthesize firstNameTextField = _firstNameTextField;
@synthesize lastNameTextField = _lastNameTextField;
@synthesize emailTextField = _emailTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _firstNameTextField = [[UITextField alloc] initWithFrame:(CGRect){20, 10, 280, 34}];
        _lastNameTextField = [[UITextField alloc] initWithFrame:(CGRect){20, 10, 280, 34}];
        _emailTextField = [[UITextField alloc] initWithFrame:(CGRect){20, 10, 280, 34}];
        [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(sendInvitationEmail)] autorelease]]; 
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_firstNameTextField setPlaceholder:@"First Name"];
    [_lastNameTextField setPlaceholder:@"Last Name"];
    [_emailTextField setPlaceholder:@"Email Address"];
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
    [_firstNameTextField release];
    [_lastNameTextField release];
    [_emailTextField release];
    [_tableView release];
    [super dealloc];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = @"GiftListCellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    switch (indexPath.row) {
        case 0:
            [cell addSubview:_firstNameTextField];
            break;
        case 1:
            [cell addSubview:_lastNameTextField];
            break;
        case 2:
            [cell addSubview:_emailTextField];
            break;
            
        default:
            break;
    }
    return cell;
}

-(void) sendInvitationEmail{
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/users/invite" usingBlock:^(RKObjectLoader *loader) {
        loader.delegate = self;
        loader.method = RKRequestMethodPOST;
        
        NSString* firstName = _firstNameTextField.text;
        NSString* lastName = _lastNameTextField.text;
        NSString* email = _emailTextField.text;
        
        NSDictionary*  userParams = [NSDictionary dictionaryWithObjectsAndKeys:
                      firstName, @"first_name",
                      lastName, @"last_name",
                      email, @"email",
                      nil];
        
        NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:userParams, @"user", nil];
        loader.params = params;
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error
{
    NSLog(@"Failed to send email: %@", [error localizedDescription]);
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"We have sent an email invite on your behalf." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    _emailTextField.text = @"";
    _firstNameTextField.text = @"";
    _lastNameTextField.text = @"";
    self.navigationItem.rightBarButtonItem.enabled = YES;
}


@end
