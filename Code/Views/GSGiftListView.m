//
//  GSGiftListView.m
//  GivingSocially
//
//  Created by Scott Penrose on 2/12/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSGiftListView.h"

@interface GSGiftListView ()

@property (nonatomic, retain) UILabel* nameLabel;
@property (nonatomic, retain) UILabel* dateLabel;

@end

@implementation GSGiftListView

@synthesize giftList = _giftList;
@synthesize nameLabel = _nameLabel, dateLabel = _dateLabel;

- (void)dealloc 
{
    [_giftList release];
    [_nameLabel release];
    [_dateLabel release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame giftList:(GSGiftList*)giftList
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:(CGRect){frame.origin, 320, 82}];
        _giftList = [giftList retain];
        
        _nameLabel = [[UILabel alloc] initWithFrame:(CGRect){30, 10, 280, 20}];
        [_nameLabel setText:_giftList.name];
        [self addSubview:_nameLabel];
        
        _dateLabel = [[UILabel alloc] initWithFrame:(CGRect){30, 40, 280, 20}];
        [_dateLabel setText:[NSString stringWithFormat:@"%@", _giftList.dueDate]];
        [self addSubview:_dateLabel];
    }
    return self;
}

@end
