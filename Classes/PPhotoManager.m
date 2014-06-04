//
//  PPhotoManager.m
//  Present
//
//  Created by Justin Makaila on 3/30/14.
//  Copyright (c) 2014 Present, Inc. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

#import "PPhotoManager.h"
#import "PEditPhotoViewController.h"

@interface PPhotoManager () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, PPhotoCropViewControllerDelegate> {
    UIStatusBarStyle defaultStatusBarStyle;
}

@property (weak, nonatomic) UIViewController *viewController;

@end

static NSString *LibraryTitle   = @"Choose From Library";
static NSString *TakePhotoTitle = @"Take Photo";
static NSString *CancelTitle    = @"Cancel";

@implementation PPhotoManager

- (id)initWithViewController:(UIViewController *)viewController delegate:(id<PPhotoManagerDelegate>)delegate {
    self = [super init];
    if (self) {
        self.viewController = viewController;
        self.delegate = delegate;
        
        defaultStatusBarStyle = [[UIApplication sharedApplication] statusBarStyle];
    }
    
    return self;
}

- (void)showActionSheet {
    [self showActionSheetInView:_viewController.view];
}

- (void)showActionSheetInView:(UIView*)view {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:CancelTitle
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:LibraryTitle, TakePhotoTitle, nil];
    
    [actionSheet showInView:view];
}

#pragma mark - UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
    } else if (buttonIndex == 1) {
        [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
    }
}

#pragma mark - UIStatusBarStyle Helpers

- (void)setStatusBarStyleForImagePickerControllerAnimated:(BOOL)animated {
    [self setStatusBarStyle:UIStatusBarStyleDefault animated:animated];
}

- (void)resetStatusBarStyleAnimated:(BOOL)animated {
    [self setStatusBarStyle:defaultStatusBarStyle animated:animated];
}

- (void)setStatusBarStyle:(UIStatusBarStyle)style animated:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarStyle:style animated:animated];
}

#pragma mark - UIImagePicker Delegate

- (void)showImagePicker:(UIImagePickerControllerSourceType)imagePickerSource {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = imagePickerSource;
    imagePickerController.allowsEditing = NO;
    imagePickerController.delegate = self;
    
    imagePickerController.navigationBar.tintColor = [UIColor blackColor];
    imagePickerController.navigationBar.barTintColor = [UIColor whiteColor];

    
    if (imagePickerSource == UIImagePickerControllerSourceTypeCamera) {
        imagePickerController.showsCameraControls = YES;
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:imagePickerSource]) {
        [_viewController presentViewController:imagePickerController animated:YES completion:^{
            [self setStatusBarStyleForImagePickerControllerAnimated:YES];
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    PEditPhotoViewController *photoEditController = [[PEditPhotoViewController alloc] initWithNibName:@"PhotoEditorViewController" bundle:nil];
    photoEditController.delegate = self;
    photoEditController.panEnabled = YES;
    photoEditController.scaleEnabled = YES;
    photoEditController.tapToResetEnabled = YES;
    photoEditController.rotateEnabled = NO;
    photoEditController.cropSize = CGSizeMake(310, 310);
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSURL *assetURL = [info objectForKey:UIImagePickerControllerMediaURL];
    
    [[[ALAssetsLibrary alloc] init] assetForURL:assetURL resultBlock:^(ALAsset *asset) {
        photoEditController.sourceImage = image;
        
        [picker pushViewController:photoEditController animated:YES];
        [picker setNavigationBarHidden:YES animated:NO];
    }failureBlock:^(NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Sorry!"
                                    message:@"Something went wrong while trying to get your profile picture. Please try again."
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil] show];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self resetStatusBarStyleAnimated:YES];
}

#pragma mark - PPhotoCropController Delegate

- (void)photoCropController:(PPhotoCropViewController *)controller didSelectImage:(UIImage *)image {
    [_delegate photoManager:self didSelectImage:image];
    [self dismissCropController];
}

- (void)photoCropControllerDidCancel:(PPhotoCropViewController *)controller {
    if ([_delegate respondsToSelector:@selector(photoManagerDidCancel:)]) {
        [_delegate photoManagerDidCancel:self];
    }
    
    [self dismissCropController];
}

- (void)dismissCropController {
    [_viewController dismissViewControllerAnimated:YES completion:nil];
    [self resetStatusBarStyleAnimated:YES];
}

@end
