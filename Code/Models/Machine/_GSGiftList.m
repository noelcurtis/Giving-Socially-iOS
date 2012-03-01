// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GSGiftList.m instead.

#import "_GSGiftList.h"

const struct GSGiftListAttributes GSGiftListAttributes = {
	.allGiftsPurchased = @"allGiftsPurchased",
	.dueDate = @"dueDate",
	.editableByFriends = @"editableByFriends",
	.giftListID = @"giftListID",
	.name = @"name",
	.privateList = @"privateList",
	.purpose = @"purpose",
	.starred = @"starred",
};

const struct GSGiftListRelationships GSGiftListRelationships = {
};

const struct GSGiftListFetchedProperties GSGiftListFetchedProperties = {
};

@implementation GSGiftListID
@end

@implementation _GSGiftList

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"GSGiftList" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"GSGiftList";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"GSGiftList" inManagedObjectContext:moc_];
}

- (GSGiftListID*)objectID {
	return (GSGiftListID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"allGiftsPurchasedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"allGiftsPurchased"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"editableByFriendsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"editableByFriends"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"giftListIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"giftListID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"privateListValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"privateList"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"starredValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"starred"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic allGiftsPurchased;



- (BOOL)allGiftsPurchasedValue {
	NSNumber *result = [self allGiftsPurchased];
	return [result boolValue];
}

- (void)setAllGiftsPurchasedValue:(BOOL)value_ {
	[self setAllGiftsPurchased:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveAllGiftsPurchasedValue {
	NSNumber *result = [self primitiveAllGiftsPurchased];
	return [result boolValue];
}

- (void)setPrimitiveAllGiftsPurchasedValue:(BOOL)value_ {
	[self setPrimitiveAllGiftsPurchased:[NSNumber numberWithBool:value_]];
}





@dynamic dueDate;






@dynamic editableByFriends;



- (BOOL)editableByFriendsValue {
	NSNumber *result = [self editableByFriends];
	return [result boolValue];
}

- (void)setEditableByFriendsValue:(BOOL)value_ {
	[self setEditableByFriends:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveEditableByFriendsValue {
	NSNumber *result = [self primitiveEditableByFriends];
	return [result boolValue];
}

- (void)setPrimitiveEditableByFriendsValue:(BOOL)value_ {
	[self setPrimitiveEditableByFriends:[NSNumber numberWithBool:value_]];
}





@dynamic giftListID;



- (int32_t)giftListIDValue {
	NSNumber *result = [self giftListID];
	return [result intValue];
}

- (void)setGiftListIDValue:(int32_t)value_ {
	[self setGiftListID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveGiftListIDValue {
	NSNumber *result = [self primitiveGiftListID];
	return [result intValue];
}

- (void)setPrimitiveGiftListIDValue:(int32_t)value_ {
	[self setPrimitiveGiftListID:[NSNumber numberWithInt:value_]];
}





@dynamic name;






@dynamic privateList;



- (BOOL)privateListValue {
	NSNumber *result = [self privateList];
	return [result boolValue];
}

- (void)setPrivateListValue:(BOOL)value_ {
	[self setPrivateList:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitivePrivateListValue {
	NSNumber *result = [self primitivePrivateList];
	return [result boolValue];
}

- (void)setPrimitivePrivateListValue:(BOOL)value_ {
	[self setPrimitivePrivateList:[NSNumber numberWithBool:value_]];
}





@dynamic purpose;






@dynamic starred;



- (BOOL)starredValue {
	NSNumber *result = [self starred];
	return [result boolValue];
}

- (void)setStarredValue:(BOOL)value_ {
	[self setStarred:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveStarredValue {
	NSNumber *result = [self primitiveStarred];
	return [result boolValue];
}

- (void)setPrimitiveStarredValue:(BOOL)value_ {
	[self setPrimitiveStarred:[NSNumber numberWithBool:value_]];
}










@end
