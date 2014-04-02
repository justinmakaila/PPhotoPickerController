//
//  PhotoEditorViewController.h
//  Present
//
//  Created by Xiaonan Wang on 10/6/13.
//  Copyright (c) 2013 Present, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPhotoCropViewController.h"

@interface PEditPhotoViewController : PPhotoCropViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *selectButton;

@end
