//
//  XWCropWindow.m
//  XWEditPhotoDemo
//
//  Created by Xiaonan Wang on 10/5/13.
//  Copyright (c) 2013 Xiaonan Wang. All rights reserved.
//

#import "PCropWindow.h"

@interface PCropWindow()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation PCropWindow

- (void)initialize {
    self.opaque = NO;
    self.layer.opacity = 0.7;
    self.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self addSubview:imageView];
    self.imageView = imageView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

// this is important
- (id)initWithCoder:(NSCoder*)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            [self setFrame:CGRectMake(0, 0, 320, 524)];
        } else {
            [self setFrame:CGRectMake(0, 0, 320, 436)];
        }
        
        [self initialize];
    }
    return self;
}

- (void)setCropRect:(CGRect)cropRect {
    if (!CGRectEqualToRect(_cropRect, cropRect)) {
        _cropRect = cropRect;
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.f);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        [[UIColor whiteColor] setFill];
        UIRectFill(self.bounds);
        
        CGColorRef strokeColor = [[UIColor purpleColor] colorWithAlphaComponent:0.5].CGColor;
        CGContextSetStrokeColorWithColor(context, strokeColor);
        CGContextStrokeRect(context, _cropRect);
        
        [[UIColor clearColor] setFill];
        UIRectFill(CGRectInset(_cropRect, 1, 1));
        
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }
}

@end
