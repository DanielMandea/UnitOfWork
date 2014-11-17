//
//  JLOperationsManager.m
//  UnitOfWorkTest
//
//  Created by Mandea Daniel on 13/11/14.
//  Copyright (c) 2014 Mandea Daniel. All rights reserved.
//

#import "UWOperationsManager.h"
#import "UWUnitOfWork.h"

@interface UWOperationsManager () <UWUnitOfWorkDelegate>

@property (nonatomic, strong) NSOperationQueue *currentOperationQueue;
@property (nonatomic, strong) NSMutableArray *unitsOfWork;

@end

@implementation UWOperationsManager

+ (id)sharedManager {
    static UWOperationsManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init {
    if (self = [super init]) {
        _currentOperationQueue = [[NSOperationQueue alloc] init];
        _unitsOfWork = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - JLUnitOfWork

- (void)performUnitOfWork:(UWUnitOfWork *)unitOfWork {
    [unitOfWork performUnitOfWork];
    unitOfWork.delegate = self;
    [self.unitsOfWork addObject:unitOfWork];
}

- (UWUnitOfWork *)newUnitOfWorkOfType:(UWUnitOFWorkType)unitOfWorkType {
    UWUnitOfWork *unitOfWirk ;
    
    switch (unitOfWorkType) {
        case UWUnitOfWorkTypeDefault:
          unitOfWirk = [[UWUnitOfWork alloc] initWithOperations:@[]];
            break;
            
        case UWUnitOfWorkTypeCoreData:
            unitOfWirk = [[UWUnitOfWork alloc] initWithOperations:@[]];
            break;
            
        case UWUnitOfWorkTypeHTTP:
            unitOfWirk = [[UWUnitOfWork alloc] initWithOperations:@[]];
            break;
            
        case UWUnitOFWorkTypeMQTT:
            unitOfWirk = [[UWUnitOfWork alloc] initWithOperations:@[]];
            break;
            
        default:
            unitOfWirk = [[UWUnitOfWork alloc] initWithOperations:@[]];
            break;
    }
    
    return unitOfWirk;
}

#pragma mark - JLUnitOfWorkDelegate

- (void)unitOfWorkPerformedWithSuccess:(UWUnitOfWork *)unitOfWork {
    [self.unitsOfWork removeObject:unitOfWork];
}

// TODO Check at some interval if there are some units of work that are not done 

@end
