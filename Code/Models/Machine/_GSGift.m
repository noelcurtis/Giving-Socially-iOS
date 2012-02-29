// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GSGift.m instead.

#import "_GSGift.h"

const struct GSGiftAttributes GSGiftAttributes = {
	.amazonAffiliateURL = @"amazonAffiliateURL",
	.approximatePrice = @"approximatePrice",
	.exampleURL = @"exampleURL",
	.giftID = @"giftID",
	.name = @"name",
	.purchased = @"purchased",
};

const struct GSGiftRelationships GSGiftRelationships = {
};

const struct GSGiftFetchedProperties GSGiftFetchedProperties = {
};

@implementation GSGiftID
@end

@implementation _GSGift

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"GSGift" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"GSGift";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"GSGift" inManagedObjectContext:moc_];
}

- (GSGiftID*)objectID {
	return (GSGiftID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"approximatePriceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"approximatePrice"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"giftIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"giftID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"purchasedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"purchased"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic amazonAffiliateURL;






@dynamic approximatePrice;



- (float)approximatePriceValue {
	NSNumber *result = [self approximatePrice];
	return [result floatValue];
}

- (void)setApproximatePriceValue:(float)value_ {
	[self setApproximatePrice:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveApproximatePriceValue {
	NSNumber *result = [self primitiveApproximatePrice];
	return [result floatValue];
}

- (void)setPrimitiveApproximatePriceValue:(float)value_ {
	[self setPrimitiveApproximatePrice:[NSNumber numberWithFloat:value_]];
}





@dynamic exampleURL;






@dynamic giftID;



- (int)giftIDValue {
	NSNumber *result = [self giftID];
	return [result intValue];
}

- (void)setGiftIDValue:(int)value_ {
	[self setGiftID:[NSNumber numberWithInt:value_]];
}

- (int)primitiveGiftIDValue {
	NSNumber *result = [self primitiveGiftID];
	return [result intValue];
}

- (void)setPrimitiveGiftIDValue:(int)value_ {
	[self setPrimitiveGiftID:[NSNumber numberWithInt:value_]];
}





@dynamic name;






@dynamic purchased;



- (BOOL)purchasedValue {
	NSNumber *result = [self purchased];
	return [result boolValue];
}

- (void)setPurchasedValue:(BOOL)value_ {
	[self setPurchased:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitivePurchasedValue {
	NSNumber *result = [self primitivePurchased];
	return [result boolValue];
}

- (void)setPrimitivePurchasedValue:(BOOL)value_ {
	[self setPrimitivePurchased:[NSNumber numberWithBool:value_]];
}









@end
