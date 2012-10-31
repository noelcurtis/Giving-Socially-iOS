//
//  GSNetworkManager.h
//  GivingSocially
//
//  Created by Scott on 10/24/12.
//  Copyright (c) 2012 Giving Socially. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

typedef void(^GSPhotoRequestCompletionHandler)(UIImage *image, NSError *error);
typedef void(^GSRequestCompletionHandler)(RKMappingResult *mappingResult, NSError *error);

@interface GSNetworkManager : NSObject

+ (GSNetworkManager *)sharedManager;

- (NSOperation *)loginWithParameters:(NSDictionary *)parameters completionHandler:(GSRequestCompletionHandler)completionHandler;

@end
