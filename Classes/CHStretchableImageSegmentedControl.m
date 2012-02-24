//
//  CHStretchableImageSegmentedControl.m
//  ChaiOneUI
//
//  Created by Ben Scheirman on 6/9/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "CHStretchableImageSegmentedControl.h"

typedef enum {
	CapLeft = 0,
	CapMiddle = 1,
	CapRight = 2,
	CapLeftAndRight = 3
} CapLocation;

@implementation CHStretchableImageSegmentedControl

- (id)initWithButtonTitles:(NSArray *)buttonTitles 
               segmentSize:(CGSize)size 
              dividerImage:(UIImage *)dividerImage 
           backgroundImage:(UIImage *)backgroundImage
              pressedImage:(UIImage *)pressedImage
                  capWidth:(CGFloat)capWidth
                       tag:(NSInteger)tag 
                  delegate:(id<CHSegmentedControlDelegate>)delegate {
    _buttonTitles               = [buttonTitles retain];
    _stretchableImage           = [[backgroundImage stretchableImageWithLeftCapWidth:capWidth topCapHeight:0] retain];
    _stretchablePressedImage    = [[pressedImage    stretchableImageWithLeftCapWidth:capWidth topCapHeight:0] retain];
    _capWidth                   = capWidth;
    return [super initWithSegmentCount:buttonTitles.count segmentSize:size dividerImage:dividerImage tag:tag delegate:delegate];
}

-(UIImage*)image:(UIImage*)image withCap:(CapLocation)location capWidth:(NSUInteger)capWidth buttonWidth:(NSUInteger)buttonWidth
{
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(buttonWidth, image.size.height), NO, 0.0);
	
	if (location == CapLeft)
		// To draw the left cap and not the right, we start at 0, and increase the width of the image by the cap width to push the right cap out of view
		[image drawInRect:CGRectMake(0, 0, buttonWidth + capWidth, image.size.height)];
	else if (location == CapRight)
		// To draw the right cap and not the left, we start at negative the cap width and increase the width of the image by the cap width to push the left cap out of view
		[image drawInRect:CGRectMake(0.0-capWidth, 0, buttonWidth + capWidth, image.size.height)];
	else if (location == CapMiddle)
		// To draw neither cap, we start at negative the cap width and increase the width of the image by both cap widths to push out both caps out of view
		[image drawInRect:CGRectMake(0.0-capWidth, 0, buttonWidth + (capWidth * 2), image.size.height)];
	
	UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return resultImage;
}

- (void)customizeButton:(UIButton *)button atIndex:(NSUInteger)segmentIndex {
	NSArray* titles = _buttonTitles;
    
	CapLocation location;
	if (segmentIndex == 0)
		location = CapLeft;
	else if (segmentIndex == titles.count - 1)
		location = CapRight;
	else
		location = CapMiddle;
	
    UIImage *buttonImage, *buttonPressedImage = nil;
    
	if (location == CapLeftAndRight) {
		buttonImage = _stretchableImage;
		buttonPressedImage = _stretchablePressedImage;
	} else {
		buttonImage = [self image:_stretchableImage withCap:location capWidth:_capWidth buttonWidth:_segmentSize.width];
		buttonPressedImage = [self image:_stretchablePressedImage withCap:location capWidth:_capWidth buttonWidth:_segmentSize.width];
	}
	
    [button setTitle:[titles objectAtIndex:segmentIndex] forState:UIControlStateNormal];
	[button setBackgroundImage:buttonImage forState:UIControlStateNormal];
	[button setBackgroundImage:buttonPressedImage forState:UIControlStateSelected];
}

- (void)dealloc {
    [_buttonTitles release];
    [_stretchableImage release];
    [_stretchablePressedImage release];
    [super dealloc];
}

@end
