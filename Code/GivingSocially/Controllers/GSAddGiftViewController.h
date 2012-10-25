//
//  GSAddGiftViewController.h
//  GivingSocially
//
//  Created by Scott Penrose on 2/28/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import <RestKit/RestKit.h>

@interface GSAddGiftViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate>

- (id)initWithGiftListID:(NSNumber*)giftListID;

@end
