// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GSActivity.h instead.

#import <CoreData/CoreData.h>


extern const struct GSActivityAttributes {
	__unsafe_unretained NSString *activityID;
	__unsafe_unretained NSString *friendlyDescription;
} GSActivityAttributes;

extern const struct GSActivityRelationships {
	__unsafe_unretained NSString *gift;
	__unsafe_unretained NSString *giftList;
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




@property (nonatomic, strong) NSNumber* activityID;


@property int32_t activityIDValue;
- (int32_t)activityIDValue;
- (void)setActivityIDValue:(int32_t)value_;

//- (BOOL)validateActivityID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* friendlyDescription;


//- (BOOL)validateFriendlyDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) GSGift* gift;

//- (BOOL)validateGift:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) GSGiftList* giftList;

//- (BOOL)validateGiftList:(id*)value_ error:(NSError**)error_;





@end

@interface _GSActivity (CoreDataGeneratedAccessors)

@end

@interface _GSActivity (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveActivityID;
- (void)setPrimitiveActivityID:(NSNumber*)value;

- (int32_t)primitiveActivityIDValue;
- (void)setPrimitiveActivityIDValue:(int32_t)value_;




- (NSString*)primitiveFriendlyDescription;
- (void)setPrimitiveFriendlyDescription:(NSString*)value;





- (GSGift*)primitiveGift;
- (void)setPrimitiveGift:(GSGift*)value;



- (GSGiftList*)primitiveGiftList;
- (void)setPrimitiveGiftList:(GSGiftList*)value;


@end
