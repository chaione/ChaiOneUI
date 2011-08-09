/*
 *  CHLoginAlertViewController.m
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

#import "CHLoginAlertViewController.h"
#import "CHLogging.h"
#import "NSObject-Dispatch.h"

#import <QuartzCore/QuartzCore.h>

@interface CHLoginAlertViewController(Private)
- (void) layoutUsername;
- (void) layoutPassword;
- (void) triggerFirstResponder;
- (void) shake;
- (void) show:(BOOL)shake;
@end

#pragma mark -
@implementation CHLoginAlertViewController

@synthesize comparisonSelector		= _comparisonSelector;
@synthesize delegate				= _delegate;
@synthesize titleString				= _titleString;
@synthesize usernameString			= _usernameString;
@synthesize accountNameString		= _accountNameString;


#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
	[_alertView release];
	[_titleString release];
	[_accountNameString release];
	[_usernameString release];
	[_usernameLabel release];
	[_usernameTextField release];
	[_passwordTextField release];
    [super dealloc];
}


#pragma mark -
#pragma mark Public Methods

- (void) show {
	[self show:NO];	
}

- (void) hide {
	[_alertView dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark -
#pragma mark Private Methods

- (void) layoutUsername {
	
	if (!_usernameString) {
		// Put up a UITextField instead
		if (!_usernameTextField) {
			_usernameTextField		= [[UITextField alloc] initWithFrame:CGRectMake(12.0f, 50.0f, 260.0f, 25.0f)];
			[_usernameTextField setDelegate:self];
			[_usernameTextField setPlaceholder:NSLocalizedString(@"Username", @"Username")];
			[_usernameTextField setSecureTextEntry:NO];
			[_usernameTextField setBackgroundColor:[UIColor clearColor]];
			[_usernameTextField setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
			[_usernameTextField setKeyboardType:UIKeyboardTypeEmailAddress];
			[_usernameTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
			[_usernameTextField setKeyboardAppearance:UIKeyboardAppearanceAlert];
			[_usernameTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
			[_usernameTextField setBorderStyle:UITextBorderStyleRoundedRect];
		}
		
		[_alertView addSubview:_usernameTextField];
	}
	else {
		// Show the username field as a UILabel
		if (!_usernameLabel) {
			_usernameLabel			= [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 48.0f, 260.0f, 25.0f)];
			[_usernameLabel setFont:[UIFont systemFontOfSize:14.0f]];
			[_usernameLabel setTextColor:[UIColor whiteColor]];
			[_usernameLabel setTextAlignment:UITextAlignmentCenter];
			[_usernameLabel setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
		}
		
		[_usernameLabel setText:_usernameString];
		[_usernameTextField release];
		_usernameTextField = nil;
		[_alertView addSubview:_usernameLabel];
	}
}

- (void) layoutPassword {
	if (!_passwordTextField) {
		_passwordTextField	= [[UITextField alloc] initWithFrame:CGRectMake(12.0f, 77.0f, 260.0f, 25.0f)];
		[_passwordTextField setDelegate:self];
		[_passwordTextField setPlaceholder:NSLocalizedString(@"Password", @"Password")];
		[_passwordTextField setSecureTextEntry:YES];
		[_passwordTextField setBackgroundColor:[UIColor clearColor]];
		[_passwordTextField setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
		[_passwordTextField setKeyboardType:UIKeyboardTypeEmailAddress];
		[_passwordTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
		[_passwordTextField setKeyboardAppearance:UIKeyboardAppearanceAlert];
		[_passwordTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
		[_passwordTextField setBorderStyle:UITextBorderStyleRoundedRect];
	}
	
	[_alertView addSubview:_passwordTextField];
}
	 

- (void) triggerFirstResponder {

	if (_usernameTextField) {
		[_usernameTextField becomeFirstResponder];
	}
	else {
		[_passwordTextField becomeFirstResponder];
	}
}

- (void) shake {
	CABasicAnimation* shakeAnimation	= [[CABasicAnimation alloc] init];
	[shakeAnimation setDelegate:self];
	[shakeAnimation setDuration:0.3f];
	[shakeAnimation setSpeed:5.0f];
	[shakeAnimation setKeyPath:@"position.x"];
	[shakeAnimation setRemovedOnCompletion:YES];
	[shakeAnimation setRepeatCount:5.0f];
	[shakeAnimation setAutoreverses:YES];
	[shakeAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
	
	CGPoint alertPosition	= [[_alertView layer] position];	
	alertPosition.x			+= 10.0f;
	NSValue* fromValue		= [NSValue valueWithCGPoint:CGPointMake(alertPosition.x - 20.0f, alertPosition.y)];
	NSValue* toValue		= [NSValue valueWithCGPoint:CGPointMake(alertPosition.x + 15.0f, alertPosition.y)];
	
	[shakeAnimation setFromValue:fromValue];
	[shakeAnimation setToValue:toValue];
	
	[_alertView.layer addAnimation:shakeAnimation forKey:@"ShakeAnimation"];
	[shakeAnimation release];
}

- (void) show:(BOOL)shake {
	
	[_alertView release];
	
	_alertView	= [[UIAlertView alloc] initWithTitle:_titleString 
											message:@"\n\n\n" 
										   delegate:self 
								  cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel") 
								  otherButtonTitles:NSLocalizedString(@"Login", @"Login"), nil];
	
	[self layoutUsername];
	[self layoutPassword];
	[_alertView show];
	[self triggerFirstResponder];
	
	if (shake) {
		[self shake];
	}
}

#pragma mark -
#pragma mark CAAnimation Delegate Methods

- (void) animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
	[_passwordTextField setText:nil];
}

#pragma mark -
#pragma mark UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	;
}

- (void)alertViewCancel:(UIAlertView *)alertView {
	;
}

- (void)willPresentAlertView:(UIAlertView *)alertView {
	;
}


- (void)didPresentAlertView:(UIAlertView *)alertView {
	;
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
	;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
		// Cancel
	}
	else {
		if (_delegate && [_delegate respondsToSelector:_comparisonSelector]) {
			if ([_delegate performSelector:_comparisonSelector withObject:[_passwordTextField text]] == NSOrderedSame) {
				[self dispatchSelector:@selector(alertViewController:didReceiveValidPassword:) 
								target:_delegate 
							   objects:[NSArray arrayWithObject:[_passwordTextField text]] 
						  onMainThread:YES];
			}
			else {
				[self show:YES];
			}
		}
	}
}

#pragma mark -
#pragma mark UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	if ([textField isEqual:_usernameTextField]) {
		[_usernameTextField resignFirstResponder];
	}
	else if([textField isEqual:_passwordTextField]) {
		[_passwordTextField resignFirstResponder];
	}
	
	[_alertView dismissWithClickedButtonIndex:1 animated:YES];
	
	return YES;	
}

@end
