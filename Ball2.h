//
//  Ball.h
//  SF
//
//  Created by Julijan Jug on 15.11.18.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Express.Scene.Objects.h"

#import "Retronator.SF.classes.h"

@interface Ball2 : NSObject <IParticle, ICustomCollider> {
    Vector2 *position;
    Vector2 *velocity;
    float radius;
    float mass;
}

@end
