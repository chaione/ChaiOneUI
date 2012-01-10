//
//  CHModalPickerView.h
//  ChaiOneUI
//
//  Created by Ben Scheirman on 1/10/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>

/* CHModalPickerView
 
 Display a quick selection picker view with a darkened backdrop and a toolbar for Done & Cancel buttons.
 
 */

typedef void (^CHModalPickerCallBack)(BOOL madeChoice); 

@interface CHModalPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource> {
    UIPickerView *_picker;
    UIToolbar *_toolbar;
    UIView *_panel;
    CHModalPickerCallBack _callback;
}

// Returns the selected index of the picker.  Assign a value here to pre-select that row in the picker when presenting. 
@property (nonatomic, assign) NSInteger selectedIndex;

// Returns the selected value of the picker.  Assign a value here to pre-select that row in the picker when presenting. 
@property (nonatomic, assign) NSString *selectedValue;

// Returns the list of values for the picker.  Assign a new array to re-bind the picker with new values.  Selected index will be reset to 0.
@property (nonatomic, retain) NSArray *values;

/* Initializes a new instance of the picker with the values to present to the user.
    (Note: call presentInView:withBlock: or presentWithBlock: to display the control)
 */
- (id)initWithValues:(NSArray *)values;

/* Presents the control embedded in the provided view.
    Arguments:
        view        - The view that will contain the control.
        callback    - The block that will receive the result of the user action. 
 */
- (void)presentInView:(UIView *)view withBlock:(CHModalPickerCallBack)callback;

/* Presents the control embedded in the current window.
    Arguments:
        callback    - The block that will receive the result of the user action. 
 */
- (void)presentWithBlock:(CHModalPickerCallBack)callback;

@end
