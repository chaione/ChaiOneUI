//
//  CHButtonStrip.h
//  ChaiOneUI
//
//  Created by Ben Scheirman on 9/26/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CHButtonStripDelegate;

@interface CHButtonStrip : UIView

@property (nonatomic, assign) NSInteger selectedIndex; 
@property (nonatomic, assign) CGFloat gapWidth;

// if this is set to YES, the gapWidth is calculated to make
// the buttons spread evenly across the strip's frame
@property (nonatomic, assign) BOOL justifyButtons;

@property (nonatomic, assign) IBOutlet id<CHButtonStripDelegate> delegate; 

- (id)initWithButtonCount:(NSInteger)buttonCount delegate:(id<CHButtonStripDelegate>)delegate;

// returns the button at the specified index.
- (UIButton *)buttonAtIndex:(NSInteger)index;

@end

@protocol CHButtonStripDelegate <NSObject>

@optional

// used to allow implementers to provide custom UI to the generated buttons
- (void)buttonStrip:(CHButtonStrip *)buttonStrip customizeButton:(UIButton *)button atIndex:(NSInteger)buttonIndex;

// called with the button is selected
- (void)buttonStrip:(CHButtonStrip *)buttonStrip didSelectButtonAtIndex:(NSInteger)buttonIndex;

// called when the user first presses down on the button (useful for sounds, etc)
- (void)buttonStrip:(CHButtonStrip *)buttonStrip momentaryPressAtIndex:(NSInteger)buttonIndex;

// called whenever the selected state has changed for a button
- (void)buttonStrip:(CHButtonStrip *)buttonStrip buttonStateDidChange:(UIButton *)button;

@end
