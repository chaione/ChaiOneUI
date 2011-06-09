//
//  CHStretchableImageSegmentedControl.h
//  ChaiOneUI
//
//  Created by Ben Scheirman on 6/9/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHSegmentedControl.h"

@interface CHStretchableImageSegmentedControl : CHSegmentedControl <CHSegmentedControlDelegate> {
    NSArray *_buttonTitles;
    UIImage *_stretchableImage;
    UIImage *_stretchablePressedImage;
    CGFloat _capWidth;
    id<CHSegmentedControlDelegate> _extendedDelegate;
}

- (id)initWithButtonTitles:(NSArray *)buttonTitles 
               segmentSize:(CGSize)size 
              dividerImage:(UIImage *)dividerImage 
           backgroundImage:(UIImage *)backgroundImage
              pressedImage:(UIImage *)pressedImage
                  capWidth:(CGFloat)capWidth
                       tag:(NSInteger)tag 
                  delegate:(id<CHSegmentedControlDelegate>)delegate;

@end
