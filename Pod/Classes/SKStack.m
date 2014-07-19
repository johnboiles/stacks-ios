//
//  SKStack.m
//  Stacks
//
//  Created by John Boiles on 7/18/14.
//  Copyright (c) 2014 Stacks. All rights reserved.
//

#import "SKStack.h"

@interface SKStack ()

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *appId;
@property (strong, nonatomic) NSString *group;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *URLString;
@property (strong, nonatomic) NSURL *URL;

@end

@implementation SKStack

- (id)initWithJSONDictionary:(NSDictionary *)JSONDictionary
{
    self = [super init];
    if (self) {
        self.id = JSONDictionary[@"id"];
        self.appId = JSONDictionary[@"app_id"];
        self.group = JSONDictionary[@"group"];
        self.name = JSONDictionary[@"name"];
        self.URLString = JSONDictionary[@"uri"];
    }
    return self;
}

- (NSURL *)URL
{
    return [NSURL URLWithString:self.URLString];
}

#pragma mark Equality

- (NSUInteger)hash
{
    return self.id.hash ^ self.appId.hash ^ self.group.hash ^ self.name.hash ^ self.URLString.hash;
}

- (BOOL)isEqual:(id)object
{
    return ([object isKindOfClass:[SKStack class]] && [[object id] isEqual:self.id]);
}

#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    SKStack *stack = [[SKStack alloc] init];
    stack.id = [decoder decodeObjectForKey:@"id"];
    stack.appId = [decoder decodeObjectForKey:@"appId"];
    stack.group = [decoder decodeObjectForKey:@"group"];
    stack.name = [decoder decodeObjectForKey:@"name"];
    stack.URLString = [decoder decodeObjectForKey:@"URLString"];
    return stack;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.id forKey:@"id"];
    [encoder encodeObject:self.appId forKey:@"appId"];
    [encoder encodeObject:self.group forKey:@"group"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.URLString forKey:@"URLString"];
}

@end
