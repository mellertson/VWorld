//
//  WorldObject.m
//  VWorld
//
//  Created by Michael Ellertson on 3/25/13.
//  Copyright (c) 2013 AR Games. All rights reserved.
//

#import "WorldObject.h"

@implementation WorldObject

@synthesize objectID;
@synthesize wCoordinate;

- (id)init {
    self = [super init];
    if (self) {
        // Initialize self.
        objectID = [[NSString alloc] init];
        wCoordinate = [[WorldCoordinate alloc] init];
        
    }
    return self;
}

- (void)dealloc {
    wCoordinate = nil;
    objectID = nil;
}

//#pragma mark - NSCopying Protocol Methods
//- (id)copyWithZone:(NSZone *)zone {
//    
//    WorldObject *newWorldObject = [[WorldObject alloc] init];
//    if (newWorldObject) {
//        newWorldObject.objectID = self.objectID;
//        newWorldObject.wCoordinate = self.wCoordinate;
//    }
//    
//    return newWorldObject;
//}

@end
