//
//  SKStackManager.m
//  Stacks
//
//  Created by John Boiles on 7/18/14.
//  Copyright (c) 2014 Stacks. All rights reserved.
//

#import "SKStackManager.h"
#import "SKStack.h"


@interface SKStackManager () <NSURLConnectionDelegate>

@property (strong, nonatomic) NSMutableData *URLData;
@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSArray *stacks;

@end


@implementation SKStackManager

@synthesize currentStack=_currentStack;

+ (SKStackManager *)sharedStackManager
{
    static SKStackManager *SharedStackManager = nil;
    if (!SharedStackManager) {
        SharedStackManager = [[SKStackManager alloc] init];
    }
    return SharedStackManager;
}

+ (NSURL *)host
{
    return [SKStackManager sharedStackManager].currentStack.URL;
}

+ (NSString *)hostString
{
    return [SKStackManager sharedStackManager].currentStack.URLString;
}

- (void)reloadStacks
{
    [self.connection cancel];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://stackotron-discover.herokuapp.com/v1/apps/%@/stacks", self.appId]]];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];    
}

- (NSString *)userDefaultsStorageKey
{
    return [NSString stringWithFormat:@"Stacks-CurrentStack-%@", self.appId];
}

- (void)setCurrentStack:(SKStack *)currentStack
{
    _currentStack = currentStack;
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:currentStack] forKey:[self userDefaultsStorageKey]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (SKStack *)currentStack
{
    if (!_currentStack) {
        _currentStack = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:[self userDefaultsStorageKey]]];
    }
    return _currentStack;
}

#pragma mark NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.URLData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.URLData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error = nil;
    NSArray *stackDictionaryArray = [NSJSONSerialization JSONObjectWithData:self.URLData options:0 error:&error];
    if (error) {
        [self.delegate stackManager:self didError:error];
    } else {
        NSMutableArray *stacks = [[NSMutableArray alloc] init];
        for (NSDictionary *stackDictionary in stackDictionaryArray) {
            SKStack *stack = [[SKStack alloc] initWithJSONDictionary:stackDictionary];
            [stacks addObject:stack];
        }
        self.stacks = [NSArray arrayWithArray:stacks];
        [self.delegate stackManager:self didLoadStacks:self.stacks];
    }
}

@end
