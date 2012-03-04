// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GSUser.h instead.

#import <CoreData/CoreData.h>


extern const struct GSUserAttributes {
	 NSString *authToken;
	 NSString *email;
	 NSString *facebookToken;
	 NSString *facebookTokenExpiationDate;
	 NSString *firstName;
	 NSString *lastName;
	 NSString *username;
} GSUserAttributes;

extern const struct GSUserRelationships {
	 NSString *friends;
} GSUserRelationships;

extern const struct GSUserFetchedProperties {
} GSUserFetchedProperties;

@class GSUser;









@interface GSUserID : NSManagedObjectID {}
@end

@interface _GSUser : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (GSUserID*)objectID;




@property (nonatomic, retain) NSString *authToken;


//- (BOOL)validateAuthToken:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *email;


//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *facebookToken;


//- (BOOL)validateFacebookToken:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSDate *facebookTokenExpiationDate;


//- (BOOL)validateFacebookTokenExpiationDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *firstName;


//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *lastName;


//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *username;


//- (BOOL)validateUsername:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSSet* friends;

- (NSMutableSet*)friendsSet;





@end

@interface _GSUser (CoreDataGeneratedAccessors)

- (void)addFriends:(NSSet*)value_;
- (void)removeFriends:(NSSet*)value_;
- (void)addFriendsObject:(GSUser*)value_;
- (void)removeFriendsObject:(GSUser*)value_;

@end

@interface _GSUser (CoreDataGeneratedPrimitiveAccessors)


- (NSString *)primitiveAuthToken;
- (void)setPrimitiveAuthToken:(NSString *)value;




- (NSString *)primitiveEmail;
- (void)setPrimitiveEmail:(NSString *)value;




- (NSString *)primitiveFacebookToken;
- (void)setPrimitiveFacebookToken:(NSString *)value;




- (NSDate *)primitiveFacebookTokenExpiationDate;
- (void)setPrimitiveFacebookTokenExpiationDate:(NSDate *)value;




- (NSString *)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString *)value;




- (NSString *)primitiveLastName;
- (void)setPrimitiveLastName:(NSString *)value;




- (NSString *)primitiveUsername;
- (void)setPrimitiveUsername:(NSString *)value;





- (NSMutableSet*)primitiveFriends;
- (void)setPrimitiveFriends:(NSMutableSet*)value;


@end
