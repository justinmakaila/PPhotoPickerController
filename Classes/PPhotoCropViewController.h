//
//  XWEditPhotoViewController.h
//  XWEditPhotoDemo
//
//  Created by Xiaonan Wang on 10/5/13.
//  Copyright (c) 2013 Xiaonan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PCropWindow.h"

@class PPhotoCropViewController;

@protocol PPhotoCropViewControllerDelegate

- (void)photoCropController:(PPhotoCropViewController*)controller didSelectImage:(UIImage *)image;
- (void)photoCropControllerDidCancel:(PPhotoCropViewController *)controller;

@end

@interface PPhotoCropViewController : UIViewController <UIGestureRecognizerDelegate>

@property (unsafe_unretained) IBOutlet id<PPhotoCropViewControllerDelegate> delegate;

/**
 *  The image to be edited
 */
@property (nonatomic,copy) UIImage *sourceImage;

/**
 *  The window where the crop will happen
 */
@property (nonatomic, strong) IBOutlet PCropWindow *cropWindow;

/**
 *  The size of the crop window
 */
@property (nonatomic, assign) CGSize cropSize;

/**
 *  Is panning enabled?
 */
@property (nonatomic, assign) BOOL panEnabled;

/**
 *  Is rotation enabled?
 */
@property (nonatomic, assign) BOOL rotateEnabled;

/**
 *  Is scaling enabled?
 */
@property (nonatomic, assign) BOOL scaleEnabled;

/**
 *  Is tap to reset enabled?
 */
@property (nonatomic, assign) BOOL tapToResetEnabled;

/**
 *  Minimum image scaling
 */
@property (nonatomic, assign) CGFloat minimumScale;

/**
 *  Maximum image scaling
 */
@property (nonatomic, assign) CGFloat maximumScale;

/**
 *  Resets the image to the center of the view
 *
 *  @param animated Should this be animated?
 */
-(void)reset:(BOOL)animated;

/**
 *  Called when cropping begins
 */
- (void)startTransformHook;

/**
 *  Called when cropping ends
 */
- (void)endTransformHook;

@end
