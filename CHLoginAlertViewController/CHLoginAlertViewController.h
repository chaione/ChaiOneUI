/*
 *  CHLoginAlertViewController.h
 *  ChaiOneUI
 *
 *  Copyright (c) 2011 ChaiOne Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

#import <UIKit/UIKit.h>


@protocol CHLoginAlertViewControllerDelegate;

/*!
 @class CHLoginAlertViewController
 */
@interface CHLoginAlertViewController : NSObject <UIAlertViewDelegate, UITextFieldDelegate> {
@private
	
	id								_delegate;
	SEL								_comparisonSelector;
	
	UIAlertView*					_alertView;

	NSString*						_titleString;
	NSString*						_accountNameString;
	NSString*						_usernameString;

	UILabel*						_usernameLabel;
	
	UITextField*					_usernameTextField;
	UITextField*					_passwordTextField;
}

/*!
 @property delegate
 */
@property (nonatomic, assign) id<CHLoginAlertViewControllerDelegate> delegate;

/*!
 @property titleString
 */
@property (nonatomic, copy) NSString* titleString;

/*!
 @property accountNameString
 */
@property (nonatomic, copy) NSString* accountNameString;

/*!
 @property usernameString
 */
@property (nonatomic, copy) NSString* usernameString;


/*!
 @property comparisonSelector
 @discussion Must have the signature - (NSComparisonResult) compare:(NSString*)string;
 */
@property (nonatomic, assign) SEL comparisonSelector;

/*!
 @method show
 */
- (void) show;


/*!
 @method hide
 */
- (void) hide;

@end

/*!
 @protocol CHLoginAlertViewControllerDelegate
 */
@protocol CHLoginAlertViewControllerDelegate
@optional

/*!
 @method alertViewController:didReceiveValidPassword:
 */
- (void) alertViewController:(CHLoginAlertViewController*)alertViewController 
	 didReceiveValidPassword:(NSString*)password;


/*!
 @method alertViewController:didReceiveValidUsername:andPassword:
 */
- (void) alertViewController:(CHLoginAlertViewController*)alertViewController 
	 didReceiveValidUsername:(NSString*)username 
				 andPassword:(NSString*)password;

@end


