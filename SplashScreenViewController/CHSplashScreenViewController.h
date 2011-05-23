//
//  CHSplashScreenViewController.h
//  ChaiOneUI
//
//  Created by Michael Gile on 2/14/11.
//  Copyright 2011 ChaiOne Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


extern NSString* const kCHSplashScreenDidBeginFadeNotification;
extern NSString* const kCHSplashScreenDidEndFadeNotification;
extern NSTimeInterval const kCHSplashScreenFadeDuration;


/*!
 @class CHSplashScreenViewController
 @discussion
 @updated 14-Feb-2011
 */
@interface CHSplashScreenViewController : UIViewController {
	
@private
	UIWindow*				_window;
	UIView*					_transitionView;
	NSTimeInterval			_duration;
    UIImage*                _defaultImage;
    BOOL                    _showsStatusBarOnDismissal;
}

@property (nonatomic, retain) UIWindow* window;
@property (nonatomic, retain) UIView* transitionView;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, retain) UIImage *defaultImage;
@property (nonatomic) BOOL showsStatusBarOnDismissal;

/*!
 @method initWithTransitionView:forWindow
 @param view
 @param window
 @result
 @discussion
 @updated 14-Feb-2011
 */
- (id) initWithTransitionView:(UIView*)view forWindow:(UIWindow*)window;

/*!
 @method splashScreenDidBeginFadeNotificationName
 @result
 @discussion
 @updated 14-Feb-2011
 */
+ (NSString*) splashScreenDidBeginFadeNotificationName;


/*!
 @method splashScreenDidEndFadeNotificationName
 @result
 @discussion
 @updated 14-Feb-2011
 */
+ (NSString*) splashScreenDidEndFadeNotificationName;


/*!
 @method transition
 @discussion
 @updated 14-Feb-2011
 */
- (void) transition;

@end
