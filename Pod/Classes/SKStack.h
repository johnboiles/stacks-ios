//
//  SKStack.h
//  Stacks
//
//  Created by John Boiles on 7/18/14.
//  Copyright (c) 2014 Stacks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKStack : NSObject

@property (readonly, strong, nonatomic) NSString *id;
@property (readonly, strong, nonatomic) NSString *appId;
@property (readonly, strong, nonatomic) NSString *group;
@property (readonly, strong, nonatomic) NSString *name;
@property (readonly, strong, nonatomic) NSString *URLString;
@property (readonly, strong, nonatomic) NSURL *URL;

- (id)initWithJSONDictionary:(NSDictionary *)JSONDictionary;

@end
