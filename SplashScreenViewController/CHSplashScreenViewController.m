    //
//  CHSplashScreenViewController.m
//  ChaiOneUI
//
//  Created by Michael Gile on 2/14/11.
//  Copyright 2011 ChaiOne Inc. All rights reserved.
//

#import "CHSplashScreenViewController.h"

NSString* const kCHSplashScreenDidBeginFadeNotification	= @"CHSplashScreenDidBeginFadeNotifiation";
NSString* const kCHSplashScreenDidEndFadeNotification	= @"CHSplashScreenDidEndFadeNotification";
NSTimeInterval const kCHSplashScreenFadeDuration		= 0.25f;


@interface CHSplashScreenViewController (Private)
- (void) loadDefaultImage;
- (void) finalizeTransition;
- (void) postBeginNotification;
- (void) postEndNotification;
- (void) playTransitionSound;
@end


#pragma mark -
@implementation CHSplashScreenViewController

@synthesize window				= _window;
@synthesize transitionView		= _transitionView;
@synthesize duration			= _duration;


#pragma mark -
#pragma mark init, dealloc

- (id) initWithTransitionView:(UIView*)view forWindow:(UIWindow*)window {
	if (self = [super init]) {
		_transitionView	= [view retain];
		_window			= [window retain];
	}
	
	return self;
}

- (void)dealloc {
	[_transitionView release];
	[_window release];
    [super dealloc];
}


#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	[self loadDefaultImage];
	
	_duration	= kCHSplashScreenFadeDuration;
}

- (void) viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self transition];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


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

#pragma mark -
#pragma mark Static Methods

+ (NSString*) splashScreenDidBeginFadeNotificationName {
	return [NSString stringWithString:kCHSplashScreenDidBeginFadeNotification];
}

+ (NSString*) splashScreenDidEndFadeNotificationName {
	return [NSString stringWithString:kCHSplashScreenDidEndFadeNotification];
}


#pragma mark -
#pragma mark Public Methods

- (void) transition {
	[UIView beginAnimations:@"CHSplashScreenViewControllerAnimation" context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:_duration];
	[UIView setAnimationWillStartSelector:@selector(postBeginNotification)];
	[UIView setAnimationDidStopSelector:@selector(finalizeTransition)];
	self.view.alpha		= 0.0f;
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark Private Methods

- (void) loadDefaultImage {
	if (!_window || !_transitionView) {
		return;
	}
	
	// TODO: Load appropriate Default image file
	// 1.) Determine platform (iPhone/iPad)
	// 2.) Determine orientation
	// 3.) Check info.plist to see if UILaunchImageFile keys are set
	// 4.) Choose appropriate default image file
	// 5.) Load image from bundle
	// 6.) Add UIImageView to view
	// 7.) Add view to window
	
	// Test code
	UIImageView*	defaultImgView	= [[UIImageView alloc] initWithFrame:[[self view] frame]];
	[defaultImgView setImage:[UIImage imageNamed:@"Default-Landscape.png"]];
	[[self view] addSubview:defaultImgView];
	[_window addSubview:[self view]];
}

- (void) finalizeTransition {
	[[self view] removeFromSuperview];
	[_window addSubview:_transitionView];
	[self playTransitionSound];
	[self postEndNotification];
}


- (void) postBeginNotification {
	[[NSNotificationCenter defaultCenter] postNotificationName:kCHSplashScreenDidBeginFadeNotification object:nil];
}


- (void) postEndNotification {
	[[NSNotificationCenter defaultCenter] postNotificationName:kCHSplashScreenDidEndFadeNotification object:nil];
}

- (void) playTransitionSound {
	// TODO: Play the configured sound
}

@end
