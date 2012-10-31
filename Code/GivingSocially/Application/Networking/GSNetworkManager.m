//
//  GSNetworkManager.m
//  GivingSocially
//
//  Created by Scott on 10/24/12.
//  Copyright (c) 2012 Giving Socially. All rights reserved.
//

#import "GSNetworkManager.h"

#import "GSMappingProvider.h"
#import "GSUser.h"

@interface GSNetworkManager ()

@property (nonatomic, weak) AFHTTPClient *client;
@property (nonatomic, weak) RKObjectManager *objectManager;

@end

@implementation GSNetworkManager

+ (GSNetworkManager *)sharedManager
{
    static GSNetworkManager *gs_sharedNetworkManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gs_sharedNetworkManager = [[self alloc] init];
    });
    return gs_sharedNetworkManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        RKLogConfigureByName("RestKit/Network*", RKLogLevelTrace);
        RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
        
        // let AFNetworking manage the activity indicator
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        // Initialize HTTPClient
        NSURL *baseURL = [NSURL URLWithString:kGSBaseURL];
        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
        //we want to work with JSON-Data
        [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
        _client = client;
        
        // Initialize RestKit        
        RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
        _objectManager = objectManager;
        
        // Core Data
        NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
        RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
        _objectManager.managedObjectStore = managedObjectStore;

        [managedObjectStore createPersistentStoreCoordinator];
        NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"GSDataModel.sqlite"];
        NSLog(@"Database path: %@", storePath);
        NSError *error;
        NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:&error];
        NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
        
        // Create the managed object contexts
        [managedObjectStore createManagedObjectContexts];
        
        // Configure a managed object cache to ensure we do not create duplicate objects
        managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
        
        // Setup the mappings
        GSMappingProvider *mappingProvider = [GSMappingProvider mappingProviderWithStore:managedObjectStore];
        [objectManager addResponseDescriptorsFromArray:mappingProvider.descriptors];
    }
    return self;
}

#pragma mark - Auth

- (NSOperation *)loginWithParameters:(NSDictionary *)parameters completionHandler:(GSRequestCompletionHandler)completionHandler
{
    NSMutableURLRequest *request = [self.objectManager requestWithObject:nil method:RKRequestMethodPOST path:@"users/sign_in" parameters:parameters];

    RKManagedObjectRequestOperation *operation = [[RKManagedObjectRequestOperation alloc] initWithRequest:request responseDescriptors:self.objectManager.responseDescriptors];
    operation.managedObjectContext = self.objectManager.managedObjectStore.mainQueueManagedObjectContext;
    operation.managedObjectCache = self.objectManager.managedObjectStore.managedObjectCache;
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        if (completionHandler) completionHandler(mappingResult, nil);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (completionHandler) completionHandler(nil, error);
    }];
    [self.objectManager enqueueObjectRequestOperation:operation];
    
    return operation;
}

- (NSOperation *)loadPhotoURL:(NSURL *)URL imageProcessingHandler:(UIImage *(^)(UIImage *))imageProcessingHandler completionHandler:(GSPhotoRequestCompletionHandler)completionHandler
{
    NSMutableURLRequest *imageRequest = [NSMutableURLRequest requestWithURL:URL];
    [imageRequest setHTTPShouldHandleCookies:NO];
    [imageRequest setHTTPShouldUsePipelining:YES];
    [imageRequest addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    AFImageRequestOperation *imageRequestOperation = [AFImageRequestOperation imageRequestOperationWithRequest:imageRequest imageProcessingBlock:imageProcessingHandler success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        if (completionHandler) completionHandler(image, nil);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        if (completionHandler) completionHandler(nil, error);
    }];
    [self.client enqueueHTTPRequestOperation:imageRequestOperation];
    return imageRequestOperation;
}

@end
