//
//  JLOperationsManager.h
//  UnitOfWorkTest
//
//  Created by Mandea Daniel on 13/11/14.
//  Copyright (c) 2014 Mandea Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JLUnitOfWork;

typedef enum {
    JLUnitOfWorkTypeDefault,
    JLUnitOfWorkTypeCoreData,
    JLUnitOfWorkTypeHTTP,
    JLUnitOFWorkTypeMQTT
}JLUnitOFWorkType;

@interface JLOperationsManager : NSObject

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
- (JLUnitOfWork *)newUnitOfWorkOfType:(JLUnitOFWorkType)unitOfWorkType;

/**
 *  Perform a unit of work
 *
 *  @param unitOfWork the UnitOfWork that will be performed
 */
- (void)performUnitOfWork:(JLUnitOfWork *)unitOfWork;



@end
