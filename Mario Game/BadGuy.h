//
//  BadGuy.h
//  Mario Game
//
//  Created by Joe Lucero on 6/10/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BadGuy : NSObject

@property (nonatomic) int strength;
@property (nonatomic, strong) UIImage *badGuyImage;
@property (nonatomic) BOOL isNotABadGuyButInsteadAPowerUp;
@property (nonatomic) BOOL isNotABadGuyButInsteadAMushroom;
@property (nonatomic) BOOL isNotABadGuyButInsteadAFlower;

@end
