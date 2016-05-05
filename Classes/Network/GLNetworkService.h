//
//  GLNetworkService.h
//  GetLingoSampleApp
//
//  Created by Sebastian Ljungberg on 15/02/16.
//  Copyright © 2016 Xeppen Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLNetworkService : NSObject

+ (void) fetchStringsForAppKey:(NSString *)apiKey withAppId:(NSString *)appId withCompletion:(void (^)(NSDictionary *stringDictionary, NSError *error))completion;

+ (void) fetchStringsForLanguageCode:(NSString *)langCode withAppKey:(NSString *)apiKey withAppId:(NSString *)appId withCompletion:(void (^)(NSDictionary *stringDictionary, NSError *error))completion;

@end
