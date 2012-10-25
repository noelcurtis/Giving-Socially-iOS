//
//  GSAccountHeaderView.m
//  GivingSocially
//
//  Created by Scott Penrose on 2/12/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSAccountHeaderView.h"
#import "GSUser.h"

@interface GSAccountHeaderView ()

@property (nonatomic, retain) UILabel* nameLabel;

@end

@implementation GSAccountHeaderView

@synthesize nameLabel = _nameLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:(CGRect){frame.origin, frame.size.width, 29}];
        
        GSUser* user = [GSUser currentUser];
        
        _nameLabel = [[UILabel alloc] initWithFrame:(CGRect){10, 5, frame.size.width - 20, 19}];
        [_nameLabel setText:[user fullName]];
        [self addSubview:_nameLabel];       
    }
    return self;
}

@end
