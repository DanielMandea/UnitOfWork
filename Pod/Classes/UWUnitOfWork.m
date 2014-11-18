//
//  JLUnitOfWork.m
//  UnitOfWorkTest
//
//  Created by Mandea Daniel on 13/11/14.
//  Copyright (c) 2014 Mandea Daniel. All rights reserved.
//

#import "UWUnitOfWork.h"
#import "UWOperationsManager.h"

@interface UWUnitOfWork ()

@property (nonatomic, strong) NSMutableArray *operationsNotPerformed;
@property (nonatomic, strong) NSOperationQueue *currentOperationQueue;

@end

@implementation UWUnitOfWork

- (instancetype)initWithType:(UWUnitOFWorkType)unitOfWorkType {
    if (self = [super init]) {
        _unitOfWorkType = unitOfWorkType;
        _unitOfWorkID = [self generateUnitOfWorkId];
        _currentOperationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)setUnitOfWorkOperations:(NSArray *)operations {
    _operations = operations;
}

#pragma mark - Helpers

- (NSString *)generateUnitOfWorkId {
    return [[NSUUID UUID] UUIDString];
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

#pragma mark - MQTT

- (void)setUnitOfWorkResponse:(NSDictionary *)response {
    if ([self.mqttDelegate respondsToSelector:@selector(unitOfWork:receivedResponse:)]) {
        [self.mqttDelegate unitOfWork:self receivedResponse:response];
    }
}

// TODO Check if all operation in UnitOf Work Are done


@end
