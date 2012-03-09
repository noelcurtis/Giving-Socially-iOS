//
//  GSPickerTextField.m
//  GivingSocially
//
//  Created by Scott Penrose on 3/8/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSPickerTextField.h"

@implementation GSPickerTextField

- (CGRect)caretRectForPosition:(UITextPosition *)position 
{
    // Hides the caret
    return CGRectZero;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender 
{
    // Doesn't allow you to paste from clipboard
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

@end
