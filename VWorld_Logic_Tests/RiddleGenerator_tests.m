//
//  RiddleGenerator_tests.m
//  VWorld
//
//  Created by Michael Ellertson on 6/6/14.
//  Copyright (c) 2014 AR Games. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RiddleGenerator.h"

@interface RiddleGenerator_tests : XCTestCase
{
    RiddleGenerator *riddleGenerator;
}

@end

@implementation RiddleGenerator_tests

- (void)setUp
{
    [super setUp];
    riddleGenerator = [[RiddleGenerator alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_getNewRiddle_ShouldPass_ReturningNewRiddle
{
    // where
    Riddle *riddle = [riddleGenerator getNewRiddle];

    // test
    XCTAssertTrue([riddle.question caseInsensitiveCompare:@"what is throne to both kings and beggars?"] == NSOrderedSame, @"question isn't correct");
    XCTAssertTrue([riddle.answer caseInsensitiveCompare:@"toilet"] == NSOrderedSame, @"answer isn't correct");
}



@end
