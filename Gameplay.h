//
//  Gameplay.h
//  Wall
//
//  Created by Matej Jan on 15.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Express.Graphics.h"
#import "Retronator.SF.classes.h"

@interface Gameplay : GameComponent {
	Level *level;
	Player *player;
    NSArray *ufos;
	Physics *physics;
	Renderer *renderer;	
	DebugRenderer *debugRenderer;
	
	int lives;
    int livesShow;
	int difficultyLevel;
}

@property (nonatomic, readonly) Level *level;
@property (nonatomic) int lives;
@property (nonatomic) int livesShow;


- (void) reset;

- (float) calculateCrrentBallSpeed;

- (id) initWithGame:(Game *)theGame aiClass:(Class)aiClass;

@end
