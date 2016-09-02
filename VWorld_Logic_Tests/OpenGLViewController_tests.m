//
//  OpenGLViewController_tests.m
//  VWorld
//
//  Created by Michael Ellertson on 5/29/14.
//  Copyright (c) 2014 AR Games. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DatabaseOfWorldObjects.h"
#import "OpenGLViewController.h"

@interface OpenGLViewController_tests : XCTestCase
{
    OpenGLViewController *viewController;
    NSMutableDictionary *dictionaryOfObjects;
    NSMutableArray *arrayObjectsToBeRendered;
    WorldCoordinate *gpsLoc1Plus10;
    WorldCoordinate *gpsLoc1;
    WorldCoordinate *gpsLoc2;
}

@end

@implementation OpenGLViewController_tests
{
    
}

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the
    viewController = [[OpenGLViewController alloc] init];
    dictionaryOfObjects = [[NSMutableDictionary alloc] init];
    [dictionaryOfObjects populateWithDatabaseObjects];
    arrayObjectsToBeRendered = [[NSMutableArray alloc] init];
    gpsLoc1Plus10 = [[WorldCoordinate alloc] initWithLatitude:LOC1LAT + 10 Longitude:LOC1LONG + 10 Altitude:0.0];
    gpsLoc1 = [[WorldCoordinate alloc] initWithLatitude:LOC1LAT Longitude:LOC1LONG Altitude:0.0];
    gpsLoc2 = [[WorldCoordinate alloc] initWithLatitude:LOC2LAT Longitude:LOC2LONG Altitude:0.0];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)populateArrayObjectsToBeRendered_WithFiveObjects
{
    short int radius = 280; // 100 foot radius
    WorldCoordinate *gpsCoordinate = [[WorldCoordinate alloc] initWithLatitude:LOC2LAT Longitude:LOC2LONG Altitude:0.0];
    
    // Add 5 objects to the rendering list
    arrayObjectsToBeRendered = [viewController addObjectsToRenderingList:arrayObjectsToBeRendered witinRadius:radius fromGPSCoordinate:gpsCoordinate usingDBOfObjects:dictionaryOfObjects];
    XCTAssertEqual([dictionaryOfObjects count], 5, @"failure");         // Verify 5 objecst are in dictionaryOfObjects
    XCTAssertEqual([arrayObjectsToBeRendered count], 5, @"failure");    // Verify 5 objects are in arrayObjectsToBeRendered
}

- (void)test_initLocalVariables
{
    // No test case needed at this time (5/28/2014)
}

- (void)test_turnOnCompassNotifications
{
    // COMPLETED: 5/28/2014: No test case needed at this time.
}

- (void)test_initMotionManager
{
    // COMPLETED: 5/28/2014: No test case needed at this time.
}

- (void)test_initOpenGL
{
    // COMPLETED: 5/28/2014: No test case needed at this time.
}

- (void)test_initDBOfObjects
{
    
}

- (void)test_addObjectsToRenderingList_ShouldFail_ReturningEmptyList
{
    // where
    short int radius = 100; // 100 foot radius
    
    // test
    arrayObjectsToBeRendered = [viewController addObjectsToRenderingList:arrayObjectsToBeRendered witinRadius:radius fromGPSCoordinate:gpsLoc1Plus10 usingDBOfObjects:dictionaryOfObjects];
    
    XCTAssertEqual([arrayObjectsToBeRendered count], 0, @"failure");
}

- (void)test_addObjectsToRenderingList_ShouldPass_ReturningFiveObjects
{
    // where
    short int radius = 280; // 100 foot radius
    
    // test
    arrayObjectsToBeRendered = [viewController addObjectsToRenderingList:arrayObjectsToBeRendered witinRadius:radius fromGPSCoordinate:gpsLoc1 usingDBOfObjects:dictionaryOfObjects];
    
    XCTAssertEqual([arrayObjectsToBeRendered count], 5, @"failure");
}

