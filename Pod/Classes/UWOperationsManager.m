//
//  JLOperationsManager.m
//  UnitOfWorkTest
//
//  Created by Mandea Daniel on 13/11/14.
//  Copyright (c) 2014 Mandea Daniel. All rights reserved.
//

#import "UWOperationsManager.h"

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
}

- (UWUnitOfWork *)newUnitOfWorkOfType:(UWUnitOFWorkType)unitOfWorkType {
    UWUnitOfWork *unitOfWirk ;
    
    switch (unitOfWorkType) {
        case UWUnitOfWorkTypeDefault:
          unitOfWirk = [[UWUnitOfWork alloc] initWithType:UWUnitOfWorkTypeDefault];
            break;
            
        case UWUnitOfWorkTypeCoreData:
            unitOfWirk = [[UWUnitOfWork alloc] initWithType:UWUnitOfWorkTypeCoreData];
            break;
            
        case UWUnitOfWorkTypeHTTP:
            unitOfWirk = [[UWUnitOfWork alloc] initWithType:UWUnitOfWorkTypeHTTP];
            break;
            
        case UWUnitOFWorkTypeMQTT:
            unitOfWirk = [[UWUnitOfWork alloc] initWithType:UWUnitOFWorkTypeMQTT];
            break;
    }
    return unitOfWirk;
}

#pragma mark - UnitOfWorkResponse

- (void)setMQTTResponseForUnitOfWork:(id)response {
    NSString *unitOfWorkID = [response objectForKey:@"ReplyToID"];
    for (UWUnitOfWork *unitOfWork in self.unitsOfWork) {
        if ([unitOfWork.unitOfWorkID isEqualToString:unitOfWorkID]) {
            [unitOfWork setUnitOfWorkResponse:response];
            [self.unitsOfWork removeObject:self.unitsOfWork];
        }
    }
}

#pragma mark - JLUnitOfWorkDelegate

- (void)unitOfWorkPerformedWithSuccess:(UWUnitOfWork *)unitOfWork {
    [self.unitsOfWork addObject:unitOfWork];
}

// TODO Check at some interval if there are some units of work that are not done 

@end
