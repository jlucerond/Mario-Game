//
//  ViewController.m
//  Mario Game
//
//  Created by Joe Lucero on 6/9/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import "ViewController.h"
#import "Factory.h"
#import "TileObject.h"
#import "BadGuy.h"
#import "Mario.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.marioCharacter = [[Mario alloc] init];
    self.marioImage.image = self.marioCharacter.marioImage;
    
    self.currentBadGuy = [[BadGuy alloc] init];
    
    self.currentPoint = CGPointMake(2, 2);
    self.scoreOfGame = 0;
    
    Factory *factoryObject = [[Factory alloc] init];
    self.myArrayOfTiles = [[factoryObject createGameTiles] mutableCopy];

    [self updateLabels];
    
}

- (IBAction)buttonPressed:(UIButton *)sender {
    
    if (sender.tag == 11) {
        if (self.currentPoint.y != 4) {
            self.currentPoint = CGPointMake(self.currentPoint.x, self.currentPoint.y+1);
        }
        else {
            self.currentPoint = CGPointMake(self.currentPoint.x, 0);
        }
    }
    
    else if (sender.tag == 12) {
        if (self.currentPoint.y != 0) {
            self.currentPoint = CGPointMake(self.currentPoint.x, self.currentPoint.y-1);
        }
        else {
            self.currentPoint = CGPointMake(self.currentPoint.x, 4);
        }    }
    
    else if (sender.tag == 13) {
        if (self.currentPoint.x != 0) {
            self.currentPoint = CGPointMake(self.currentPoint.x-1, self.currentPoint.y);
        }
        else {
            self.currentPoint = CGPointMake(4, self.currentPoint.y);
        }    }
    
    else if (sender.tag == 14) {
        if (self.currentPoint.x != 4) {
            self.currentPoint = CGPointMake(self.currentPoint.x+1, self.currentPoint.y);
        }
        else {
            self.currentPoint = CGPointMake(0, self.currentPoint.y);
        }
    }
    NSLog(@"x value: %i; y value: %i", (int)self.currentPoint.x, (int)self.currentPoint.y);
    self.randomNumberLabel.text = [NSString stringWithFormat:@""];
    [self updateLabels];
    
    if (self.currentBadGuy != nil && self.currentBadGuy.isNotABadGuyButInsteadAPowerUp == false) {
        [self hideDirectionButtons];
    }

}

- (IBAction)attackButtonPressed:(UIButton *)sender {
    if (self.currentBadGuy != nil && self.currentBadGuy.isNotABadGuyButInsteadAPowerUp == false){
        int badGuyStrength = self.currentBadGuy.strength * 10;
        int chanceOfWinning = 100 - badGuyStrength/self.marioCharacter.marioStrength;
        int randomChance = arc4random_uniform(99) + 1;
        if (chanceOfWinning > randomChance) {
            
            NSLog(@"win: %i vs %i", chanceOfWinning, randomChance);
            if (self.currentBadGuy.strength == 9){
                NSLog(@"you just won");
                [self addPointToScore:(1000)];
                [self playerWon];
            }
            
            else {
                self.badGuyImage.transform = CGAffineTransformMakeScale(1, -1);
                self.badGuyImage.alpha = 0.2;
                [self addPointToScore:badGuyStrength*10];
                int xValue = self.currentPoint.x;
                int yValue = self.currentPoint.y;
                TileObject *newTile = [[TileObject alloc] init];
                newTile.thisTilesBadGuy = nil;
                [[self.myArrayOfTiles objectAtIndex:xValue] replaceObjectAtIndex:yValue withObject:newTile];
                self.currentBadGuy = nil;
                [self showDirectionButtons];
                [self checkWhichActionButtonsToHide];
                self.randomNumberLabel.text = [NSString stringWithFormat:@"victory!"];

            }
        }
        
        else {
            NSLog(@"LOST!: %i vs %i", chanceOfWinning, randomChance);
            if (self.marioCharacter.marioStrength == 1){
                self.marioCharacter.marioStrength = 0;
                self.marioCharacter.marioImage = [UIImage imageNamed:@"mario0.jpg"];
                [self updateLabels];
                self.randomNumberLabel.text = [NSString stringWithFormat:@""];
                self.playAgainButton.hidden = false;
            }
            
            else {
                self.marioCharacter.marioStrength = 1;
                self.marioCharacter.marioImage = [UIImage imageNamed:@"mario1.jpg"];
                [self updateLabels];
                self.randomNumberLabel.text = [NSString stringWithFormat:@"mama mia!"];
            }
            
        }
    }
    
}

