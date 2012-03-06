//
//  GSLoginViewController.m
//  GivingSocially
//
//  Created by Scott Penrose on 2/4/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSLoginViewController.h"
#import "GSUser.h"
#import "Facebook.h"
#import "GSAppDelegate.h"

@interface GSLoginViewController ()

@property (nonatomic, retain) UITextField* emailTextField;
@property (nonatomic, retain) UITextField* passwordTextField;
@property (nonatomic, assign) BOOL isLoggingInWithFacebook;
@property (nonatomic, retain) NSMutableDictionary* facebookSigninCredentials;

@end

@implementation GSLoginViewController

@synthesize emailTextField = _emailTextField;
@synthesize passwordTextField = _passwordTextField;
@synthesize facebookSigninCredentials;
@synthesize isLoggingInWithFacebook;

- (id)init 
{
    self = [super init];
    if (self) {
        _emailTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    }
    return self;
}

-(void)dealloc{
    [_emailTextField release];
    [_passwordTextField release];
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor greenColor]];
    
    self.isLoggingInWithFacebook = NO;
    
    [self.emailTextField setFrame:(CGRect){ 10, 30, 300, 20 }];
    [self.emailTextField setPlaceholder:@"email"];
    [self.emailTextField setText:@"kitten@puppy.com"];
    [self.view addSubview:self.emailTextField];
    
    [self.passwordTextField setFrame:(CGRect){ 10, 70, 300, 20 }];
    [self.passwordTextField setPlaceholder:@"password"];
    [self.passwordTextField setText:@"kitten_little"];
    [self.view addSubview:self.passwordTextField];
    
    UIButton* login = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [login setTitle:@"Sign In" forState:UIControlStateNormal];
    [login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [login setFrame:(CGRect){ 100, 100, 120, 30 }];
    [self.view addSubview:login];
    
    UIButton* facebookButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [facebookButton setTitle:@"FB Login" forState:UIControlStateNormal];
    [facebookButton addTarget:self action:@selector(facebookLoginButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [facebookButton setFrame:(CGRect){ 100, 150, 120, 30 }];
    [self.view addSubview:facebookButton];
}

- (void)login
{
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/users/sign_in" usingBlock:^(RKObjectLoader *loader) {
        loader.delegate = self;
        loader.method = RKRequestMethodPOST;
        
        NSDictionary* userParams;
        
        if(!self.isLoggingInWithFacebook){
            userParams = [NSDictionary dictionaryWithObjectsAndKeys:
                          self.emailTextField.text, @"email",
                          self.passwordTextField.text, @"password",
                          nil];
        }else{
            userParams = self.facebookSigninCredentials;
        }
        
        NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:userParams, @"user", nil];
        loader.params = params;
    }];
}

- (void)dismiss
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Facebook Delegate

-(void)fbDidLogin {
    [self setupFacebookSigninCredentials];
    self.isLoggingInWithFacebook = YES;
    // Pass on facebook information to the backend and sign_in to the app.
}

-(void)fbDidNotLogin:(BOOL)cancelled{
    NSLog(@"Did not log in to Facebook.");
}


-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt{
    NSLog(@"Extended Facebook token, update cached token please!");
}

-(void)fbSessionInvalidated{
    NSLog(@"Facebook session has been invalidated.");
}

-(void)fbDidLogout{
    NSLog(@"Logged out of Facebook!");
}


- (void)request:(FBRequest *)request didFailWithError:(NSError *)error{
    
}

- (void)request:(FBRequest *)request didLoad:(id)result{
    NSDictionary *userData = [NSDictionary dictionaryWithDictionary:(NSDictionary*)result];
    // fill up the rest of the required credentials for Facebook sign in.
    [self.facebookSigninCredentials setValue:[userData valueForKey:@"first_name"] forKey:@"first_name"];
    [self.facebookSigninCredentials setValue:[userData valueForKey:@"last_name"] forKey:@"last_name"];
    [self.facebookSigninCredentials setValue:[userData valueForKey:@"email"] forKey:@"email"];
    NSLog(@"loaded user data from Facebook.");
    // Pass on facebook information to the backend and sign_in to the app.
    [self login];
}

#pragma mark - Button Actions

- (void)facebookLoginButtonTouched:(id)sender{

    NSLog(@"Facebook login");
    GSAppDelegate* appDelegateInstance = (GSAppDelegate*)[[UIApplication sharedApplication] delegate];
    if(![appDelegateInstance.facebook isSessionValid]){
        [appDelegateInstance.facebook authorize:[NSArray arrayWithObjects:@"publish_stream",@"offline_access",@"email", nil]];
    }else {
        [self setupFacebookSigninCredentials];
        self.isLoggingInWithFacebook = YES;
    }
}

-(void) setupFacebookSigninCredentials{
    #warning TODO: Use RKObjectmMapping defult date formatter when its fixed! 
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle: NSDateFormatterShortStyle];
    
    GSAppDelegate* appDelegateInstance = (GSAppDelegate*)[[UIApplication sharedApplication] delegate];
    // Initialize a dictionary with Facebook credentials for Facebook sign_in.
    self.facebookSigninCredentials = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      appDelegateInstance.facebook.accessToken, @"facebook_token",
                                      [dateFormatter stringFromDate:appDelegateInstance.facebook.expirationDate], @"facebook_token_expire_at",
                                      nil]; 
    [appDelegateInstance.facebook requestWithGraphPath:@"me" andDelegate:self];
    [dateFormatter release];
}

#pragma mark - RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error
{
#warning TODO: Handle login failure
    NSLog(@"Failed to login: %@", [error localizedDescription]);
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects
{
    if ([objects count] > 0) {
        NSLog(@"Logged in");
        GSUser* user = [GSUser currentUser];
        [[RKObjectManager sharedManager].client.HTTPHeaders setValue:user.authToken forKey:GSAuthTokenHeaderKey];
        [self dismissModalViewControllerAnimated:YES];
    }
}

@end
