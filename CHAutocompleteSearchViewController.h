//
//  AutocompleteSearchViewController.h
//  deliapp
//
//  Created by Anthony Broussard on 6/1/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHAutocompleteDelegate.h"

@interface CHAutocompleteSearchViewController : UITableViewController <UISearchDisplayDelegate, CHAutocompleteDelegate, UITextFieldDelegate, UISearchBarDelegate> {
    
}
@property (nonatomic, retain) UISearchDisplayController *searchController;
@property (nonatomic, retain) NSMutableArray *suggestions;
@property (nonatomic, retain) UISearchBar *searchBar;

-(void)setupUI;
-(void)callAutocompleteAPI:(NSString *)searchString;
-(void)suggestionChosen:(NSString *)suggestion;

- (void)hackToAddKeyboardSearchKey;

@end
