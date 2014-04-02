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

@interface PPhotoManager () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, PPhotoCropViewControllerDelegate>

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

#pragma mark - UIImagePicker Delegate

- (void)showImagePicker:(UIImagePickerControllerSourceType)imagePickerSource {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = imagePickerSource;
    imagePickerController.allowsEditing = NO;
    imagePickerController.delegate = self;
    
    if (imagePickerSource == UIImagePickerControllerSourceTypeCamera) {
        imagePickerController.showsCameraControls = YES;
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:imagePickerSource]) {
        [_viewController presentViewController:imagePickerController animated:YES completion:nil];
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
        NSLog(@"Failed to get asset from library");
    }];
}

#pragma mark - PPhotoCropController Delegate

- (void)photoCropController:(PPhotoCropViewController *)controller didSelectImage:(UIImage *)image {
    [_delegate photoManager:self didSelectImage:image];
    [self dismissCropController];
}

- (void)photoCropControllerDidCancel:(PPhotoCropViewController *)controller {
    [self dismissCropController];
}

- (void)dismissCropController {
    [_viewController dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

@end
