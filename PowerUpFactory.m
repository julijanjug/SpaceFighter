//
//  PowerUpFactory.m
//  SpaceFighter
//
//  Created by Julijan Jug on 24/11/2018.
//
#import "PowerUpFactory.h"

#import "Retronator.SF.h"

@implementation PowerUpFactory

static Class powerUpClasses[PowerUpTypes];
static int frequency[PowerUpTypes];
static int totalFrequency;
static PowerUpType randomTypeLookup[100];

+ (void) initialize {
    powerUpClasses[PowerUpTypeShield] = [ShieldPowerUp class];
    powerUpClasses[PowerUpTypeHP] = [HPPowerUp class];
    powerUpClasses[PowerUpTypeDeath] = [DeathPowerUp class];
    powerUpClasses[PowerUpTypeMultiBall] = [MultiBallPowerUp class];
    
    frequency[PowerUpTypeShield] = 1;
    frequency[PowerUpTypeHP] = 1;
    frequency[PowerUpTypeDeath] = 1;
    frequency[PowerUpTypeMultiBall] = 1;
    
    totalFrequency = 0;
    for (int i = 0; i < PowerUpTypes; i++) {
        for (int j = 0; j < frequency[i]; j++) {
            randomTypeLookup[totalFrequency] = i;
            totalFrequency++;
        }
    }
}

+ (PowerUp*) createPowerUp:(PowerUpType)type {
    return [[[powerUpClasses[type] alloc] init] autorelease];
}

+ (PowerUp*) createRandomPowerUp {
    int index = [Random intLessThan:totalFrequency];
    PowerUpType type = randomTypeLookup[index];
    return [PowerUpFactory createPowerUp:type];
}

@end
