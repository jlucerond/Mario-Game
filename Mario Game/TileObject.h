//
//  TileObject.h
//  Mario Game
//
//  Created by Joe Lucero on 6/10/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BadGuy.h"

@interface TileObject : NSObject

@property (nonatomic, strong) BadGuy *thisTilesBadGuy;

@end
