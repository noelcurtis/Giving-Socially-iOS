// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GSActivity.h instead.

#import <CoreData/CoreData.h>


extern const struct GSActivityAttributes {
	 NSString *activityID;
	 NSString *friendlyDescription;
} GSActivityAttributes;

extern const struct GSActivityRelationships {
	 NSString *gift;
	 NSString *giftList;
} GSActivityRelationships;

extern const struct GSActivityFetchedProperties {
} GSActivityFetchedProperties;

@class GSGift;
@class GSGiftList;




@interface GSActivityID : NSManagedObjectID {}
@end

@interface _GSActivity : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (GSActivityID*)objectID;




@property (nonatomic, retain) NSNumber *activityID;


@property int32_t activityIDValue;
- (int32_t)activityIDValue;
- (void)setActivityIDValue:(int32_t)value_;

//- (BOOL)validateActivityID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *friendlyDescription;


//- (BOOL)validateFriendlyDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) GSGift* gift;

//- (BOOL)validateGift:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) GSGiftList* giftList;

//- (BOOL)validateGiftList:(id*)value_ error:(NSError**)error_;





@end

@interface _GSActivity (CoreDataGeneratedAccessors)

@end

@interface _GSActivity (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber *)primitiveActivityID;
- (void)setPrimitiveActivityID:(NSNumber *)value;

- (int32_t)primitiveActivityIDValue;
- (void)setPrimitiveActivityIDValue:(int32_t)value_;




- (NSString *)primitiveFriendlyDescription;
- (void)setPrimitiveFriendlyDescription:(NSString *)value;





- (GSGift*)primitiveGift;
- (void)setPrimitiveGift:(GSGift*)value;



- (GSGiftList*)primitiveGiftList;
- (void)setPrimitiveGiftList:(GSGiftList*)value;


@end