- (IBAction)runButtonPressed:(UIButton *)sender {
    if (self.currentBadGuy != nil && self.currentBadGuy.isNotABadGuyButInsteadAPowerUp == false){
        int badGuyStrength = self.currentBadGuy.strength * 5;
        int chanceOfWinning = 100 - badGuyStrength/self.marioCharacter.marioStrength;
        int randomChance = arc4random_uniform(99) + 1;
        if (chanceOfWinning > randomChance) {
            NSLog(@"Ran away: %i vs %i", chanceOfWinning, randomChance);
            self.randomNumberLabel.text = @"Got away..";
            self.badGuyImage.alpha = 0;
            [self showDirectionButtons];
            self.attackButton.hidden = true;
            self.runButton.hidden = true;
        }
        
        else {
            NSLog(@"TRAPPED!: %i vs %i", chanceOfWinning, randomChance);
            self.randomNumberLabel.text = @"Trapped!";
            self.runButton.hidden = true;
        }
    }
}

- (IBAction)getItemButtonPressed:(UIButton *)sender {
    // first check to make sure there is an item to take
    int xValue = self.currentPoint.x;
    int yValue = self.currentPoint.y;
    NSArray *currentColumn = self.myArrayOfTiles[xValue];
    TileObject *currentTile = currentColumn[yValue];
    
    // here's instructions for mushrooms. copy and paste this for other items
    if (currentTile.thisTilesBadGuy.isNotABadGuyButInsteadAPowerUp && currentTile.thisTilesBadGuy.isNotABadGuyButInsteadAMushroom){
        
        // then change mario's strength and image
        self.marioCharacter.marioStrength = 2;
        self.marioCharacter.marioImage = [UIImage imageNamed:@"mario2.jpg"];
        
        // then set the item to nil, and remove it's image from the screen
        sender.hidden = true;
        TileObject *newTile = [[TileObject alloc] init];
        newTile.thisTilesBadGuy = nil;
        [[self.myArrayOfTiles objectAtIndex:xValue] replaceObjectAtIndex:yValue withObject:newTile];
        
        [self updateLabels];
        
    }
    
    else if (currentTile.thisTilesBadGuy.isNotABadGuyButInsteadAPowerUp && currentTile.thisTilesBadGuy.isNotABadGuyButInsteadAFlower){
        
        // then change mario's strength and image
        self.marioCharacter.marioStrength = 3;
        self.marioCharacter.marioImage = [UIImage imageNamed:@"mario3.jpg"];
        
        // then set the item to nil, and remove it's image from the screen
        sender.hidden = true;
        TileObject *newTile = [[TileObject alloc] init];
        newTile.thisTilesBadGuy = nil;
        [[self.myArrayOfTiles objectAtIndex:xValue] replaceObjectAtIndex:yValue withObject:newTile];
        
        [self updateLabels];
        
    }


}

