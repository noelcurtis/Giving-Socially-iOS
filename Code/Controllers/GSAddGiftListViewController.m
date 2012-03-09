
//
//  GSAddGiftListViewController.m
//  GivingSocially
//
//  Created by Scott Penrose on 3/5/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSAddGiftListViewController.h"
#import "GSPickerTextField.h"
#import "GSGiftList.h"

@interface GSAddGiftListViewController ()

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) UITextField *listNameTextField;
@property (nonatomic, retain) GSPickerTextField *eventDateTextField;
@property (nonatomic, retain) UIDatePicker *eventDatePicker;

- (void)postListToServer;

@end

@implementation GSAddGiftListViewController

@synthesize dismissHandler = _dismissHandler;
@synthesize tableView = _tableView;
@synthesize listNameTextField = _listNameTextField, eventDateTextField = _eventDateTextField, eventDatePicker = _eventDatePicker;

- (void)dealloc
{
    [_dismissHandler release];
    [_tableView release];
    [_listNameTextField release];
    [_eventDateTextField release];
    [_eventDatePicker release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"New List";
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        _listNameTextField = [[UITextField alloc] initWithFrame:(CGRect){130, 10, 170, 34}];
        _eventDateTextField = [[GSPickerTextField alloc] initWithFrame:(CGRect){130, 10, 170, 34}];
        _eventDatePicker = [[UIDatePicker alloc] initWithFrame:(CGRect){0, 0, 100, 100}];
    }
    return self;
}

- (void)loadView
{
    self.view = [[[UIView alloc] initWithFrame:(CGRect){0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 20}] autorelease];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationItem setLeftBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss)] autorelease]];
    [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveList)] autorelease]];
    
    [self.eventDatePicker setDatePickerMode:UIDatePickerModeDate];
    [self.eventDatePicker setMinimumDate:[NSDate date]];
    [self.eventDatePicker setMaximumDate:[NSDate dateWithTimeIntervalSinceNow:(60 * 60 * 24 * 7 * 52)]];
    [self.eventDatePicker addTarget:self action:@selector(eventDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self eventDatePickerValueChanged:self.eventDatePicker]; // Force setting time at start
    
    [self.eventDateTextField setInputView:self.eventDatePicker];
    
    [self.tableView setFrame:(CGRect){0, 0, self.view.frame.size.width, self.view.frame.size.height - 44}];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
}

- (void)dismiss
{
    NSAssert(self.dismissHandler, @"No dismiss handler");
    if (self.dismissHandler) {
        self.dismissHandler(self);
    }
}

- (void)eventDatePickerValueChanged:(id)sender
{
	NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
	df.dateStyle = NSDateFormatterMediumStyle;
	self.eventDateTextField.text = [NSString stringWithFormat:@"%@", [df stringFromDate:self.eventDatePicker.date]];
}

#pragma mark - Buttons

- (void)saveList
{   
    if ([self.listNameTextField.text length] > 0) {
        [self postListToServer];
    } else {
        [[[[UIAlertView alloc] initWithTitle:@"" message:@"You must fill out all fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
    }
}

#pragma mark - 

- (void)postListToServer
{
    GSGiftList* giftList = [GSGiftList createEntity];
    [giftList setName:self.listNameTextField.text];
    [giftList setDueDate:self.eventDatePicker.date];
    NSError* error = nil;
    [[giftList managedObjectContext] save:&error];
    if (error) {
        NSLog(@"Error saving gift list: %@", [error localizedDescription]);
    }
    
    [[RKObjectManager sharedManager] postObject:giftList delegate:self];
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
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
            [cell.textLabel setText:@"List Name"];
            [cell addSubview:self.listNameTextField];
            break;
        case 1:
            [cell.textLabel setText:@"Event Date"];
            [cell addSubview:self.eventDateTextField];
            break;
            
        default:
            break;
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

#pragma mark - RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Failed to save Gift List");
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object
{
    NSLog(@"Saved gift list");
    [self dismiss];
}

@end
