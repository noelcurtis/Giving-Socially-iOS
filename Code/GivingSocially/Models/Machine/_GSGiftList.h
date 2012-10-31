// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GSGiftList.h instead.

#import <CoreData/CoreData.h>


extern const struct GSGiftListAttributes {
	__unsafe_unretained NSString *allGiftsPurchased;
	__unsafe_unretained NSString *dueDate;
	__unsafe_unretained NSString *editableByFriends;
	__unsafe_unretained NSString *giftListID;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *privateList;
	__unsafe_unretained NSString *purpose;
	__unsafe_unretained NSString *starred;
} GSGiftListAttributes;

extern const struct GSGiftListRelationships {
} GSGiftListRelationships;

extern const struct GSGiftListFetchedProperties {
} GSGiftListFetchedProperties;











@interface GSGiftListID : NSManagedObjectID {}
@end

@interface _GSGiftList : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (GSGiftListID*)objectID;




@property (nonatomic, strong) NSNumber* allGiftsPurchased;


@property BOOL allGiftsPurchasedValue;
- (BOOL)allGiftsPurchasedValue;
- (void)setAllGiftsPurchasedValue:(BOOL)value_;

//- (BOOL)validateAllGiftsPurchased:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* dueDate;


//- (BOOL)validateDueDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* editableByFriends;


@property BOOL editableByFriendsValue;
- (BOOL)editableByFriendsValue;
- (void)setEditableByFriendsValue:(BOOL)value_;

//- (BOOL)validateEditableByFriends:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* giftListID;


@property int32_t giftListIDValue;
- (int32_t)giftListIDValue;
- (void)setGiftListIDValue:(int32_t)value_;

//- (BOOL)validateGiftListID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* privateList;


@property BOOL privateListValue;
- (BOOL)privateListValue;
- (void)setPrivateListValue:(BOOL)value_;

//- (BOOL)validatePrivateList:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* purpose;


//- (BOOL)validatePurpose:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* starred;


@property BOOL starredValue;
- (BOOL)starredValue;
- (void)setStarredValue:(BOOL)value_;

//- (BOOL)validateStarred:(id*)value_ error:(NSError**)error_;






@end

@interface _GSGiftList (CoreDataGeneratedAccessors)

@end

@interface _GSGiftList (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAllGiftsPurchased;
- (void)setPrimitiveAllGiftsPurchased:(NSNumber*)value;

- (BOOL)primitiveAllGiftsPurchasedValue;
- (void)setPrimitiveAllGiftsPurchasedValue:(BOOL)value_;




- (NSDate*)primitiveDueDate;
- (void)setPrimitiveDueDate:(NSDate*)value;




- (NSNumber*)primitiveEditableByFriends;
- (void)setPrimitiveEditableByFriends:(NSNumber*)value;

- (BOOL)primitiveEditableByFriendsValue;
- (void)setPrimitiveEditableByFriendsValue:(BOOL)value_;




- (NSNumber*)primitiveGiftListID;
- (void)setPrimitiveGiftListID:(NSNumber*)value;

- (int32_t)primitiveGiftListIDValue;
- (void)setPrimitiveGiftListIDValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitivePrivateList;
- (void)setPrimitivePrivateList:(NSNumber*)value;

- (BOOL)primitivePrivateListValue;
- (void)setPrimitivePrivateListValue:(BOOL)value_;




- (NSString*)primitivePurpose;
- (void)setPrimitivePurpose:(NSString*)value;




- (NSNumber*)primitiveStarred;
- (void)setPrimitiveStarred:(NSNumber*)value;

- (BOOL)primitiveStarredValue;
- (void)setPrimitiveStarredValue:(BOOL)value_;




@end
