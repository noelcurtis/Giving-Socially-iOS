// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GSUser.h instead.

#import <CoreData/CoreData.h>


extern const struct GSUserAttributes {
	__unsafe_unretained NSString *authToken;
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *facebookToken;
	__unsafe_unretained NSString *facebookTokenExpirationDate;
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *lastName;
	__unsafe_unretained NSString *username;
} GSUserAttributes;

extern const struct GSUserRelationships {
} GSUserRelationships;

extern const struct GSUserFetchedProperties {
} GSUserFetchedProperties;










@interface GSUserID : NSManagedObjectID {}
@end

@interface _GSUser : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (GSUserID*)objectID;




@property (nonatomic, strong) NSString* authToken;


//- (BOOL)validateAuthToken:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* email;


//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* facebookToken;


//- (BOOL)validateFacebookToken:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* facebookTokenExpirationDate;


//- (BOOL)validateFacebookTokenExpirationDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* firstName;


//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* lastName;


//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* username;


//- (BOOL)validateUsername:(id*)value_ error:(NSError**)error_;






@end

@interface _GSUser (CoreDataGeneratedAccessors)

@end

@interface _GSUser (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAuthToken;
- (void)setPrimitiveAuthToken:(NSString*)value;




- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




- (NSString*)primitiveFacebookToken;
- (void)setPrimitiveFacebookToken:(NSString*)value;




- (NSDate*)primitiveFacebookTokenExpirationDate;
- (void)setPrimitiveFacebookTokenExpirationDate:(NSDate*)value;




- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;




- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;




- (NSString*)primitiveUsername;
- (void)setPrimitiveUsername:(NSString*)value;




@end
