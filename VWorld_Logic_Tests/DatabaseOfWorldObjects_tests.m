//
//  DatabaseOfWorldObjects_tests.m
//  VWorld
//
//  Created by Michael Ellertson on 5/29/14.
//  Copyright (c) 2014 AR Games. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DatabaseOfWorldObjects.h"

@interface DatabaseOfWorldObjects_tests : XCTestCase
{
    NSMutableDictionary *dbOfObjects;
}

@end

@implementation DatabaseOfWorldObjects_tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    dbOfObjects = [[NSMutableDictionary alloc] init];
    [dbOfObjects populateWithDatabaseObjects];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_initDBOfObjectShouldFailWhenCountIsZero
{
    // test
    XCTAssertNotEqual([dbOfObjects count], 0);
}

- (void)test_initDBOfObjectShouldPassWhenCountIs5
{
    // test
    XCTAssertEqual([dbOfObjects count], 5);
}


@end
