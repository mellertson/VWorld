//
//  WorldObject.h
//  VWorld
//
//  Created by Michael Ellertson on 3/25/13.
//  Copyright (c) 2013 AR Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorldCoordinate.h"

typedef NSString WCObjectID;

@interface WorldObject : NSObject
{
    WCObjectID *objectID;
    WorldCoordinate *wCoordinate;
}

@property (nonatomic, copy) WCObjectID *objectID;
@property (nonatomic, copy) WorldCoordinate *wCoordinate;

- (WorldCoordinate *)wCoordinate;

//- (id)copyWithZone:(NSZone *)zone;

@end
