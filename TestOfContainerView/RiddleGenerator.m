//
//  RiddleGenerator.m
//  VWorld
//
//  Created by Michael Ellertson on 6/6/14.
//  Copyright (c) 2014 AR Games. All rights reserved.
//

#import "RiddleGenerator.h"

@implementation Riddle

@synthesize question = _question;
@synthesize answer = _answer;

- (id)init {
    self = [super init];
    if (self) {
        // Initialize self.
        _question = [[NSString alloc] init];
        _answer = [[NSString alloc] init];
        
    }
    return self;
}

- (id)initWithQuestion:(NSString *)question andAnswer:(NSString *)answer
{
    self = [self init];
    [self setQuestion:question];
    [self setAnswer:answer];
    return self;
}


@end

@implementation RiddleGenerator

- (Riddle *) getNewRiddle
{
    return [[Riddle alloc] initWithQuestion:@"What is throne to both kings and beggars?" andAnswer:@"Toilet"];
}

@end

