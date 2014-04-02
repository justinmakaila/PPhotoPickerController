//
//  PhotoEditorViewController.m
//  Present
//
//  Created by Xiaonan Wang on 10/6/13.
//  Copyright (c) 2013 Present, Inc. All rights reserved.
//

#import "PEditPhotoViewController.h"

@interface PEditPhotoViewController ()

@end

@implementation PEditPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.minimumScale = 0.2;
        self.maximumScale = 10;
    }
    return self;
}

// waiting start
- (void)startTransformHook {
    [super startTransformHook];
    [_selectButton setEnabled:NO];
    [_cancelButton setEnabled:NO];
}

// waiting end
- (void)endTransformHook {
    [super endTransformHook];
    [_selectButton setEnabled:YES];
    [_cancelButton setEnabled:YES];
}
@end
