//
//  AlertViewTestAppViewController.m
//  AlertViewTestApp
//
//  Created by Michael Gile on 2/28/11.
//  Copyright 2011 ChaiOne Inc. All rights reserved.
//

#import "AlertViewTestAppViewController.h"

@interface AlertViewTestAppViewController(Private)
- (NSComparisonResult) comparePassword:(NSString*)password;
@end

@implementation AlertViewTestAppViewController

@synthesize loginButton;
@synthesize usernameTextField;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (void) viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[loginView release];
	[loginButton release];
	[usernameTextField release];
    [super dealloc];
}

- (IBAction) showLoginAlertView:(id)sender {
	
	[usernameTextField resignFirstResponder];
	
	[loginView release];
	loginView	= [[CHLoginAlertViewController alloc] init];
	
	[loginView setDelegate:self];
	[loginView setComparisonSelector:@selector(comparePassword:)];
	[loginView setTitleString:NSLocalizedString(@"Website Login", @"Website Login")];
	
	NSString* usernameString = nil;
	if ([usernameTextField text] && ![[usernameTextField text] isEqualToString:@""]) {
		usernameString = [usernameTextField text];
	}
	[loginView setUsernameString:usernameString];
	[loginView show];
}


- (NSComparisonResult) comparePassword:(NSString*)password {
	return [@"1234" compare:password];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[usernameTextField resignFirstResponder];
	return YES;	
}

@end
