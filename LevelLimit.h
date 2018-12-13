//
//  LevelLimit.h
//  Wall
//
//  Created by Matej Jan on 15.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Express.Scene.Objects.h"
#import "Express.Math.h"

#import "Retronator.SF.classes.h"

@interface LevelLimit : NSObject <IAAHalfPlaneCollider, ICustomCollider, ISceneUser> {
	AAHalfPlane *limit;
    BOOL deadly;
    id<IScene> scene;
}

- (id) initWithLimit:(AAHalfPlane*)theLimit isDeadly:(BOOL)isDeadly;


@end
