//
//  LKarneval.m
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#define PLIST_PLACES "Places"
#define PLIST_EVENTS "Events"

const int NumberOfFilters = 2;

@implementation LKarneval

#pragma mark Singleton

+ (LKarneval *)sharedLKarneval {
    
    static LKarneval *sharedLKarneval;
    
    @synchronized(self) { //low level thread stuff, don't bother.
        
        if(!sharedLKarneval) {
            
            sharedLKarneval = [[LKarneval alloc] init];
            
        }
        
        return sharedLKarneval;
        
    }
    
}

#pragma mark Designated initializer

- (LKarneval *)init {
    
    self = [super init];
    
    if(self) {
        
        NSLog(@"favorites: %@", [self favoriteEvents]);
        //the loading of places and events is taking place inside of the getters.
        
    }
    
    return self;
    
}

#pragma mark Lazy Instantiation

- (NSDictionary *)openingHours {
    
    if(!_openingHours) {
        
        NSLog(@"%@: reading opening hours..", self.class);
        NSString *path = [[NSBundle mainBundle] pathForResource:@"OpeningHours" ofType:@"plist"];
        _openingHours = [NSDictionary dictionaryWithContentsOfFile:path];
        
    }
    
    return _openingHours;
    
}

- (NSMutableArray *)places {
    
    if(!_places) {
        
        _places = [[NSMutableArray alloc] init];
        
        NSLog(@"%@: reading places..", self.class);
        
        
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Places" ofType:@"plist"];
        NSDictionary *places;
        
        NSString *docsFolder = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *docsPath = [docsFolder stringByAppendingString:@"/Places.plist"];
        // checks if file exists at the documents path, if so it takes the file, otherwise it takes the paht of the bundle.
        if ([[NSFileManager defaultManager] fileExistsAtPath:docsPath]) {
            places = [NSDictionary dictionaryWithContentsOfFile:docsPath];
        } else {
            places = [NSDictionary dictionaryWithContentsOfFile:path];
        }
        
        for(NSString *identifier in places) { //dictionary enumerates with the key (NSString).
            
            LKPlace *place = [[LKPlace alloc] initWithProperties:places[identifier]];
            place.identifier = identifier;
            
            [_places addObject:place];
            
        }
        
    }
    
    return _places;
    
}

- (NSMutableArray *)events {
    
    if(!_events) {
        
        _events = [[NSMutableArray alloc] init];
        
        NSLog(@"%@: reading events..", self.class);
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Events" ofType:@"plist"];
        NSArray *events = [NSArray arrayWithContentsOfFile:path];
        
        for(NSDictionary *eventProperties in events) {
            
            LKEvent *event = [[LKEvent alloc] initWithProperties:eventProperties];
            event.place = [self placeWithIdentifier:eventProperties[@"place"]];
            
            [_events addObject:event];
            
        }
        
        //sort by time and remove events that are past time (method in the LKEvent model) *todo*.
        
    }
    
    return _events;
    
}

#pragma mark Methods

- (NSArray *)favoriteEvents {
    
    NSMutableArray *favorites;
    
    for(LKEvent *event in self.events) {
        
        if([event isFavorite]) {
            
            if(!favorites)
                favorites = [[NSMutableArray alloc] init];
            
            [favorites addObject:event];
            
        }
        
    }
    
    return favorites;
    
}

- (NSArray *)placesFilteredByCategories:(NSArray *)categories {
    
    NSMutableArray *places;
    
    for(LKPlace *place in self.places) { //one to many relation.
        for(NSNumber *typeContainer in categories) {
         
            LKPlaceCategory category = [typeContainer integerValue];
            
            if(place.category == category) {
                
                if(!places)
                    places = [[NSMutableArray alloc] init]; //lazy instantiation mofo.
                
                [places addObject:place];
                break;
                
            }
            
        }
    }
    
    return places;
    
}

- (NSArray *)placesExcludedByCategories:(NSArray *)categories {
    
    NSMutableArray *places;
    
    for(LKPlace *place in self.places) {
        
        BOOL includePlace = YES;
        
        for(NSNumber *typeContainer in categories) {
            
            LKPlaceCategory category = [typeContainer integerValue];
            
            if(place.category == category) {

                includePlace = NO;
                break;
                
            }
            
        }
        
        if(includePlace) {
         
            if(!places)
                places = [[NSMutableArray alloc] init]; //lazy mofo.
            
            [places addObject:place];
            
        }
        
    }
    
    return places;
    
}

- (NSArray *)placesWithoutAlcohol { //*sobs*
    
    NSMutableArray *nonAlcoholic = [[NSMutableArray alloc] init];
    
    for(LKPlace *place in self.places) {
        
        if(!place.alcohol) {
            
            [nonAlcoholic addObject:place];
            
        }
        
    }
    
    return nonAlcoholic;
    
}

- (NSArray *)eventsAtPlaceWithIdentifier:(NSString *)identifier {
    
    NSMutableArray *events = [[NSMutableArray alloc] init];
    
    for(LKEvent *event in self.events) {
        
        if([event.place.identifier isEqualToString:identifier]) {
            
            [events addObject:event];
            
        }
        
    }
    
    return events;
    
}

- (LKPlace *)placeWithIdentifier:(NSString *)identifier { //looking for a LKPlace inside of _places array with the desired identifier and returns it.
    
    for(LKPlace *place in self.places) {
        
        if([place.identifier isEqualToString:identifier]) {
            
            return place;
            
        }
        
    }
    
    return nil;
    
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"This is %@ and we're opening at %@, at the moment we have %d events and %d places to see.", self.class, self.openingHours, [self.places count], [self.events count]];
    
}

#pragma mark Class methods

+ (NSArray *)LKPlaceFilterFood {
    
    return @[@(LKPlaceCategoryFood), @(LKPlaceCategorySnacks), @(LKPlaceCategoryCoffee), @(LKPlaceCategoryBeverage)];
    
}

+ (NSArray *)LKPlaceFilterEntertainment {
    
    return @[@(LKPlaceCategoryTent), @(LKPlaceCategoryScene), @(LKPlaceCategoryLottery), @(LKPlaceCategoryMinorEntertainment), @(LKPlaceCategoryEntertainment), @(LKPlaceCategoryShow)];
    
}

@end
