//
//  CHModalPickerView.m
//  ChaiOneUI
//
//  Created by Ben Scheirman on 1/10/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import "CHModalPickerView.h"

#define CHMODALPICKER_BACKGROUND_OPACITY 0.8
#define CHMODALPICKER_TOOLBAR_HEIGHT 40
#define CHMODALPICKER_PANEL_HEIGHT 200
#define CHMODALPICKER_ANIMATION_DURATION 0.25

@implementation CHModalPickerView

@synthesize selectedIndex, values;

- (id)initWithValues:(NSArray *)values_ {
    self = [super init];
    if (self) {
        self.values = values_;
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

- (void)dealloc {
    if (_callback) {
        Block_release(_callback);
    }
    
    [super dealloc];
}

- (void)setSelectedIndex:(NSInteger)newIndex {
    selectedIndex = newIndex;
    if (_picker) {
        [_picker selectRow:newIndex inComponent:0 animated:YES];
    }
}

- (void)setSelectedValue:(NSString *)value {
    self.selectedIndex = [self.values indexOfObject:value];
}

- (NSString *)selectedValue {
    return [self.values objectAtIndex:self.selectedIndex];
}

- (void)setValues:(NSArray *)newValues {
    if (values && values != newValues) {
        [values release];
    }
    
    if (newValues) {
        values = [newValues retain];
        if (_picker) {
            [_picker reloadAllComponents];
        }
    }
}

- (void)dismissPicker {
    [UIView animateWithDuration:CHMODALPICKER_ANIMATION_DURATION 
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^ {
                         _backdropView.alpha = 0;
                         CGRect frame = _panel.frame;
                         frame.origin.y += frame.size.height;
                         _panel.frame = frame;
                     } completion: ^(BOOL finished) {
                         [_panel removeFromSuperview]; 
                         _panel = nil;
                         [_backdropView removeFromSuperview];
                         _backdropView = nil;
                         [self removeFromSuperview];
                     }];

    
    Block_release(_callback);
    _callback = nil;
}

- (void)onCancel:(id)sender {
    _callback(NO);
    [self dismissPicker];
}

- (void)onDone:(id)sender {
    NSLog(@"Done!");
    _callback(YES);
    [self dismissPicker];
}

- (void)onTapRecognized:(UITapGestureRecognizer *)gesture {
    [self onCancel:gesture];
}

- (UIView *)backdropView {
    UIView *backdrop = [[UIView alloc] initWithFrame:self.bounds];
    backdrop.backgroundColor = [UIColor colorWithWhite:0 alpha:CHMODALPICKER_BACKGROUND_OPACITY];
    backdrop.alpha = 0;
    UIGestureRecognizer *tapRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapRecognized:)] autorelease];
    [backdrop addGestureRecognizer:tapRecognizer];
    return backdrop;
}

- (UIPickerView *)picker {
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CHMODALPICKER_TOOLBAR_HEIGHT, self.bounds.size.width, CHMODALPICKER_PANEL_HEIGHT - CHMODALPICKER_TOOLBAR_HEIGHT)]; 
    picker.delegate = self;
    picker.dataSource = self;
    picker.showsSelectionIndicator = YES;
    [picker selectRow:self.selectedIndex inComponent:0 animated:NO];
    
    return [picker autorelease];
}

- (UIToolbar *)toolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, CHMODALPICKER_TOOLBAR_HEIGHT)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    
    toolbar.items = [NSArray arrayWithObjects:
                     [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                                                    target:self 
                                                                    action:@selector(onCancel:)] autorelease],
                     [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                                                    target:nil 
                                                                    action:nil] autorelease],
                     [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                                                    target:self 
                                                                    action:@selector(onDone:)] autorelease],
                     nil];
    
    return toolbar;
}

- (void)presentWithBlock:(CHModalPickerCallBack)callback {
    id appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate respondsToSelector:@selector(window)]) {
        UIWindow *window = [appDelegate window];
        [self presentInView:window withBlock:callback];
    } else {
        [NSException exceptionWithName:@"No window found" reason:@"Could not find a window property on your app delegate." userInfo:nil];
    }
}

- (void)presentInView:(UIView *)view withBlock:(CHModalPickerCallBack)callback {
    self.frame = view.bounds;
    
    if(callback) {
        Block_release(_callback);
        _callback = nil;
    }
    _callback = Block_copy(callback);
    
    [_panel removeFromSuperview];
    [_backdropView removeFromSuperview];
    
    _panel      = [[[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - CHMODALPICKER_PANEL_HEIGHT, self.bounds.size.width, CHMODALPICKER_PANEL_HEIGHT)] autorelease];
    _picker     = [self picker];
    _toolbar    = [self toolbar];
    
    [_panel addSubview:_toolbar];
    [_panel addSubview:_picker];
    
    _backdropView = [self backdropView];
    [self addSubview:_backdropView];
    [self addSubview:_panel];
    [view addSubview:self];
    
    CGRect oldFrame = _panel.frame;
    CGRect newFrame = oldFrame;
    newFrame.origin.y += newFrame.size.height;
    _panel.frame = newFrame;
    
    [UIView animateWithDuration:CHMODALPICKER_ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^ {
                         _panel.frame = oldFrame;
                         _backdropView.alpha = 1;
                     } completion:^ (BOOL finished) { }];
}

#pragma mark - UIPickerView methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.values.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.values objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedIndex = row;
}

@end
