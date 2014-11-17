//
//  JLUnitOfWork.h
//  UnitOfWorkTest
//
//  Created by Mandea Daniel on 13/11/14.
//  Copyright (c) 2014 Mandea Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JLUnitOfWork;

@protocol JLUnitOfWorkDelegate <NSObject>

- (void)unitOfWorkPerformedWithSuccess:(JLUnitOfWork *)unitOfWork;

@end

@interface JLUnitOfWork : NSObject

/**
 *  Init unit of work with multiple operations
 *
 *  @param operations an array that contanins all the operations that need to be performed
 *
 *  @return an instance of JLUnitOfWork object
 */
- (instancetype)initWithOperations:(NSArray *)operations;

/**
 *  This method adds all the operations on a given queue
 *
 *  @param currentOperationQueue the queue that will hold all operations
 */
- (void)performUnitOfWork;

/**
 *  Set operations for Unit Of Work
 *
 *  @param operations all operations that need to be done
 */
- (void)setUnitOfWorkOperations:(NSArray *)operations;

@property (nonatomic, strong) NSString *unitOfWorkID;
@property (nonatomic, strong) NSArray *operations;
@property (nonatomic, weak) id <JLUnitOfWorkDelegate> delegate;

@end
