//
//  ViewController.h
//  Mario Game
//
//  Created by Joe Lucero on 6/9/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BadGuy.h"
#import "Mario.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *randomNumberLabel;
@property (strong, nonatomic) IBOutlet UIImageView *badGuyImage;
@property (strong, nonatomic) IBOutlet UIImageView *marioImage;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *directionButtons;
@property (strong, nonatomic) IBOutlet UIButton *attackButton;
@property (strong, nonatomic) IBOutlet UIButton *runButton;
@property (strong, nonatomic) IBOutlet UIButton *getItemButton;
@property (strong, nonatomic) IBOutlet UIButton *playAgainButton;
@property (strong, nonatomic) IBOutlet UILabel *marioScoreLabel;

@property (strong, nonatomic) Mario *marioCharacter;
@property (strong, nonatomic) BadGuy *currentBadGuy;

@property (nonatomic) CGPoint currentPoint;
@property (nonatomic, strong) NSMutableArray *myArrayOfTiles;
@property (nonatomic) BOOL didJustWin;
@property (nonatomic) int scoreOfGame;

@end

