//
//  AlertViewTestAppViewController.h
//  AlertViewTestApp
//
//  Created by Michael Gile on 2/28/11.
//  Copyright 2011 ChaiOne Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHLoginAlertViewController.h"


@interface AlertViewTestAppViewController : UIViewController<CHLoginAlertViewControllerDelegate, UITextFieldDelegate> {
	CHLoginAlertViewController*	loginView;
	UIButton*					loginButton;
	UITextField*				usernameTextField;
}

@property (nonatomic, retain) IBOutlet UIButton* loginButton;
@property (nonatomic, retain) IBOutlet UITextField* usernameTextField;

- (IBAction) showLoginAlertView:(id)sender;

@end