- (void)test_addObjectsToRenderingList_ShouldPass_ReturningOneObject
{
    // where
    short int radius = 60; // 60 foot radius
    WorldCoordinate *gpsCoordinate = [[WorldCoordinate alloc] initWithLatitude:LOC1LAT Longitude:LOC1LONG Altitude:0.0];
    
    // test
    arrayObjectsToBeRendered = [viewController addObjectsToRenderingList:arrayObjectsToBeRendered witinRadius:radius fromGPSCoordinate:gpsCoordinate usingDBOfObjects:dictionaryOfObjects];
    arrayObjectsToBeRendered = [viewController addObjectsToRenderingList:arrayObjectsToBeRendered witinRadius:radius fromGPSCoordinate:gpsCoordinate usingDBOfObjects:dictionaryOfObjects];
    arrayObjectsToBeRendered = [viewController addObjectsToRenderingList:arrayObjectsToBeRendered witinRadius:radius fromGPSCoordinate:gpsCoordinate usingDBOfObjects:dictionaryOfObjects];
    arrayObjectsToBeRendered = [viewController addObjectsToRenderingList:arrayObjectsToBeRendered witinRadius:radius fromGPSCoordinate:gpsCoordinate usingDBOfObjects:dictionaryOfObjects];
    arrayObjectsToBeRendered = [viewController addObjectsToRenderingList:arrayObjectsToBeRendered witinRadius:radius fromGPSCoordinate:gpsCoordinate usingDBOfObjects:dictionaryOfObjects];
    arrayObjectsToBeRendered = [viewController addObjectsToRenderingList:arrayObjectsToBeRendered witinRadius:radius fromGPSCoordinate:gpsCoordinate usingDBOfObjects:dictionaryOfObjects];
    arrayObjectsToBeRendered = [viewController addObjectsToRenderingList:arrayObjectsToBeRendered witinRadius:radius fromGPSCoordinate:gpsCoordinate usingDBOfObjects:dictionaryOfObjects];
    arrayObjectsToBeRendered = [viewController addObjectsToRenderingList:arrayObjectsToBeRendered witinRadius:radius fromGPSCoordinate:gpsCoordinate usingDBOfObjects:dictionaryOfObjects];
    arrayObjectsToBeRendered = [viewController addObjectsToRenderingList:arrayObjectsToBeRendered witinRadius:radius fromGPSCoordinate:gpsCoordinate usingDBOfObjects:dictionaryOfObjects];
    
    XCTAssertEqual([arrayObjectsToBeRendered count], 1, @"failure");
}

- (void)test_addObjectsToRenderingList_Inspecting3DObjectsOpenGLCoordinates_fromLoc1
{
    // where
    ColorfulCube *cube = nil;
    short int radius = 100; // 100 foot radius
    WorldCoordinate *gpsCoordinate = [[WorldCoordinate alloc] initWithLatitude:LOC1LAT Longitude:LOC1LONG Altitude:0.0];
    
    // test
    arrayObjectsToBeRendered = [viewController addObjectsToRenderingList:arrayObjectsToBeRendered witinRadius:radius fromGPSCoordinate:gpsCoordinate usingDBOfObjects:dictionaryOfObjects];
    XCTAssertEqual([arrayObjectsToBeRendered count], 2, @"failure");
    
    for(id object in arrayObjectsToBeRendered)
    {
        cube = (ColorfulCube *)object;
        NSLog(@"%@ position.x = %f", cube.worldObjectID, cube.position.x);
        NSLog(@"%@ position.z = %f", cube.worldObjectID, cube.position.z);
    }
}

