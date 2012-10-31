//
//  GSAddGiftImageView.m
//  GivingSocially
//
//  Created by Scott Penrose on 3/1/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSAddGiftImageView.h"

@interface GSAddGiftImageView ()

@property (nonatomic, retain) UIButton *takePhotoButton;
@property (nonatomic, retain) UIButton *selectPhotoButton;

@end

@implementation GSAddGiftImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor redColor]];
        
        _giftImageView = [[UIImageView alloc] initWithFrame:(CGRect){10, 15, 165, 110}];
        [self.giftImageView setBackgroundColor:[UIColor blackColor]];
        [self.giftImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:self.giftImageView];
        
        _takePhotoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.takePhotoButton setFrame:(CGRect){self.frame.size.width - 100 - 10, 40, 100, 25}];
        [self.takePhotoButton setTitle:@"Take Photo" forState:UIControlStateNormal];
        [self.takePhotoButton addTarget:self action:@selector(takePhotoButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.takePhotoButton];
        
        _selectPhotoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.selectPhotoButton setFrame:(CGRect){self.frame.size.width - 100 - 10, 75, 100, 25}];
        [self.selectPhotoButton setTitle:@"Select Photo" forState:UIControlStateNormal];
        [self.selectPhotoButton addTarget:self action:@selector(selectPhotoButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.selectPhotoButton];
        
        _imagePickerController = [[UIImagePickerController alloc] init];
        [self.imagePickerController setDelegate:self];
    }
    return self;
}

#pragma mark - Buttons

- (void)takePhotoButtonTouched:(id)sender
{
    NSLog(@"Take Photo Button");
    
    if (self.displayImagePickerHandler && 
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) 
    {
        [self.imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        self.displayImagePickerHandler(self.imagePickerController);
    }
}

- (void)selectPhotoButtonTouched:(id)sender
{
    NSLog(@"Select Photo Button");
    
    if (self.displayImagePickerHandler &&
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) 
    {
        [self.imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        self.displayImagePickerHandler(self.imagePickerController);
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"Finish picking media");
    
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.giftImageView setImage:image];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    
    if (self.dismissImagePickerHandler) {
        self.dismissImagePickerHandler(self.imagePickerController);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"Cancel picker");
    
    if (self.dismissImagePickerHandler) {
        self.dismissImagePickerHandler(self.imagePickerController);
    }
}

#pragma mark - Image

- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    NSLog(@"Image did finish saving");
}

@end
