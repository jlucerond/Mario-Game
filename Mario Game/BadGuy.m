//
//  BadGuy.m
//  Mario Game
//
//  Created by Joe Lucero on 6/10/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import "BadGuy.h"

@implementation BadGuy

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.strength = arc4random_uniform(7) + 1;
        self.badGuyImage = [UIImage imageNamed:[NSString stringWithFormat:@"bad%i.jpg", self.strength]];
    }
    return self;
}

@end
