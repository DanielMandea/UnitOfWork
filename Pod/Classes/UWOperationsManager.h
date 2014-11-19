//
//  JLOperationsManager.h
//  UnitOfWorkTest
//
//  Created by Mandea Daniel on 13/11/14.
//  Copyright (c) 2014 Mandea Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UWUnitOfWork.h"

@interface UWOperationsManager : NSObject

@property (nonatomic, strong) NSOperationQueue *currentQueue;

/**
 *  Shared Manager
 *
 *  @return the manager
 */
+ (instancetype)sharedManager;

/**
 *  Create new UnitOfWork
 *
 *  @param unitOfWorkType the type of the unit work
 *
 *  @return returns an instance of unit of work obbject
 */
- (UWUnitOfWork *)newUnitOfWorkOfType:(UWUnitOFWorkType)unitOfWorkType;

/**
 *  Perform a unit of work
 *
 *  @param unitOfWork the UnitOfWork that will be performed
 */
- (void)performUnitOfWork:(UWUnitOfWork *)unitOfWork;

/**
 *  Set some received response
 *
 *  @param responseData data received
 */
- (void)setMQTTResponseForUnitOfWork:(id)response;

@end