- (void) updateLabels {
    int xValue = self.currentPoint.x;
    int yValue = self.currentPoint.y;
    NSArray *currentColumn = self.myArrayOfTiles[xValue];
    TileObject *currentTile = currentColumn[yValue];
    self.currentBadGuy = currentTile.thisTilesBadGuy;
    self.badGuyImage.image = self.currentBadGuy.badGuyImage;
    self.badGuyImage.transform = CGAffineTransformMakeScale(1, 1);
    self.badGuyImage.alpha = 1;
    
    self.marioImage.image = self.marioCharacter.marioImage;
    
    if (currentTile.thisTilesBadGuy == nil){
        self.randomNumberLabel.text = [NSString stringWithFormat:@""];
    }
    
    else if (currentTile.thisTilesBadGuy.isNotABadGuyButInsteadAPowerUp == true) {
        self.randomNumberLabel.text = [NSString stringWithFormat:@"get item?"];
    }
    
    [self checkWhichActionButtonsToHide];
    
}

- (void) showDirectionButtons {
    for (int i = 0; i < self.directionButtons.count; i++){
        UIButton *thisButton = self.directionButtons[i];
        thisButton.hidden = false
        ;
    }
}

- (void) hideDirectionButtons {
    for (int i = 0; i < self.directionButtons.count; i++){
        UIButton *thisButton = self.directionButtons[i];
        thisButton.hidden = true;
    }
}

- (void) checkWhichActionButtonsToHide {
    if (self.marioCharacter.marioStrength == 0) {
        self.attackButton.hidden = true;
        self.runButton.hidden = true;
        self.getItemButton.hidden = true;
    }
    
    else if (self.currentBadGuy.isNotABadGuyButInsteadAPowerUp == true){
        self.attackButton.hidden = true;
        self.runButton.hidden = true;
        self.getItemButton.hidden = false;
    }
    
    else if (self.currentBadGuy == nil) {
        self.attackButton.hidden = true;
        self.runButton.hidden = true;
        self.getItemButton.hidden = true;
    }
    
    else {
        self.attackButton.hidden = false;
        self.runButton.hidden = false;
        self.getItemButton.hidden = true;
    }
    
    if (self.currentBadGuy.isNotABadGuyButInsteadAPowerUp){
        self.randomNumberLabel.text = [NSString stringWithFormat:@"Take item?"];
    }
}

- (IBAction)playAgainPressed:(UIButton *)sender {
    self.marioCharacter = [[Mario alloc] init];
    self.marioImage.image = self.marioCharacter.marioImage;
    
    self.currentPoint = CGPointMake(2, 2);
    self.scoreOfGame = 0;
    
    Factory *factoryObject = [[Factory alloc] init];
    self.myArrayOfTiles = [[factoryObject createGameTiles] mutableCopy];
    
    [self showDirectionButtons];
    self.playAgainButton.hidden = true;
    [self updateLabels];
    self.marioScoreLabel.text = @"000000";
}

- (void) playerWon {
    self.attackButton.hidden = true;
    self.runButton.hidden = true;
    [UIView animateWithDuration:8 animations:^{
        self.badGuyImage.alpha = 0;
        self.randomNumberLabel.alpha = 0;
    }];
    [UIView animateWithDuration:8 animations:^{
        self.badGuyImage.image = [UIImage imageNamed:@"princess.jpg"];
        self.badGuyImage.alpha = 1;
        self.randomNumberLabel.text = @"Thank you Mario!";
        self.randomNumberLabel.alpha = 1;
    }
                     completion:^(BOOL finished) {
                         self.playAgainButton.hidden = false;
                         UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"YOU WON!" message:nil delegate:nil cancelButtonTitle:@"yay!" otherButtonTitles: nil];
                         [myAlert show];
 }];
    
}

- (void) addPointToScore: (int) enemyStrength {
    self.scoreOfGame += enemyStrength;
    NSString *properFormattingOfScore = @"";
    if (self.scoreOfGame < 1000) {
        properFormattingOfScore = [NSString stringWithFormat:@"000%i", self.scoreOfGame];
    }
    else if (self.scoreOfGame < 10000){
        properFormattingOfScore = [NSString stringWithFormat:@"00%i", self.scoreOfGame];
    }
    else{
        properFormattingOfScore = [NSString stringWithFormat:@"0%i", self.scoreOfGame];
    }
    self.marioScoreLabel.text = properFormattingOfScore;
    
}

@end
