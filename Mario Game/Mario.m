//
//  Mario.m
//  Mario Game
//
//  Created by Joe Lucero on 6/10/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import "Mario.h"

@implementation Mario

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.marioStrength = 1;
        self.marioImage = [UIImage imageNamed:[NSString stringWithFormat:@"mario%i.jpg", self.marioStrength]];
    }
    return self;
}

@end
