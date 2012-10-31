//
//  GVMappingProvider.h
//  GivingSocially
//
//  Created by Noel Curtis on 1/25/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import <RestKit/RestKit.h>

@interface GSMappingProvider : NSObject

@property (nonatomic, strong) NSArray *descriptors;

/**
 * Convenience method to load mapping provider with mappings
 * @param store instance of class RKManagedObjectStore
 * @return RGHTMappingProvider
 */
+ (id)mappingProviderWithStore:(RKManagedObjectStore *)store;

/**
 * Build mappings for entities in store
 * @param entityName Name of the entity to obtain mappings for
 * @return RKObjectMapping
 */
- (RKObjectMapping *)mappingWithEntityName:(NSString *)entityName;

@end
