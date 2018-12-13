//
//  Physics.h
//  Wall
//
//  Created by Matej Jan on 15.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Retronator.SF.classes.h"

@interface Physics : GameComponent {
	Level *level;
}

- (id) initWithGame:(Game*)theGame level:(Level*)theLevel;

@end
