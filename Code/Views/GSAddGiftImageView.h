//
//  GSAddGiftImageView.h
//  GivingSocially
//
//  Created by Scott Penrose on 3/1/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GSDisplayImagePickerHandler)(UIImagePickerController *imagePickerController);
typedef void(^GSDismissImagePickerHandler)(UIImagePickerController *imagePickerController);

@interface GSAddGiftImageView : UIView <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, retain) UIImageView *giftImageView;
@property (nonatomic, copy) GSDisplayImagePickerHandler displayImagePickerHandler;
@property (nonatomic, copy) GSDismissImagePickerHandler dismissImagePickerHandler;

@property (nonatomic, retain) UIImagePickerController *imagePickerController;

@end
