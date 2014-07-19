//
//  SKStackManager.h
//  Stacks
//
//  Created by John Boiles on 7/18/14.
//  Copyright (c) 2014 Stacks. All rights reserved.
//

#import <Foundation/Foundation.h>


@class SKStackManager;
@class SKStack;


@protocol SKStackManagerDelegate <NSObject>

- (void)stackManager:(SKStackManager *)stackManager didLoadStacks:(NSArray */*of Stack*/)stacks;
- (void)stackManager:(SKStackManager *)stackManager didError:(NSError *)error;

@end


@interface SKStackManager : NSObject

// TODO: Allow for multiple delegates in SKStackManager (see: http://stackoverflow.com/questions/9336288/nsarray-of-weak-references-to-objects-under-arc)
@property (weak, nonatomic) id<SKStackManagerDelegate> delegate;
@property (strong, nonatomic) NSString *appId;
@property (strong, nonatomic) SKStack *currentStack;

+ (SKStackManager *)sharedStackManager;

+ (NSString *)hostString;

- (void)reloadStacks;

@end
