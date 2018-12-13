//
//  PowerUp.h
//  SpaceFighter
//
//  Created by Julijan Jug on 24/11/2018.
//

#import <Foundation/Foundation.h>

#import "Retronator.SF.classes.h"
#import "Express.Scene.Objects.h"

@interface PowerUp : NSObject <IMovable, IAARectangleCollider, ICustomCollider, ICustomUpdate, ILifetime, ISceneUser> {
    Vector2 *position;
    Vector2 *velocity;
    float width;
    float height;
    PowerUpType type;
    NSTimeInterval duration;
    BOOL active;
    Spaceship *parent;
    Lifetime *lifetime;
    id<IScene> scene;
}

- (id) initWithType:(PowerUpType)theType;
- (id) initWithType:(PowerUpType)theType duration:(NSTimeInterval)theDuration;

@property (nonatomic, readonly) PowerUpType type;

- (void) activateWithParent:(Spaceship*)theParent;
- (void) deactivate;

@end
