//
//  JLUnitOfWork.m
//  UnitOfWorkTest
//
//  Created by Mandea Daniel on 13/11/14.
//  Copyright (c) 2014 Mandea Daniel. All rights reserved.
//

#import "JLUnitOfWork.h"
#import "JLOperationsManager.h"

@interface JLUnitOfWork ()

@property (nonatomic, strong) NSMutableArray *operationsNotPerformed;
@property (nonatomic, strong) NSOperationQueue *currentOperationQueue;

@end

@implementation JLUnitOfWork

- (instancetype)initWithOperations:(NSArray *)operations {
    if (self = [super init]) {
        _operations = operations;
        _unitOfWorkID = [self generateUnitOfWorkId];
        _currentOperationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)setUnitOfWorkOperations:(NSArray *)operations {
    _operations = operations;
}

#pragma mark - Run Operations

- (void)performUnitOfWork {
    NSArray *opeationsToperform;
    if (self.operationsNotPerformed.count) {
        opeationsToperform = self.operationsNotPerformed;
    } else {
        opeationsToperform = self.operations;
    }
    for (NSOperation *operation in opeationsToperform) {
        [self.currentOperationQueue addOperation:operation];
        NSInvocationOperation *doneOp = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operationDone:) object:operation];
        [doneOp addDependency:operation];
        [self.currentOperationQueue addOperation:doneOp];
        // save operations for current unit of work
        [self.operationsNotPerformed addObject:operation];
    }
}

- (void)operationDone:(NSOperation *)operation {
    [self.operationsNotPerformed removeObject:operation];
    if (!self.operationsNotPerformed.count && [self.delegate respondsToSelector:@selector(unitOfWorkPerformedWithSuccess:)]) {
        [self.delegate unitOfWorkPerformedWithSuccess:self];
    }
}

// Check if all operation in UnitOf Work Are done
#pragma mark - Helpers

- (NSString *)generateUnitOfWorkId {
    return @"SomeID";
}

@end
