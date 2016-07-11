//
//  GLNetworkService.h
//  GetLingoSampleApp
//
//  Created by Sebastian Ljungberg on 15/02/16.
//  Copyright © 2016 Xeppen Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLNetworkService : NSObject

+ (void) fetchStringsForLanguageCode:(NSString *)langCode withAppKey:(NSString *)apiKey withAppId:(NSString *)appId withCompletion:(void (^)(NSDictionary *stringDictionary, NSError *error))completion;

#define GLErrorCode_WrongLang 3
#define GLErrorCode_WrongStatusCode 4
#define GLErrorCode_DataNotArray 5
@end
