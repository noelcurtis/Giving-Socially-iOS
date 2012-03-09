//
//  GSAddGiftListViewController.h
//  GivingSocially
//
//  Created by Scott Penrose on 3/5/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import <RestKit/RestKit.h>

@interface GSAddGiftListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, RKObjectLoaderDelegate>

@property (nonatomic, copy) GSDismissHandler dismissHandler;

@end
