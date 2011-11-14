//
//  AutocompleteSearchViewController.m
//  deliapp
//
//  Created by Anthony Broussard on 6/1/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "CHAutocompleteSearchViewController.h"

@implementation CHAutocompleteSearchViewController
@synthesize  searchController;
@synthesize suggestions;

@synthesize searchBar;

- (void)dealloc
{
    self.searchBar = nil;
    self.searchController = nil;
    [super dealloc];
}

-(void)close {
    NSLog(@"CHAutocompleteSearchViewController close method defaults to dismissing modal. You should override this method if needed in your subclass.");
    [self dismissModalViewControllerAnimated:YES];
}

-(void)callAutocompleteAPI:(NSString *)searchString  {
    NSLog(@"CHAutocompleteSearchViewController callAutocompleteAPI called. You need to override this method in your subclass.");
}

- (void)manageAutocompletionBehaviorForString:(NSString *)query {
    int length = [query length];
    if (length >= 3) {
        [self callAutocompleteAPI:query];
    }

}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self manageAutocompletionBehaviorForString:searchString];
    
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];    
    if (!self.suggestions) {
        self.suggestions = [NSMutableArray array];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}

- (void) hackToAddKeyboardSearchKey {
    for (UIView *searchBarSubview in [self.searchBar subviews]) {        
        if ([searchBarSubview conformsToProtocol:@protocol(UITextInputTraits)]) {
            @try {
                [(UITextField *)searchBarSubview setReturnKeyType:UIReturnKeySearch];
                [(UITextField *)searchBarSubview setDelegate:self];
            }
            @catch (NSException * e) {                
                // ignore exception
            }
        }
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar {
    [aSearchBar resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self callAutocompleteAPI:textField.text];
    [self.searchBar resignFirstResponder];
    return YES;
}

- (void)setupCloseButton {
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                           target:self 
                                                                                    action:@selector(close)] autorelease];
}

- (void)setupSearchBar {
    self.searchBar = [[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)] autorelease];
    self.searchBar.delegate = self;
    self.searchBar.keyboardType = UIKeyboardTypeDefault;
    
    [self hackToAddKeyboardSearchKey];
    [self.searchBar becomeFirstResponder];
    self.tableView.tableHeaderView = searchBar;    
}

- (void)setupSearchController {
    self.searchController = [[[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self] autorelease];
    self.searchController.delegate = self;
    self.searchController.searchResultsDelegate = self;
    self.searchController.searchResultsDataSource = self; 
}

-(void)setupUI {
    [self setupCloseButton];
    [self setupSearchBar];
    [self setupSearchController];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}

-(void)suggestionChosen:(NSString *)suggestion {
    NSLog(@"Override with your own delegate callback!");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self suggestionChosen:[self.suggestions objectAtIndex:indexPath.row]];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)suggestedResults:(NSMutableArray *)suggestedResults page:(int)pageNumber {
    self.suggestions = suggestedResults;
    [self.searchDisplayController.searchResultsTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.suggestions count] == 0) {
        return 0;        
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.suggestions count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [self.suggestions objectAtIndex:indexPath.row];
    
    return cell;
}

@end
