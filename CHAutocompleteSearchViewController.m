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
    [self dismissModalViewControllerAnimated:YES];
}

-(void)callAutocompleteAPI:(NSString *)searchString  {
    NSLog(@"Subclass this class!");
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    if ([searchString length] <= 1) {
        self.suggestions = nil;
    } else if ([searchString length] >= 3) {
        [self callAutocompleteAPI:searchString];
    }
    
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];    
    self.suggestions = [NSMutableArray array];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self callAutocompleteAPI:textField.text];
    return YES;
}

-(void)setupUI {
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                           target:self 
                                                                                           action:@selector(close)] autorelease];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    self.searchBar.keyboardType = UIKeyboardTypeDefault;
    
    [self hackToAddKeyboardSearchKey];

    self.tableView.tableHeaderView = searchBar;
    
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchController.delegate = self;
    self.searchController.searchResultsDelegate = self;
    self.searchController.searchResultsDataSource = self;
    
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
