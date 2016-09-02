//
//  DatabaseOfWorldObjects.h
//  VWorld
//
//  Created by Michael Ellertson on 5/29/14.
//  Copyright (c) 2014 AR Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Test Object Locations.h"
#import "WorldCoordinate.h"

@interface NSMutableDictionary (DatabaseOfWorldObjects)

- (id)populateWithDatabaseObjects;

@end
