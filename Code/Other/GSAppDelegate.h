//
//  GSAppDelegate.h
//  GivingSocially
//
//  Created by Scott Penrose on 1/25/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import "FBConnect.h"

@interface GSAppDelegate : UIResponder <UIApplicationDelegate, FBSessionDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, readonly) IIViewDeckController *deckControllerInstance;
@property (nonatomic, retain) Facebook *facebook;

@end
