//
//  Factory.m
//  Mario Game
//
//  Created by Joe Lucero on 6/10/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import "Factory.h"
#import <UIKit/UIKit.h>
#import "TileObject.h"

@implementation Factory

- (NSMutableArray *) createGameTiles {
    
    NSMutableArray *fiveRowsOfFiveColumnsOfTiles = [[NSMutableArray alloc] init];
    
    for (int n = 0; n < 5; n++){
    
        NSMutableArray *oneColumnOfFiveTiles = [[NSMutableArray alloc] init];

        for (int i = 0; i < 5; i++) {
            TileObject *newTile = [[TileObject alloc] init];
            newTile.thisTilesBadGuy = [[BadGuy alloc] init];
            [oneColumnOfFiveTiles addObject:newTile];
        }
        
        [fiveRowsOfFiveColumnsOfTiles addObject:oneColumnOfFiveTiles];
        
    }
    
    // place one mushroom in the middle of the screen
    TileObject *mushroomItem = [[TileObject alloc] init];
    mushroomItem.thisTilesBadGuy = [[BadGuy alloc] init];
    mushroomItem.thisTilesBadGuy.isNotABadGuyButInsteadAPowerUp = true;
    mushroomItem.thisTilesBadGuy.isNotABadGuyButInsteadAMushroom = true;
    mushroomItem.thisTilesBadGuy.strength = 0;
    mushroomItem.thisTilesBadGuy.badGuyImage = [UIImage imageNamed:@"mushroom.jpg"];
    [[fiveRowsOfFiveColumnsOfTiles objectAtIndex:2] replaceObjectAtIndex:2 withObject:mushroomItem];
    
    //place one flower in a random location
    CGPoint placeForFlower = [self randomCGPointNotNearCenterOfScreen];
    NSLog(@"Flower: %f and %f", placeForFlower.x, placeForFlower.y);
    TileObject *flowerItem = [[TileObject alloc] init];
    flowerItem.thisTilesBadGuy = [[BadGuy alloc] init];
    flowerItem.thisTilesBadGuy.isNotABadGuyButInsteadAPowerUp = true;
    flowerItem.thisTilesBadGuy.isNotABadGuyButInsteadAFlower = true;
    flowerItem.thisTilesBadGuy.strength = 0;
    flowerItem.thisTilesBadGuy.badGuyImage = [UIImage imageNamed:@"flower.jpg"];
    [[fiveRowsOfFiveColumnsOfTiles objectAtIndex:placeForFlower.x] replaceObjectAtIndex:placeForFlower.y  withObject:flowerItem];
    
    //place bowser in a random location
    CGPoint placeForBowser = [self randomCGPointNotNearCenterOfScreen];
    for (int n = 0; n < 10; n++) {
        if (placeForFlower.x == placeForBowser.x && placeForFlower.y == placeForBowser.y){
            NSLog(@"same spot for flower/bowser, let's redo this");
            placeForBowser = [self randomCGPointNotNearCenterOfScreen];
        }
    }
    
    NSLog(@"Bowser: %f and %f", placeForBowser.x, placeForBowser.y);
    TileObject *BowserTile = [[TileObject alloc] init];
    BowserTile.thisTilesBadGuy = [[BadGuy alloc] init];
    BowserTile.thisTilesBadGuy.strength = 9;
    BowserTile.thisTilesBadGuy.badGuyImage = [UIImage imageNamed:@"bad9.jpg"];
    [[fiveRowsOfFiveColumnsOfTiles objectAtIndex:placeForBowser.x] replaceObjectAtIndex:placeForBowser.y  withObject:BowserTile];
    
    return fiveRowsOfFiveColumnsOfTiles;
}

- (CGPoint) randomCGPointNotNearCenterOfScreen {
    int x = arc4random_uniform(4);
    int y = arc4random_uniform(4);
    
    if ((x == 2 && y == 2) || (x == 1 && y == 2) || (x == 2 && y == 1) || (x == 2 && y == 3) || (x == 3 && y == 2)) {
        NSLog(@"repeat random cg point");
        return [self randomCGPointNotNearCenterOfScreen];
    }
    
    return CGPointMake(x, y);
    
}

@end
