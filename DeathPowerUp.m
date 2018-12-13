//
//  DeathPowerUp.m
//  SpaceFighter
//
//  Created by Julijan Jug on 24/11/2018.
//
#import "DeathPowerUp.h"

#import "Express.Scene.h"
#import "Retronator.SF.h"

@implementation DeathPowerUp

- (id) init
{
    self = [super initWithType:PowerUpTypeDeath];
    if (self != nil) {
        
    }
    return self;
}

- (void) activateWithParent:(Spaceship *)theParent {
    [super activateWithParent:theParent];
    
    // Remove all balls to trigger death.
    for (id item in scene) {
        if ([item isKindOfClass:[Spaceship class]]) {
            Spaceship *spaceship = (Spaceship*)item;
            if(spaceship.shieldPowerUp <= 0){
                spaceship.hitsCount+=2;
            }
        }
    }
}

@end
