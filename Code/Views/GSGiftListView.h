//
//  GSGiftListView.h
//  GivingSocially
//
//  Created by Scott Penrose on 2/12/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSGiftList.h"

@interface GSGiftListView : UIView

@property (nonatomic, retain) GSGiftList* giftList;

- (id)initWithFrame:(CGRect)frame giftList:(GSGiftList*)giftList;

@end
