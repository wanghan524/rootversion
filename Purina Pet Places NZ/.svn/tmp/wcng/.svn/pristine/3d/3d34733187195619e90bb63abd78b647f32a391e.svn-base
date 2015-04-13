//
//  Singleton.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 16/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton
@synthesize someProperty, currentCategories, currentSubCategories, locationListing, selectedLocation, selectedCategories, selectedSubCategories;

static Singleton *sharedInstance = nil;

// Get the shared instance and create it if necessary.
+ (id)sharedInstance {
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
    }
    return self;
}
- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end


