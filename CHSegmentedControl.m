//
//  CHSegmentedControl.m
//  ChaiOneUI
//
//  Created by Ben Scheirman on 6/8/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "CHSegmentedControl.h"

@interface CHSegmentedControl ()
- (void)calculateFrame;
- (void)setupButtons;
@end

@implementation CHSegmentedControl

@synthesize delegate;

//- (id)initWithFrame:(CGRect)frame {
//    [NSException raise:@"Invalid initializer" format:@"The correct initializer is initWithSegmentCount:segmentSize:dividerImage:tag:delegate"];
//    return nil;
//}

- (id)initWithSegmentCount:(NSInteger)count
               segmentSize:(CGSize)segmentSize 
              dividerImage:(UIImage *)dividerImage 
                       tag:(NSInteger)tag
                  delegate:(id<CHSegmentedControlDelegate>)theDelegate {
    self = [super init];
    if (self) {
        self.tag = tag;
        self.delegate = theDelegate;
        
        _segmentCount = count;
        _segmentSize = segmentSize;
        _dividerImage = [dividerImage retain];
        
        [self calculateFrame];
        [self setupButtons];
    }
    return self;
}

- (void) calculateFrame {
    //calculate the frame size based on the size of the segments & the divider images
    int width = _segmentSize.width * _segmentCount + _dividerImage.size.width * (_segmentCount - 1);
    self.frame = CGRectMake(0, 0, width, _segmentSize.height);
}

- (void)setupButtons {
    _buttons = [[NSMutableArray alloc] initWithCapacity:_segmentCount];
    CGFloat horizontalOffset = 0;
    for (int i=0; i<_segmentCount; i++) {
        UIButton *button = [self.delegate buttonFor:self atIndex:i];
        
        //register for touch events
        [button addTarget:self action:@selector(touchDownAction:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(otherTouchesAction:) forControlEvents:UIControlEventTouchUpOutside];
        [button addTarget:self action:@selector(otherTouchesAction:) forControlEvents:UIControlEventTouchDragOutside];
        [button addTarget:self action:@selector(otherTouchesAction:) forControlEvents:UIControlEventTouchDragInside];
        
        //position the button
        button.frame = CGRectMake(horizontalOffset, 0, _segmentSize.width, _segmentSize.height);
        horizontalOffset += _segmentSize.width;
        
        //add the divider
        BOOL onLastSegment = i == _segmentCount -1;
        if  (!onLastSegment) {
            UIImageView *divider = [[[UIImageView alloc] initWithImage:_dividerImage] autorelease];
            divider.frame = CGRectMake(horizontalOffset, 0, _dividerImage.size.width, _dividerImage.size.height);
            [self addSubview:divider];
            horizontalOffset += _dividerImage.size.width;
        }
        
        [self addSubview:button];
        [_buttons addObject:button];
    }
}

- (void)dimAllButtonsExcept:(UIButton *)selectedButton {
    for (UIButton* button in _buttons) {
        if (button == selectedButton) {
            button.selected = YES;
            button.highlighted = button.selected ? NO : YES;
        } else {
            button.selected = NO;
            button.highlighted = NO;
        }
    }
}

- (void)touchDownAction:(UIButton *)button {
    [self dimAllButtonsExcept:button];
    
    if ([delegate respondsToSelector:@selector(touchDownAtSegmentIndex:)])
        [delegate touchDownAtSegmentIndex:[_buttons indexOfObject:button]];
}

- (void)touchUpInsideAction:(UIButton *)button {
    [self dimAllButtonsExcept:button];
    
    if ([delegate respondsToSelector:@selector(touchUpInsideSegmentIndex:)])
        [delegate touchUpInsideSegmentIndex:[_buttons indexOfObject:button]];
}

- (void)otherTouchesAction:(UIButton *)button {
    [self dimAllButtonsExcept:button];
}

- (void)dealloc {
    self.delegate = nil;
    [_buttons release];
    [_dividerImage release];
    [super dealloc];
}

@end
