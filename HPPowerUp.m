//
//  HPPowerUp.m
//  SpaceFighter
//
//  Created by Julijan Jug on 24/11/2018.
//
#import "HPPowerUp.h"

#import "Express.Scene.h"
#import "Retronator.SF.h"

@implementation HPPowerUp

- (id) init
{
    self = [super initWithType:PowerUpTypeHP];
    if (self != nil) {
        
    }
    return self;
}

- (void) activateWithParent:(Spaceship *)theParent {
    [super activateWithParent:theParent];
    
    // Add 1 extra life
    for (id item in scene) {
        if ([item isKindOfClass:[Spaceship class]]) {
            Spaceship *spaceship = (Spaceship*)item;
            spaceship.hitsCount-=2;
        }
    }
}

@end
