//
//  PPhotoManager.h
//  Present
//
//  Created by Justin Makaila on 3/30/14.
//  Copyright (c) 2014 Present, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol PPhotoManagerDelegate;

@interface PPhotoManager : NSObject

@property (weak, nonatomic) id<PPhotoManagerDelegate> delegate;

- (id)initWithViewController:(UIViewController*)viewController delegate:(id<PPhotoManagerDelegate>)delegate;

- (void)showActionSheet;
- (void)showActionSheetInView:(UIView*)view;

@end

@protocol PPhotoManagerDelegate <NSObject>

- (void)photoManager:(PPhotoManager*)manager didSelectImage:(UIImage*)image;

@optional
- (void)photoManagerDidCancel:(PPhotoManager*)manager;

@end
