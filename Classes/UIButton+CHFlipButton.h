//
//  UIButton+CHFlipButton.h
//  ChaiOneUI
//
//  Created by Ben Scheirman on 10/3/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CHFlipButton)

+ (UIView *)flipButtonWithFirstImage:(UIImage *)firstImage 
                         secondImage:(UIImage *)secondImage
                     firstTransition:(UIViewAnimationTransition)firstTransition
                    secondTransition:(UIViewAnimationTransition)secondTransition
                      animationCurve:(UIViewAnimationCurve)curve
                            duration:(NSTimeInterval)duration
                              target:(id)target
                            selector:(SEL)selector;


@end
