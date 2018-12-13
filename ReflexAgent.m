//
//  ReflexAgent.m
//  SpaceFighter
//
//  Created by Julijan Jug on 09/12/2018.
//
#import "ReflexAgent.h"

#import "Retronator.SF.h"

@implementation ReflexAgent

- (void) updateWithGameTime:(GameTime *)gameTime {
    [super updateWithGameTime:gameTime];
    
    // Read percepts.
    NSArray *defenseDangers = [self getDefenseDangers];
    
    // Find the largest danger.
    int defenseSpotIndex = 0;
    float defenseSpotDanger = 0;
    for (int i = 0; i < [defenseDangers count]; i++) {
        float danger = [((NSNumber*)[defenseDangers objectAtIndex:i]) floatValue];
        if (danger > defenseSpotDanger) {
            defenseSpotIndex = i;
            defenseSpotDanger = danger;
        }
    }
    
    // Calculate offense opportunity.
    
    // The closer the spaceship the less offensive you should be
    float offense = 600 - level.spaceship.position.x;
    
    // If we have no offense or if the most dangerous spot is bigger then offense, weighted with opponent's aggressivness.
    if (offense <= 0 || defenseSpotDanger > offense * attackFactor) {
        Vector2 *defenseSpot = ufo.position;
        if(ufo.position.y >= 500){ //polovici ekrana po širini da bo šel gor ali dol
            defenseSpot.y += 100;
        }else{
            defenseSpot.y -= 100;
        }
        Vector2 *offset = [[Vector2 subtract:ufo.position by:defenseSpot] normalize];
        Vector2 *defenseTarget = [Vector2 add:offset to:defenseSpot];
        
        // Perform move action.
        [self moveTowards:defenseTarget];
    } else {
        // Find the best offense spot.
        NSArray *offenseWeaknesses = [self getOffenseWeaknesses];
        int offenseSpotIndex = 0;
        float offenseSpotWeakness = 0;
        for (int i = 0; i < [offenseWeaknesses count]; i++) {
            float weakness = [((NSNumber*)[offenseWeaknesses objectAtIndex:i]) floatValue];
            if (weakness > offenseSpotWeakness * 1.05) {
                offenseSpotIndex = i;
                offenseSpotWeakness = weakness;
            }
        }
        
        Vector2 *offenseSpot = ufo.position;
        if(ufo.position.y >= 500){ //polovici ekrana po širini da bo šel gor ali dol
            offenseSpot.y += 100;
        }else{
            offenseSpot.y -= 100;
        }
        
        Vector2 *offset = [[Vector2 subtract:ufo.position by:offenseSpot] normalize];
        Vector2 *offenseTarget = [Vector2 add:offset to:offenseSpot];
        
        // Perform attack actions.
        [self shootTowards:offenseTarget];
        [self attackTowards:offenseTarget];
    }
    
    
}

@end
