// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GSGift.h instead.

#import <CoreData/CoreData.h>


extern const struct GSGiftAttributes {
	 NSString *amazonAffiliateURL;
	 NSString *approximatePrice;
	 NSString *exampleURL;
	 NSString *giftID;
	 NSString *name;
	 NSString *purchased;
} GSGiftAttributes;

extern const struct GSGiftRelationships {
} GSGiftRelationships;

extern const struct GSGiftFetchedProperties {
} GSGiftFetchedProperties;









@interface GSGiftID : NSManagedObjectID {}
@end

@interface _GSGift : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (GSGiftID*)objectID;




@property (nonatomic, retain) NSString *amazonAffiliateURL;


//- (BOOL)validateAmazonAffiliateURL:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *approximatePrice;


@property float approximatePriceValue;
- (float)approximatePriceValue;
- (void)setApproximatePriceValue:(float)value_;

//- (BOOL)validateApproximatePrice:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *exampleURL;


//- (BOOL)validateExampleURL:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *giftID;


@property int32_t giftIDValue;
- (int32_t)giftIDValue;
- (void)setGiftIDValue:(int32_t)value_;

//- (BOOL)validateGiftID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *purchased;


@property BOOL purchasedValue;
- (BOOL)purchasedValue;
- (void)setPurchasedValue:(BOOL)value_;

//- (BOOL)validatePurchased:(id*)value_ error:(NSError**)error_;






@end

@interface _GSGift (CoreDataGeneratedAccessors)

@end

@interface _GSGift (CoreDataGeneratedPrimitiveAccessors)


- (NSString *)primitiveAmazonAffiliateURL;
- (void)setPrimitiveAmazonAffiliateURL:(NSString *)value;




- (NSNumber *)primitiveApproximatePrice;
- (void)setPrimitiveApproximatePrice:(NSNumber *)value;

- (float)primitiveApproximatePriceValue;
- (void)setPrimitiveApproximatePriceValue:(float)value_;




- (NSString *)primitiveExampleURL;
- (void)setPrimitiveExampleURL:(NSString *)value;




- (NSNumber *)primitiveGiftID;
- (void)setPrimitiveGiftID:(NSNumber *)value;

- (int32_t)primitiveGiftIDValue;
- (void)setPrimitiveGiftIDValue:(int32_t)value_;




- (NSString *)primitiveName;
- (void)setPrimitiveName:(NSString *)value;




- (NSNumber *)primitivePurchased;
- (void)setPrimitivePurchased:(NSNumber *)value;

- (BOOL)primitivePurchasedValue;
- (void)setPrimitivePurchasedValue:(BOOL)value_;




@end
