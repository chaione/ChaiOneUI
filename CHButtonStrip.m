//
//  CHButtonStrip.m
//  ChaiOneUI
//
//  Created by Ben Scheirman on 9/26/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "CHButtonStrip.h"
#import <QuartzCore/QuartzCore.h>

@interface CHButtonStrip ()
@property (nonatomic, assign) NSInteger buttonCount;
@property (nonatomic, retain) NSMutableArray *buttons;
@end

@implementation CHButtonStrip

@synthesize gapWidth, delegate, selectedIndex;
@synthesize buttons, buttonCount;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.gapWidth = 4;
        self.selectedIndex = 0;
    }
    
    return self;
}

- (id)initWithButtonCount:(NSInteger)buttonCount_ delegate:(id<CHButtonStripDelegate>)delegate_ {
    self = [super init];
    if (self) {
        self.gapWidth = 4;
        self.delegate = delegate_;
        self.buttonCount = buttonCount_;
    }
    
    return self;
}

- (UIButton *)buttonAtIndex:(NSInteger)index {
    return [self.buttons objectAtIndex:index];
}

- (UIButton *)generateButtonForIndex:(NSInteger)index {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (index == self.selectedIndex) {
        button.selected = YES;
    }
    
    if ([self.delegate respondsToSelector:@selector(buttonStrip:customizeButton:atIndex:)]) {
        [self.delegate buttonStrip:self customizeButton:button atIndex:index];
    }
        
    [button addTarget:self action:@selector(onTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
    
    return button;
}

- (void)setupButtons {
    self.buttons = [NSMutableArray arrayWithCapacity:self.buttonCount];
    
    CGFloat x = 0;
    for (int i=0; i < self.buttonCount; i++) {
        UIButton *btn = [self generateButtonForIndex:i];
        CGFloat width = [[btn titleForState:UIControlStateNormal] sizeWithFont:btn.titleLabel.font].width + 20;
        btn.frame = CGRectMake(x, 0, width, self.frame.size.height);
                
        [self.buttons addObject:btn];
        [self addSubview:btn];
        x += self.gapWidth + btn.frame.size.width;
    }
}

- (void)dimAllButtonsExceptIndex:(NSInteger)newIndex {
    [self.buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger index, BOOL *stop) {
        BOOL selected = index == newIndex;
        BOOL changed = button.selected != selected;
        
        [button setSelected:selected];
        
        if (changed && [self.delegate respondsToSelector:@selector(buttonStrip:buttonStateDidChange:)]) {
            [self.delegate buttonStrip:self buttonStateDidChange:button];
        }
    }];
}

- (void)onTouchUpInside:(id)sender {
    NSInteger index = [self.buttons indexOfObject:sender];
    [self dimAllButtonsExceptIndex:index];
    if ([self.delegate respondsToSelector:@selector(buttonStrip:didSelectButtonAtIndex:)]) {
        [self.delegate buttonStrip:self didSelectButtonAtIndex:index];
    }
}

- (void)onTouchDown:(id)sender {
    NSInteger index = [self.buttons indexOfObject:sender];
    if ([self.delegate respondsToSelector:@selector(buttonStrip:momentaryPressAtIndex:)]) {
        [self.delegate buttonStrip:self momentaryPressAtIndex:index];
    }
}

- (void)layoutSubviews {
    if (!self.buttons) {
        [self setupButtons];
    }

    [super layoutSubviews];    
}

@end
