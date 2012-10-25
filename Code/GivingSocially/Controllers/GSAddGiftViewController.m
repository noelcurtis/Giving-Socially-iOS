
//  GSAddGiftViewController.m
//  GivingSocially
//
//  Created by Scott Penrose on 2/28/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSAddGiftViewController.h"
#import "GSAddGiftImageView.h"
#import "GSGift.h"

@interface GSAddGiftViewController ()

@property (nonatomic, retain) NSNumber* giftListID;

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) UITextField *nameTextField;
@property (nonatomic, retain) UITextField *urlTextField;
@property (nonatomic, retain) UITextField *descriptionTextField;

@property (nonatomic, retain) GSAddGiftImageView *addGiftImageView;

@end

@implementation GSAddGiftViewController

@synthesize giftListID = _giftListID;
@synthesize tableView = _tableView;
@synthesize nameTextField = _nameTextField, urlTextField = _urlTextField, descriptionTextField = _descriptionTextField;
@synthesize addGiftImageView = _addGiftImageView;

- (void)dealloc
{
    [_giftListID release];
    [_tableView release];
    [_nameTextField release];
    [_urlTextField release];
    [_descriptionTextField release];
    [_addGiftImageView release];
    [super dealloc];
}

- (id)initWithGiftListID:(NSNumber*)giftListID
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.giftListID = giftListID;
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        _nameTextField = [[UITextField alloc] initWithFrame:(CGRect){20, 10, 280, 34}];
        _urlTextField = [[UITextField alloc] initWithFrame:(CGRect){20, 10, 280, 34}];
        _descriptionTextField = [[UITextField alloc] initWithFrame:(CGRect){20, 10, 280, 34}];
    }
    return self;
}

- (void)loadView
{
    self.view = [[[UIView alloc] initWithFrame:(CGRect){0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 44}] autorelease];
    [self.view setBackgroundColor:[UIColor redColor]];
    
    [self.navigationItem setLeftBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss:)] autorelease]];
    [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveGift:)] autorelease]];
    
    _addGiftImageView = [[GSAddGiftImageView alloc] initWithFrame:(CGRect){0, 0, self.view.frame.size.width, 145}];
    GSDisplayImagePickerHandler displayImagePickerHandler = ^(UIImagePickerController *imagePickerController) {
        [self presentViewController:imagePickerController animated:YES completion:nil];
    };
    [self.addGiftImageView setDisplayImagePickerHandler:displayImagePickerHandler];
    GSDismissImagePickerHandler dismissImagePickerHandler = ^(UIImagePickerController *imagePickerController) {
        [imagePickerController dismissModalViewControllerAnimated:YES];
    };
    [self.addGiftImageView setDismissImagePickerHandler:dismissImagePickerHandler];
    
    [self.nameTextField setPlaceholder:@"Item Name"];
    [self.urlTextField setPlaceholder:@"URL"];
    [self.descriptionTextField setPlaceholder:@"Description"];
    
    [_tableView setFrame:self.view.frame];
    [self.tableView setTableHeaderView:self.addGiftImageView];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
}

- (void)dismiss:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)saveGift:(id)sender
{
    NSLog(@"Save Gift");
    
    GSGift* gift = [GSGift createEntity];
    [gift setName:self.nameTextField.text];
    [gift setExampleURL:self.urlTextField.text];
    [gift setGiftListID:self.giftListID];
    NSError* error = nil;
    [[gift managedObjectContext] save:&error];
    if (error) {
        NSLog(@"Error saving gift: %@", [error localizedDescription]);
    }
    
    [[RKObjectManager sharedManager] postObject:gift usingBlock:^(RKObjectLoader *loader) {
        loader.delegate = self;
    }];
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"row-%i", indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];
    }
    
    switch (indexPath.row) {
        case 0:
            [cell addSubview:self.nameTextField];
            break;
        case 1:
            [cell addSubview:self.urlTextField];
            break;
        case 2:
            [cell addSubview:self.descriptionTextField];
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error adding gift: %@", [error localizedDescription]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object
{
    NSLog(@"added gift: %@", object);
}

@end
