//
//  VWorld_Logic_Tests.m
//  VWorld_Logic_Tests
//
//  Created by Michael Ellertson on 4/14/14.
//  Copyright (c) 2014 AR Games. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Unit Conversions.h"

@interface VWorld_Logic_Tests : XCTestCase

@end

@implementation VWorld_Logic_Tests

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

- (void)test_Unit_Conversion__convertDegreesToRadians
{
    // Local variables
    int roundingFactor = 10000000;
    radianLong rValue = 0.0;
    radianLong testValue;
    
    // 270 degrees should yield 2 * pi * .75 = 4.71238898038469
    rValue = floor(convertDegreesToRadians(270.0) * roundingFactor) / roundingFactor;
    testValue = floor(4.71238898038469 * roundingFactor) / roundingFactor;
    XCTAssertEqual(rValue, testValue, "incorrect value returned by convertDegreesToRadians");
    
    // 180 degrees should yield pi = 3.141592653589793
    rValue = floor(convertDegreesToRadians(180.0) * roundingFactor) / roundingFactor;
    testValue = floor(3.141592653589793 * roundingFactor) / roundingFactor;
    XCTAssertEqual(rValue, testValue, "incorrect value returned by convertDegreesToRadians");
    
    // 90 degrees should yield 2 * pi / 4 = 1.5707963267949
    rValue = floor(convertDegreesToRadians(90.0) * roundingFactor) / roundingFactor;
    testValue = floor(1.5707963267949 * roundingFactor) / roundingFactor;
    XCTAssertEqual(rValue, testValue, "incorrect value returned by convertDegreesToRadians");
    
    // 45 degress should yield 2 * pi / 8 = 0.78539816339745
    rValue = floor(convertDegreesToRadians(45.0) * roundingFactor) / roundingFactor;
    testValue = floor(0.78539816339745 * roundingFactor) / roundingFactor;
    XCTAssertEqual(rValue, testValue, "incorrect value returned by convertDegreesToRadians");
    
    // 1 degree should yield 2 * pi / 360 = 0.01745329251994
    rValue = floor(convertDegreesToRadians(1.0) * roundingFactor) / roundingFactor;
    testValue = floor(0.01745329251994 * roundingFactor) / roundingFactor;
    XCTAssertEqual(rValue, testValue, "incorrect value returned by convertDegreesToRadians");
    
    // 23 degrees should yield 2 * pi / 360 * 23 = 0.40142572795862
    rValue = floor(convertDegreesToRadians(23.0) * roundingFactor) / roundingFactor;
    testValue = floor(0.40142572795862 * roundingFactor) / roundingFactor;
    XCTAssertEqual(rValue, testValue, "incorrect value returned by convertDegreesToRadians");
    
    // 52 degrees should yield 2 * pi / 360 * 52 = 0.90757121103688
    rValue = floor(convertDegreesToRadians(52.0) * roundingFactor) / roundingFactor;
    testValue = floor(0.90757121103688 * roundingFactor) / roundingFactor;
    XCTAssertEqual(rValue, testValue, "incorrect value returned by convertDegreesToRadians");
    
    // 198 degrees should yield 2 * pi / 360 * 198 = 3.45575191894812
    rValue = floor(convertDegreesToRadians(198.0) * roundingFactor) / roundingFactor;
    testValue = floor(3.45575191894812 * roundingFactor) / roundingFactor;
    XCTAssertEqual(rValue, testValue, "incorrect value returned by convertDegreesToRadians");
    
    // 328 degrees should yield pi / 360 * 328 = 5.72467994654032
    rValue = floor(convertDegreesToRadians(328.0) * roundingFactor) / roundingFactor;
    testValue = floor(5.72467994654032 * roundingFactor) / roundingFactor;
    XCTAssertEqual(rValue, testValue, "incorrect value returned by convertDegreesToRadians");
}


@end
