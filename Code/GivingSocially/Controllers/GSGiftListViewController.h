//
//  GSGiftListViewController.h
//  GivingSocially
//
//  Created by Scott Penrose on 2/12/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import <RestKit/RestKit.h>
#import "GSGiftList.h"
@interface GSGiftListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (id)initWithGiftList:(GSGiftList*)giftList;

@end
