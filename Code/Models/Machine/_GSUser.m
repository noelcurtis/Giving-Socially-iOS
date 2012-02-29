// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GSUser.m instead.

#import "_GSUser.h"

const struct GSUserAttributes GSUserAttributes = {
	.authToken = @"authToken",
	.email = @"email",
	.facebookToken = @"facebookToken",
	.firstName = @"firstName",
	.lastName = @"lastName",
	.username = @"username",
};

const struct GSUserRelationships GSUserRelationships = {
	.friends = @"friends",
};

const struct GSUserFetchedProperties GSUserFetchedProperties = {
};

@implementation GSUserID
@end

@implementation _GSUser

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"GSUser" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"GSUser";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"GSUser" inManagedObjectContext:moc_];
}

- (GSUserID*)objectID {
	return (GSUserID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic authToken;






@dynamic email;






@dynamic facebookToken;






@dynamic firstName;






@dynamic lastName;






@dynamic username;






@dynamic friends;

	
- (NSMutableSet*)friendsSet {
	[self willAccessValueForKey:@"friends"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"friends"];
  
	[self didAccessValueForKey:@"friends"];
	return result;
}
	





@end
