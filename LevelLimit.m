//
//  LevelLimit.m
//  Wall
//
//  Created by Matej Jan on 15.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "LevelLimit.h"

#import "Retronator.SF.h"

@implementation LevelLimit

- (id) initWithLimit:(AAHalfPlane *)theLimit isDeadly:(BOOL)isDeadly
{
    self = [super init];
    if (self != nil) {
        limit = [theLimit retain];
        deadly = isDeadly;
    }
    return self;
}

@synthesize scene;

- (AAHalfPlane *) aaHalfPlane {
    return limit;
}

- (HalfPlane *) halfPlane {
    return limit;
}

- (BOOL) collidingWithItem:(id)item {
    if (deadly) {
        if([item isKindOfClass:[Ball class]] || [item isKindOfClass:[Ball2 class]]){
            [scene removeItem:item];
        }
    }
    
    return !deadly;
}

- (void) dealloc
{
    [scene release];
    [limit release];
    [super dealloc];
}

@end
