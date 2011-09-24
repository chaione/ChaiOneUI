//
//  CHBarButtonItem.m
//  ChaiOneUI
//
//  Created by Longyi Qi on 9/24/11.
//  Copyright 2011 Longyi Qi. All rights reserved.
//

#import "CHBarButtonItem.h"

@interface CHBarButtonItem()

@property (nonatomic, retain) id chBarButtonItemTarget;
@property (nonatomic) SEL chBarButtonItemSelector;

@end

@implementation CHBarButtonItem

@synthesize chBarButtonItemTarget, chBarButtonItemSelector = _chBarButtonItemSelector;

- (id)initWithTitle:(NSString *)title tintColor:(UIColor *)color target:(id)target action:(SEL)action {
    if ([super respondsToSelector:@selector(setTintColor:)]) {
        self = [super initWithTitle:title style:UIBarButtonItemStyleBordered target:target action:action];
        [self performSelector:@selector(setTintColor:) withObject:color];
    }
    else {
        UISegmentedControl *button = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:title, nil]];
        button.momentary = YES;
        button.segmentedControlStyle = UISegmentedControlStyleBar;
        button.tintColor = color;
        self.chBarButtonItemTarget = target;
        self.chBarButtonItemSelector = action;
        [button addTarget:self action:@selector(chBarButtonItemAction) forControlEvents:UIControlEventValueChanged];
        self = [super initWithCustomView:button];
        [button release];
    }
    return self;
}

- (void)chBarButtonItemAction {
    if (self.enabled) {
        [self.chBarButtonItemTarget performSelector:_chBarButtonItemSelector];
    }
}

@end
