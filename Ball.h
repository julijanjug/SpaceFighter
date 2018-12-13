//
//  Ball.h
//  Wall
//
//  Created by Matej Jan on 15.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Express.Scene.Objects.h"

#import "Retronator.SF.classes.h"

@interface Ball : NSObject <IParticle, ICustomCollider> {
	Vector2 *position;
	Vector2 *velocity;
	float radius;
	float mass;
}

@end
