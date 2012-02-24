//
//  AutocompleteProtocol.h
//  deliapp
//
//  Created by Anthony Broussard on 6/1/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CHAutocompleteDelegate

-(void)suggestedResults:(NSMutableArray *)suggestedResults page:(int)pageNumber;

@end

