//
//  GSLoginViewController.m
//  GivingSocially
//
//  Created by Scott Penrose on 2/4/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSLoginViewController.h"
#import "GSUser.h"

@interface GSLoginViewController ()

@property (nonatomic, retain) UITextField* emailTextField;
@property (nonatomic, retain) UITextField* passwordTextField;

@end

@implementation GSLoginViewController

@synthesize emailTextField = _emailTextField;
@synthesize passwordTextField = _passwordTextField;

- (id)init 
{
    self = [super init];
    if (self) {
        _emailTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor greenColor]];
    
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
        
        NSDictionary* userParams = [NSDictionary dictionaryWithObjectsAndKeys:
                                    self.emailTextField.text, @"email",
                                    self.passwordTextField.text, @"password",
                                    nil];
        
        NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:userParams, @"user", nil];
        loader.params = params;
    }];
}

- (void)dismiss
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Button Actions

- (void)facebookLoginButtonTouched:(id)sender
{
    NSLog(@"Facebook login");
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
