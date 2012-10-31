//
//  GVMappingProvider.m
//  GivingSocially
//
//  Created by Noel Curtis on 1/25/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "GSMappingProvider.h"
#import "GSUser.h"
#import "GSGiftList.h"
#import "GSGift.h"
#import "GSActivity.h"

static NSString * const kGSAPIMappingPrimaryKey = @"GS_JSON_PRIMARY_KEY";
static NSString * const kGSAPIMappingSerializableKey = @"GS_SERIALIZABLE_KEY";
static NSString * const kGSAPIMappingUserInfoServerKey = @"GS_JSON_SERVER_KEY";
static NSString * const kGSAPIMappingImageServerKey = @"GS_JSON_IMAGE_DATA";

@interface GSMappingProvider ()

@property (nonatomic, strong) NSDictionary *mappings;

+ (NSDictionary *)mappingsFromStore:(RKManagedObjectStore *)store;
+ (void)mapAttributesInMapping:(RKEntityMapping *)mapping entity:(NSEntityDescription *)entity;
+ (void)mapRelationshipsInMapping:(RKEntityMapping *)mapping entity:(NSEntityDescription *)entity mappings:(NSDictionary *)entityMappings;

- (void)mapSerializationsInStore:(RKManagedObjectStore *)store;

@end

@implementation GSMappingProvider

#pragma mark - Convenience Methods

+ (id)mappingProviderWithStore:(RKManagedObjectStore *)store
{
	// Build Mapping Provider
	GSMappingProvider *mappingProvider = [[self alloc] init];
	mappingProvider.mappings = [self mappingsFromStore:store];
//	[mappingProvider mapSerializationsInStore:store]; // TODO still need to figure this out
    
    NSMutableArray *descriptors = [NSMutableArray array];
	
	// Setup mappings to URL Patterns
    RKObjectMapping *userMapping = [mappingProvider mappingWithEntityName:@"User"];
    NSIndexSet *successStatusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userMapping pathPattern:@"users/sign_in" keyPath:@"user" statusCodes:successStatusCodes];
    
    [descriptors addObject:responseDescriptor];
    
//	RKObjectMapping *postMapping = [mappingProvider.mappings objectForKey:@"Post"];
//	[mappingProvider setObjectMapping:postMapping forResourcePathPattern:@"/posts/:postId"];
//	[mappingProvider setObjectMapping:postMapping forResourcePathPattern:@"/posts"];
//    
//	RKObjectMapping *commentMapping = [mappingProvider.mappings objectForKey:@"Comment"];
//	[mappingProvider setObjectMapping:commentMapping forResourcePathPattern:@"/posts/:postId/comments/:commentId"];
//	[mappingProvider setObjectMapping:commentMapping forResourcePathPattern:@"/posts/:postId/comments"];
//	
//	RKObjectMapping *friendshipMapping = [mappingProvider.mappings objectForKey:@"Friendship"];
//	[mappingProvider setObjectMapping:friendshipMapping forResourcePathPattern:@"/friendships/:friendshipId"];
//	[mappingProvider setObjectMapping:friendshipMapping forResourcePathPattern:@"/friendships"];
//    
//	RKObjectMapping *locationMapping = [mappingProvider.mappings objectForKey:@"MapEntry"];
//	[mappingProvider setObjectMapping:locationMapping forResourcePathPattern:@"/locations"];
    
    mappingProvider.descriptors = [NSArray arrayWithArray:descriptors];
	
	return mappingProvider;
}

#pragma mark - Mapping Feching

- (RKObjectMapping *)mappingWithEntityName:(NSString *)entityName
{
	return [self.mappings objectForKey:entityName];
}

#pragma mark - Mapping Provider Helpers

+ (NSDictionary *)mappingsFromStore:(RKManagedObjectStore *)store
{
	NSMutableDictionary *entityMappings = [NSMutableDictionary dictionary];
	
	// Create mappings and map attributes
	for (NSEntityDescription *entity in [store.managedObjectModel entities]) {
		RKEntityMapping *entityMapping = [RKEntityMapping mappingForEntityForName:entity.name inManagedObjectStore:store];
		[self mapAttributesInMapping:entityMapping entity:entity];
		[entityMappings setObject:entityMapping forKey:entity.name];
	}
    
	// Now that they are all created, map relationships
	for (RKEntityMapping *objectMapping in [entityMappings allValues]) {
		[self mapRelationshipsInMapping:objectMapping entity:objectMapping.entity mappings:entityMappings];
	}
	
	return entityMappings;
}

+ (void)mapAttributesInMapping:(RKEntityMapping *)mapping entity:(NSEntityDescription *)entity
{
	for (NSAttributeDescription *attribute in [[entity attributesByName] allValues]) {
		NSDictionary *userInfo = [attribute userInfo];
		if (userInfo) {
			NSString *propertyName = [attribute name];
			NSString *serverKey = [userInfo objectForKey:kGSAPIMappingUserInfoServerKey] ?: propertyName;
            
			RKAttributeMapping *attributeMapping = [RKAttributeMapping attributeMappingFromKeyPath:serverKey toKeyPath:propertyName];
			
			// check for primary key
			BOOL isPrimaryKey = [[userInfo objectForKey:kGSAPIMappingPrimaryKey] isEqualToString:@"YES"];
			if (isPrimaryKey) {
				[mapping setPrimaryKeyAttribute:propertyName];
			}
			
			[mapping addAttributeMappingsFromArray:@[attributeMapping]];
		}
	}
}

+ (void)mapRelationshipsInMapping:(RKEntityMapping *)mapping entity:(NSEntityDescription *)entity mappings:(NSDictionary *)entityMappings
{
	for (NSRelationshipDescription *relationship in [[entity relationshipsByName] allValues]) {
		NSString *relationName = relationship.name;
		NSString *serverKey = [[relationship userInfo] objectForKey:kGSAPIMappingUserInfoServerKey] ?: relationName;
		NSString *relationEntityName = relationship.destinationEntity.name;
		
		RKEntityMapping *relationMap = [entityMappings objectForKey:relationEntityName];
        
		RKRelationshipMapping *relationMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:serverKey toKeyPath:relationName withMapping:relationMap];
		[mapping addPropertyMapping:relationMapping];
	}
}

- (void)mapSerializationsInStore:(RKManagedObjectStore *)store
{
	for (NSEntityDescription *entity in [store.managedObjectModel entities]) {
		Class entityClass = NSClassFromString([entity managedObjectClassName]);
		
		RKObjectMapping *entitySerializationMapping = [RKObjectMapping mappingForClass:entityClass];
		
		for (NSAttributeDescription *attribute in [[entity attributesByName] allValues]) {
			NSDictionary *userInfo = [attribute userInfo];
			if (userInfo) {
				BOOL isSerializable = [[userInfo objectForKey:kGSAPIMappingSerializableKey] isEqualToString:@"YES"];
				if (isSerializable) {
					NSString *propertyName = [attribute name];
					NSString *serverKey = [userInfo objectForKey:kGSAPIMappingUserInfoServerKey] ?: propertyName;
                    RKAttributeMapping *attributeMapping = [RKAttributeMapping attributeMappingFromKeyPath:serverKey toKeyPath:propertyName];
                    [entitySerializationMapping addAttributeMappingsFromArray:@[attributeMapping]];
				}
			}
		}
//		[self setSerializationMapping:entitySerializationMapping forClass:entityClass];
        // TODO what to do here.
	}
}

@end
