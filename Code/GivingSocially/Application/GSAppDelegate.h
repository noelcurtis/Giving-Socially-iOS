//
//  GSAppDelegate.h
//  GivingSocially
//
//  Created by Scott Penrose on 1/25/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface GSAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, readonly, strong) IIViewDeckController *deckControllerInstance;

@end
