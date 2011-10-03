//
//  UIButton+CHFlipButton.h
//  ChaiOneUI
//
//  Created by Ben Scheirman on 10/3/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIButtonFlipActionBlock)(id sender);

@interface UIButton (CHFlipButton)

- (void)chFlipButton_handleControlEvent:(UIControlEvents)event withBlock:(UIButtonFlipActionBlock)block;
- (void)chFlipButton_callFlipBlock:(id)sender;
+ (UIView *)flipButtonWithFirstImage:(UIImage *)firstImage 
                         secondImage:(UIImage *)secondImage
                     firstTransition:(UIViewAnimationTransition)firstTransition
                    secondTransition:(UIViewAnimationTransition)secondTransition
                      animationCurve:(UIViewAnimationCurve)curve
                            duration:(NSTimeInterval)duration
                              target:(id)target
                            selector:(SEL)selector;


@end
