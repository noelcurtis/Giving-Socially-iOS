// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GSUser.m instead.

#import "_GSUser.h"

const struct GSUserAttributes GSUserAttributes = {
	.authToken = @"authToken",
	.email = @"email",
	.facebookToken = @"facebookToken",
	.facebookTokenExpirationDate = @"facebookTokenExpirationDate",
	.firstName = @"firstName",
	.lastName = @"lastName",
	.username = @"username",
};

const struct GSUserRelationships GSUserRelationships = {
};

const struct GSUserFetchedProperties GSUserFetchedProperties = {
};

@implementation GSUserID
@end

@implementation _GSUser

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"User";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"User" inManagedObjectContext:moc_];
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






@dynamic facebookTokenExpirationDate;






@dynamic firstName;






@dynamic lastName;






@dynamic username;











@end
