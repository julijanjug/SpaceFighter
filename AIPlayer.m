//
//  AIPlayer.m
//  SpaceFighter
//
//  Created by Julijan Jug on 09/12/2018.
//

#import "AIPlayer.h"

#import "Retronator.SF.h"

@interface AIPlayer ()

- (void) moveTowards:(Vector2 *)theTarget attack:(BOOL)isAttack;

@end


@implementation AIPlayer

- (id) initWithGame:(Game *)theGame ufo:(Ufo *)theUfo level:(Level *)theLevel
{
    if (self != nil) {
        level = theLevel;
        ufo = theUfo;
    }
    return self;
}

@synthesize level, target;

// Percepts
- (NSArray *) getDefenseDangers {
    NSMutableArray *defenseDangers = [NSMutableArray array];
    
    for(id item in level.scene){
        if([item isKindOfClass:[Ball class]]) {
            Ball *metek = item;
            Vector2 *difference = [Vector2 subtract:metek.position by:ufo.position];
            float distanceDanger = [difference length];
            
            float danger = 500 - distanceDanger; //treba nastavit večje je bolj je nevarnost zadetka
            if (danger < 0) danger = 0;
            [defenseDangers addObject:[NSNumber numberWithFloat:danger]];
        }
    }
    return defenseDangers;
}

- (NSArray*) getOffenseWeaknesses {
    NSMutableArray *offenseWeaknesses = [NSMutableArray array];
    
    for(id item in level.scene){
        if([item isKindOfClass:[Spaceship class]]) {
            Ball *spaceship = item;
            float difference = fabsf(spaceship.position.y - ufo.position.y);
            
            float weakness = difference; //manjše kot je boljše je za strel
            if (weakness < 0) weakness = 0;
            [offenseWeaknesses addObject:[NSNumber numberWithFloat:weakness]];
        }
    }
    return offenseWeaknesses;
}

// Actions
- (void) moveTowards:(Vector2 *)theTarget {
    [self moveTowards:theTarget attack:NO];
}

- (void) attackTowards:(Vector2 *)theTarget {
    [self moveTowards:theTarget attack:YES];
}

- (void) shootTwords:(Vector2*)theTarget {
    float speed = [Constants getInstance].initialBall2Speed;
    [ufo addBall2WithSpeed:speed];
}


- (void) moveTowards:(Vector2 *)theTarget attack:(BOOL)isAttack {
    [target release];
    // Make sure we don't cross the middle or go into walls.
    if (theTarget.y > 250 || theTarget.x < 30 || theTarget.x > 290) {   //todo potrebno nastavit
        target = nil;
        return;
    }
    target = [theTarget retain];
    attack = isAttack;
    // Don't move too close to the edge.
    if (target.y < 60) {
        target.y = 60;
    }
}

// Action execution
- (void) updateWithGameTime:(GameTime *)gameTime {
    
    // Movement action.
    if (target) {
        Vector2 *difference = [Vector2 subtract:target by:ufo.position];
        float distance = [difference length];
        float maxMove = (attack ? attackSpeed : speed) * gameTime.elapsedGameTime;
        
        if (distance < maxMove) {
            [ufo.position set:target];
            [target release];
            target = nil;
        } else {
            [[difference normalize] multiplyBy:maxMove];
            [ufo.position add:difference];
        }
    }
}

- (void) dealloc
{
    [super dealloc];
}


@end
