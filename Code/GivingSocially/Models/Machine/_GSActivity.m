// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GSActivity.m instead.

#import "_GSActivity.h"

const struct GSActivityAttributes GSActivityAttributes = {
	.activityID = @"activityID",
	.friendlyDescription = @"friendlyDescription",
};

const struct GSActivityRelationships GSActivityRelationships = {
	.gift = @"gift",
	.giftList = @"giftList",
};

const struct GSActivityFetchedProperties GSActivityFetchedProperties = {
};

@implementation GSActivityID
@end

@implementation _GSActivity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Activity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Activity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Activity" inManagedObjectContext:moc_];
}

- (GSActivityID*)objectID {
	return (GSActivityID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"activityIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"activityID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic activityID;



- (int32_t)activityIDValue {
	NSNumber *result = [self activityID];
	return [result intValue];
}

- (void)setActivityIDValue:(int32_t)value_ {
	[self setActivityID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveActivityIDValue {
	NSNumber *result = [self primitiveActivityID];
	return [result intValue];
}

- (void)setPrimitiveActivityIDValue:(int32_t)value_ {
	[self setPrimitiveActivityID:[NSNumber numberWithInt:value_]];
}





@dynamic friendlyDescription;






@dynamic gift;

	

@dynamic giftList;

	






@end
