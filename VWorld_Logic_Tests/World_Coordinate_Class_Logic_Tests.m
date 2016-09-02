//
//  World_Coordinate_Class_Logic_Tests.m
//  VWorld
//
//  Created by Michael Ellertson on 4/14/14.
//  Copyright (c) 2014 AR Games. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WorldCoordinate.h"
#import "Test Object Locations.h"

@interface World_Coordinate_Class_Logic_Tests : XCTestCase {
    
}

@end

@implementation World_Coordinate_Class_Logic_Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_allocAndInitWithLatitude
{
    WorldCoordinate *testCoord1 = [WorldCoordinate allocAndInitWithLatitude:36.12 Longitude:-86.67 Altitude:0.0];
    
    XCTAssertEqual(testCoord1.latitude, 36.12, @"latitude is wrong");
    XCTAssertEqual(testCoord1.longitude, -86.67, @"longitude is wrong");
    XCTAssertEqual(testCoord1.altitudeAGL, 0.0, @"altitude is wrong");
}

- (void)test_feetFromLocation_WithTestLocationGPSCoordinatesFrom_TestObjectLocations_h
{
    // Local variables
    WorldCoordinate *point1 = [[WorldCoordinate alloc] init];
    WorldCoordinate *point2 = [[WorldCoordinate alloc] init];
    WorldCoordinate *point3 = [[WorldCoordinate alloc] init];
    WorldCoordinate *point4 = [[WorldCoordinate alloc] init];
    WorldCoordinate *point5 = [[WorldCoordinate alloc] init];
    WorldCoordinate *point6 = [[WorldCoordinate alloc] init];
    double distance = 0.0;
    

    [point1 updateWithLatitude:LOC1LAT Longitude:LOC1LONG Altitude:0.0];
    [point2 updateWithLatitude:LOC2LAT Longitude:LOC2LONG Altitude:0.0];
    [point3 updateWithLatitude:LOC3LAT Longitude:LOC3LONG Altitude:0.0];
    [point4 updateWithLatitude:LOC4LAT Longitude:LOC4LONG Altitude:0.0];
    [point5 updateWithLatitude:LOC5LAT Longitude:LOC5LONG Altitude:0.0];
    [point6 updateWithLatitude:LOC6LAT Longitude:LOC6LONG Altitude:0.0];
    
    distance = [point1 feetFromLocation:point2];
    XCTAssertEqualWithAccuracy(distance, 101.35, 1.000, @"distance is wrong");
    
    distance = [point1 feetFromLocation:point3];
    XCTAssertEqualWithAccuracy(distance, 55.18, 1.000, @"distance is wrong");
    
    distance = [point1 feetFromLocation:point4];
    XCTAssertEqualWithAccuracy(distance, 210.33, 1.000, @"distance is wrong");
    
    distance = [point1 feetFromLocation:point5];
    XCTAssertEqualWithAccuracy(distance, 81.92, 1.000, @"distance is wrong");
    
    distance = [point1 feetFromLocation:point6];
    XCTAssertEqualWithAccuracy(distance, 153.90, 1.000, @"distance is wrong");
}



@end








