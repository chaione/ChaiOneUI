//
//  UIButton+CHFlipButton.m
//  ChaiOneUI
//
//  Created by Ben Scheirman on 10/3/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <objc/runtime.h>

#import "UIButton+CHFlipButton.h"

static char UIButtonFlipBlockKey;
static char UIButtonFlipAltButtonKey;
static char UIButtonFlipTransitionKey;
static char UIButtonFlipContainerViewKey;



@implementation UIButton (CHFlipButton)

- (void)chFlipButton_handleControlEvent:(UIControlEvents)event withBlock:(UIButtonFlipActionBlock)block {
    objc_setAssociatedObject(self, &UIButtonFlipBlockKey, block, OBJC_ASSOCIATION_COPY);
    [self addTarget:self action:@selector(chFlipButton_callFlipBlock:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)chFlipButton_callFlipBlock:(id)sender {
    UIButtonFlipActionBlock block = objc_getAssociatedObject(self, &UIButtonFlipBlockKey);
    if (block) {
        block(sender);
    }
}

+ (UIView *)flipButtonWithFirstImage:(UIImage *)firstImage 
                         secondImage:(UIImage *)secondImage
                     firstTransition:(UIViewAnimationTransition)firstTransition
                    secondTransition:(UIViewAnimationTransition)secondTransition
                      animationCurve:(UIViewAnimationCurve)curve
                            duration:(NSTimeInterval)duration
                              target:(id)target
                            selector:(SEL)selector {
    
    UIButtonFlipActionBlock flipButtonAction = ^(id sender) {

        //get the alternate button & container
        UIButton *otherButton = (UIButton *)objc_getAssociatedObject(sender, &UIButtonFlipAltButtonKey);
        UIView *container = (UIView *)objc_getAssociatedObject(sender, &UIButtonFlipContainerViewKey);
        
        //figure out our transition
        NSNumber *transitionNumber = (NSNumber *)objc_getAssociatedObject(sender, &UIButtonFlipTransitionKey);
        UIViewAnimationTransition transition = (UIViewAnimationTransition)[transitionNumber intValue];
                
        [UIView animateWithDuration:duration animations:^ {
            
            [UIView setAnimationTransition:transition forView:container cache:YES];
            [UIView setAnimationCurve:curve];
            
            //the view has the last retain count on the sender button, so we need to retain it first
            objc_setAssociatedObject(otherButton, &UIButtonFlipAltButtonKey, sender, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            [sender removeFromSuperview];
            [container addSubview:otherButton];
            
            //sender no longer needs to retain the other button, because the view now is...
            objc_setAssociatedObject(sender, &UIButtonFlipAltButtonKey, otherButton, OBJC_ASSOCIATION_ASSIGN);
            
        }];
        
        //call the original button handler
        [target performSelector:selector withObject:self];
    };
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setBackgroundImage:firstImage forState:UIControlStateNormal];
    [button1 chFlipButton_handleControlEvent:UIControlEventTouchUpInside withBlock:flipButtonAction];
    [button1 setFrame:CGRectMake(0, 0, firstImage.size.width, firstImage.size.height)];

    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setBackgroundImage:secondImage forState:UIControlStateNormal];
    [button2 chFlipButton_handleControlEvent:UIControlEventTouchUpInside withBlock:flipButtonAction];
    [button2 setFrame:CGRectMake(0, 0, secondImage.size.width, secondImage.size.height)];    

    UIView *container = [[[UIView alloc] initWithFrame:button1.bounds] autorelease];
    [container addSubview:button1];
    
    //record state so the flip action works properly
    objc_setAssociatedObject(button1, &UIButtonFlipAltButtonKey, button2, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(button1, &UIButtonFlipTransitionKey, [NSNumber numberWithInt:firstTransition], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(button1, &UIButtonFlipContainerViewKey, container, OBJC_ASSOCIATION_ASSIGN);
    
    objc_setAssociatedObject(button2, &UIButtonFlipAltButtonKey, button1, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(button2, &UIButtonFlipTransitionKey, [NSNumber numberWithInt:secondTransition], OBJC_ASSOCIATION_ASSIGN);  //button1 is in charge of the retains initially
    objc_setAssociatedObject(button2, &UIButtonFlipContainerViewKey, container, OBJC_ASSOCIATION_ASSIGN);
    
    return container;
}

@end
