//
//  RiddleGenerator.h
//  VWorld
//
//  Created by Michael Ellertson on 6/6/14.
//  Copyright (c) 2014 AR Games. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Riddle : NSObject
{
    NSString *_question;
    NSString *_answer;
}

@property NSString *question;
@property NSString *answer;

@end

@interface RiddleGenerator : NSObject

- (Riddle *) getNewRiddle;

@end
