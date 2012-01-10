//
//  ColorPickerViewController.m
//  ChaiOneUISamples
//
//  Created by Ben Scheirman on 1/10/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import "ColorPickerViewController.h"
#import "CHModalPickerView.h"

@implementation ColorPickerViewController

@synthesize colors;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colors = [NSDictionary dictionaryWithObjectsAndKeys:
                   [UIColor whiteColor], @"White",
                   [UIColor greenColor], @"Green",
                   [UIColor redColor],   @"Red",
                   [UIColor blackColor], @"Black",
                   [UIColor orangeColor],@"Orange",
                   [UIColor yellowColor],@"Yellow",
                   [UIColor purpleColor],@"Purple", nil];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)colorChangeTapped:(id)sender {
    CHModalPickerView *pickerView = [[[CHModalPickerView alloc] initWithValues:[self.colors allKeys]] autorelease];
    
    if (_lastKey) {
        [pickerView setSelectedValue:_lastKey];
    }

    [pickerView presentWithBlock:^(BOOL madeChoice) {
        if (madeChoice) {
            NSString *colorKey = [pickerView selectedValue];
            _lastKey = [colorKey retain];
            UIColor *color = [self.colors objectForKey:colorKey];
            self.view.backgroundColor = color;
        } 
    }];
}
@end
