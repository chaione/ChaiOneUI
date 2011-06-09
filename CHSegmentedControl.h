//
//  CHSegmentedControl.h
//  ChaiOneUI
//
//  Adapted from https://github.com/boctor/idev-recipes/tree/master/CustomSegmentedControls
//
//  Created by Ben Scheirman on 6/8/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CHSegmentedControlDelegate;

@interface CHSegmentedControl : UIView {
    NSMutableArray* _buttons;
    NSInteger _segmentCount;
    CGSize _segmentSize;
    UIImage *_dividerImage;
}

@property (nonatomic, assign) id<CHSegmentedControlDelegate> delegate;

- (id)initWithSegmentCount:(NSInteger)count
               segmentSize:(CGSize)size 
              dividerImage:(UIImage *)dividerImage 
                       tag:(NSInteger)tag
                  delegate:(id<CHSegmentedControlDelegate>)delegate;

@end


@protocol CHSegmentedControlDelegate <NSObject>


@optional

- (UIButton *)buttonFor:(CHSegmentedControl* )segmentedControl atIndex:(NSUInteger)segmentIndex;
- (void)touchUpInsideSegmentIndex:(NSUInteger)segmentIndex;
- (void)touchDownAtSegmentIndex:(NSUInteger)segmentIndex;

@end