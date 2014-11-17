//
//  JLOperationsManager.m
//  UnitOfWorkTest
//
//  Created by Mandea Daniel on 13/11/14.
//  Copyright (c) 2014 Mandea Daniel. All rights reserved.
//

#import "JLOperationsManager.h"
#import "JLUnitOfWork.h"

@interface JLOperationsManager () <JLUnitOfWorkDelegate>

@property (nonatomic, strong) NSOperationQueue *currentOperationQueue;
@property (nonatomic, strong) NSMutableArray *unitsOfWork;

@end

@implementation JLOperationsManager

+ (id)sharedManager {
    static JLOperationsManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        _currentOperationQueue = [[NSOperationQueue alloc] init];
        _unitsOfWork = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - JLUnitOfWork

- (void)performUnitOfWork:(JLUnitOfWork *)unitOfWork {
    [unitOfWork performUnitOfWork];
    unitOfWork.delegate = self;
    [self.unitsOfWork addObject:unitOfWork];
}

- (JLUnitOfWork *)newUnitOfWorkOfType:(JLUnitOFWorkType)unitOfWorkType {
    JLUnitOfWork *unitOfWirk ;
    
    switch (unitOfWorkType) {
        case JLUnitOfWorkTypeDefault:
          unitOfWirk = [[JLUnitOfWork alloc] initWithOperations:@[]];
            break;
            
        case JLUnitOfWorkTypeCoreData:
            unitOfWirk = [[JLUnitOfWork alloc] initWithOperations:@[]];
            break;
            
        case JLUnitOfWorkTypeHTTP:
            unitOfWirk = [[JLUnitOfWork alloc] initWithOperations:@[]];
            break;
            
        case JLUnitOFWorkTypeMQTT:
            unitOfWirk = [[JLUnitOfWork alloc] initWithOperations:@[]];
            break;
            
        default:
            unitOfWirk = [[JLUnitOfWork alloc] initWithOperations:@[]];
            break;
    }
    
    return unitOfWirk;
}

#pragma mark - JLUnitOfWorkDelegate

- (void)unitOfWorkPerformedWithSuccess:(JLUnitOfWork *)unitOfWork {
    [self.unitsOfWork removeObject:unitOfWork];
}

// TODO Check at some interval if there are some units of work that are not done 

@end
