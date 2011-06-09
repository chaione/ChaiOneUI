    //
//  CHSegmentedControlSampleViewController.m
//  ChaiOneUISamples
//
//  Created by Ben Scheirman on 6/8/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "CHSegmentedControlSampleViewController.h"
#import "CHSegmentedControl.h"
#import "CHStretchableImageSegmentedControl.h"

#define VERTICAL_OFFSET 10.0
#define HORIZONTAL_OFFSET 10.0
#define VERTICAL_SPACING 5.0
#define VERTICAL_HEIGHT 70.0

typedef enum {
	CapLeft = 0,
	CapMiddle = 1,
	CapRight = 2,
	CapLeftAndRight = 3
} CapLocation;

@implementation CHSegmentedControlSampleViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

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

- (UIButton*) buttonFor:(CHSegmentedControl*)segmentedControl atIndex:(NSUInteger)segmentIndex;
{
	NSLog(@"Button for index: %d", segmentIndex);
	NSArray* titles = buttonTitles;
    
	CapLocation location;
	if (segmentIndex == 0)
		location = CapLeft;
	else if (segmentIndex == titles.count - 1)
		location = CapRight;
	else
		location = CapMiddle;
	
	UIImage* buttonImage = nil;
	UIImage* buttonPressedImage = nil;
	
	CGFloat capWidth = 10;
	CGSize buttonSize = CGSizeMake(100, 47);
	

    UIImage *blueBarImage = [[UIImage imageNamed:@"bottombarblue.png"] stretchableImageWithLeftCapWidth:capWidth
                                                                                           topCapHeight:0];
    UIImage *blueBarPressedImage = [[UIImage imageNamed:@"bottombarblue_pressed.png"] stretchableImageWithLeftCapWidth:capWidth
                                                                                                  topCapHeight:0];
    
	if (location == CapLeftAndRight) {
		buttonImage = blueBarImage;
		buttonPressedImage = blueBarPressedImage;
	} else {
		buttonImage = [self image:blueBarImage withCap:location capWidth:capWidth buttonWidth:buttonSize.width];
		buttonPressedImage = [self image:blueBarPressedImage withCap:location capWidth:capWidth buttonWidth:buttonSize.width];
	}
	
	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(0.0, 0.0, buttonSize.width, buttonSize.height);
	
	[button setTitle:[titles objectAtIndex:segmentIndex] forState:UIControlStateNormal];
	[button setBackgroundImage:buttonImage forState:UIControlStateNormal];
	[button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
	[button setBackgroundImage:buttonPressedImage forState:UIControlStateSelected];
	button.adjustsImageWhenHighlighted = NO;
	
	if (segmentIndex == 0)
		button.selected = YES;
	return button;
}

- (void)loadView {
	[super loadView];
	self.title = @"Custom Segmented Control";
	buttonTitles = [[NSArray arrayWithObjects:@"One", @"Two", @"Three", nil] retain];
	
	UIImage *blueDivider = [UIImage imageNamed:@"blue-divider.png"];
	
	CHSegmentedControl *segmentedControl = [[CHSegmentedControl alloc] initWithSegmentCount:buttonTitles.count
																				segmentSize:CGSizeMake(100, 47)
																				dividerImage:blueDivider
																						tag:1
																				   delegate:self];
	segmentedControl.center = self.view.center;
	[self.view addSubview:segmentedControl];

    
    CHStretchableImageSegmentedControl *svc = [[CHStretchableImageSegmentedControl alloc] initWithButtonTitles:buttonTitles
                                                                                            segmentSize:CGSizeMake(100, 47)
                                                                                           dividerImage:blueDivider
                                                                                        backgroundImage:[UIImage imageNamed:@"bottombarblue.png"]
                                                                                           pressedImage:[UIImage imageNamed:@"bottombarblue_pressed.png"]
                                                                                               capWidth:10
                                                                                                    tag:2
                                                                                               delegate:self];
    svc.center = CGPointMake(self.view.center.x, self.view.center.y - 200);
    [self.view addSubview:svc];

}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
