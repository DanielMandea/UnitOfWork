//
//  JLUnitOfWork.h
//  UnitOfWorkTest
//
//  Created by Mandea Daniel on 13/11/14.
//  Copyright (c) 2014 Mandea Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UWUnitOfWork;

typedef enum {
    UWUnitOfWorkTypeDefault,
    UWUnitOfWorkTypeCoreData,
    UWUnitOfWorkTypeHTTP,
    UWUnitOFWorkTypeMQTT
}UWUnitOFWorkType;

@protocol UWUnitOfWorkDelegate <NSObject>

- (void)unitOfWorkPerformedWithSuccess:(UWUnitOfWork *)unitOfWork;

@end

@protocol UWUnitOfWorkMQTTDelegate <NSObject>

- (void)unitOfWork:(UWUnitOfWork *)unitOfWork receivedResponse:(NSDictionary *)response;

@end

@interface UWUnitOfWork : NSObject

@property (nonatomic, strong) NSString *unitOfWorkID;
@property (nonatomic, strong) NSArray *operations;
@property (nonatomic, weak) id <UWUnitOfWorkDelegate> delegate;
@property (nonatomic, weak) id <UWUnitOfWorkMQTTDelegate> mqttDelegate;
@property (nonatomic, assign, readonly) UWUnitOFWorkType unitOfWorkType;

/**
 *  Init unit of work with multiple operations
 *
 *  @param unitOfWorkType the type of UnitOfWork
 *
 *  @return an instance of JLUnitOfWork object
 */
- (instancetype)initWithType:(UWUnitOFWorkType)unitOfWorkType;

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

#pragma mark - MQTT 

/**
 *  Set Response the response
 *
 *  @param response an dictionary that contains the response for this UNitOfWork
 */
- (void)setUnitOfWorkResponse:(NSDictionary *)response;


@end
