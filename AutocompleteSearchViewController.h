//
//  AutocompleteSearchViewController.h
//  deliapp
//
//  Created by Anthony Broussard on 6/1/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutocompleteProtocol.h"

@interface AutocompleteSearchViewController : UITableViewController <UISearchDisplayDelegate, AutocompleteDelegate> {
    
}
@property (nonatomic, retain) UISearchDisplayController *searchController;
@property (nonatomic, retain) NSMutableArray *suggestions;
@property (nonatomic, retain) UISearchBar *searchBar;

-(void)setupUI;
-(void)callAutocompleteAPI:(NSString *)searchString;
-(void)suggestionChosen:(NSString *)suggestion;

@end
