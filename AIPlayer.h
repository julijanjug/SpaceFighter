//
//  AIPlayer.h
//  SpaceFighter
//
//  Created by Julijan Jug on 09/12/2018.
//
#import <Foundation/Foundation.h>

#import "Retronator.Xni.Framework.Input.Touch.h"
#import "Express.Scene.h"

#import "Retronator.SF.classes.h"

@interface AIPlayer : GameComponent {
    Ufo *ufo;
    Level *level;
    
    // AI player properties
    float speed; 
    float attackSpeed;
    
    @private
    BOOL attack;
    Vector2 *target;
}

- (id) initWithGame:(Game*)theGame ufo:(Ufo*)theUfo level:(Level*)theLevel;

@property (nonatomic, readonly) Level *level;
@property (nonatomic, readonly) Vector2 *target;

- (void) updateWithGameTime:(GameTime*)gameTime;

// Percepts
- (NSArray*) getDefenseDangers;
- (NSArray*) getOffenseWeaknesses;

// Actions
- (void) moveTowards:(Vector2*)theTarget;
- (void) attackTowards:(Vector2*)theTarget;
- (void) shootTowards:(Vector2*)theTarget;

@end