- (void)test_addObjectsToRenderingList_Inspecting3DObjectsOpenGLCoordinates_fromLoc2
{
    // where
    ColorfulCube *cube = nil;
    short int radius = 100; // 100 foot radius
    WorldCoordinate *gpsCoordinate = [[WorldCoordinate alloc] initWithLatitude:LOC2LAT Longitude:LOC2LONG Altitude:0.0];
    
    // test
    arrayObjectsToBeRendered = [viewController addObjectsToRenderingList:arrayObjectsToBeRendered witinRadius:radius fromGPSCoordinate:gpsCoordinate usingDBOfObjects:dictionaryOfObjects];
    XCTAssertEqual([arrayObjectsToBeRendered count], 2, @"failure");
    
    for(id object in arrayObjectsToBeRendered)
    {
        cube = (ColorfulCube *)object;
        NSLog(@"%@ position.x = %f", cube.worldObjectID, cube.position.x);
        NSLog(@"%@ position.z = %f", cube.worldObjectID, cube.position.z);
    }
}

- (void)test_removeAllObjectsFromRenderingList_ShouldPass_InputParamRenderingListIsNil
{
    NSMutableArray *arrayOfObjects = [viewController removeAllObjectsFromRenderingList:nil];
    
    XCTAssertNil(arrayOfObjects, @"failure");
}

- (void)test_removeAllObjectsFromRenderingList_ShouldPass_WithEmptyArrayAsInputParameter
{
    NSMutableArray *arrayOfObjects = [viewController removeAllObjectsFromRenderingList:arrayObjectsToBeRendered];
    
    XCTAssertEqual([arrayOfObjects count], 0, @"failure");
}

- (void)test_removeAllObjectsFromRenderingList_ShouldPass_AfterRemovingFiveObjectsFromTheRenderingList
{
    // where
    [self populateArrayObjectsToBeRendered_WithFiveObjects];
    
    // test
    // remove all objects from the rendering list
    // count should now be zero on arrayOfObjects
    NSMutableArray *arrayOfObjects = [viewController removeAllObjectsFromRenderingList:arrayObjectsToBeRendered];
    XCTAssertEqual([arrayOfObjects count], 0, @"failure");  // Verify all objects were removed from arrayOfObjects
}

- (void)test_removeObjectsFromRenderingList_FartherThanRadius_ShouldPass_AfterNoObjectsRemovedFromRenderingArray
{
    // where
    [self populateArrayObjectsToBeRendered_WithFiveObjects];
    
    // test
    arrayObjectsToBeRendered = [viewController removeObjectsFromRenderingList:arrayObjectsToBeRendered fartherThanRadius:1000 fromGPSCoordinate:gpsLoc1 usingDBOfObjects:dictionaryOfObjects];
    XCTAssertEqual([arrayObjectsToBeRendered count], 5, @"failure");
}

- (void)test_removeObjectsFromRenderingList_FartherThanRadius_ShouldPass_AfterRemovingFourObjectsFromRenderingArray
{
    // where
    [self populateArrayObjectsToBeRendered_WithFiveObjects];
    
    // test
    arrayObjectsToBeRendered = [viewController removeObjectsFromRenderingList:arrayObjectsToBeRendered fartherThanRadius:1 fromGPSCoordinate:gpsLoc2 usingDBOfObjects:dictionaryOfObjects];
    XCTAssertEqual([arrayObjectsToBeRendered count], 1, @"failure");
    XCTAssertTrue([[[arrayObjectsToBeRendered objectAtIndex:0] worldObjectID] isEqualToString:@"OBJECT 2"], @"failure"); // Assert that OBJECT 2 if the one in arrayObjectsToBeRendered
}

- (void)test_removeObjectsFromRenderingList_FartherThanRadius_ShouldPass_AfterRemovingTwoObjectsFromRenderingArray
{
    // where
    [self populateArrayObjectsToBeRendered_WithFiveObjects];
    
    // test
    arrayObjectsToBeRendered = [viewController removeObjectsFromRenderingList:arrayObjectsToBeRendered fartherThanRadius:60 fromGPSCoordinate:gpsLoc1 usingDBOfObjects:dictionaryOfObjects];
    XCTAssertEqual([arrayObjectsToBeRendered count], 1, @"failure");
}


@end











