//
//  GLNetworkService.m
//  GetLingoSampleApp
//
//  Created by Sebastian Ljungberg on 15/02/16.
//  Copyright © 2016 Xeppen Productions. All rights reserved.
//

#import "GLNetworkService.h"
#import "GLStringObject.h"

@implementation GLNetworkService

NSString *getLingoApiTranslationsUrl = @"https://www.getlingo.io/api/apps";
NSString *timestampLastFetchKey = @"GL_LAST_FETCH_KEY";

/**
 *  API Path : https://www.getlingo.io/api/apps
 *  Params : [
 *               "Authorization"  - the app key
 *           ]
 */

+ (void) fetchStringsForLanguageCode:(NSString *)langCode withAppKey:(NSString *)apiKey withAppId:(NSString *)appId withCompletion:(void (^)(NSDictionary *stringDictionary, NSError *error))completion
{
    // Get last timestamp a fetch was made
    __block NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger timestampInSeconds = 0;
    if([[[prefs dictionaryRepresentation] allKeys] containsObject:timestampLastFetchKey]){
        NSDate *timestampLastFetch = [prefs objectForKey:timestampLastFetchKey];
        timestampInSeconds = [timestampLastFetch timeIntervalSince1970];
    }

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/translations?%@%@&from_date=%li", getLingoApiTranslationsUrl, appId, @"language_code=", langCode, (long)timestampInSeconds]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    [request setHTTPMethod:@"GET"];

    //TODO: Maybe use a specifically configured session for Login operations with its own neat setup methods encapsulated somewhere?
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfiguration setHTTPAdditionalHeaders:@{
                                                     @"Authorization": apiKey
                                                     }
     ];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];

    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
            return;
        }

        NSError *jsonError;
        NSDictionary *jsonData  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];

        if(error || jsonError)
        {
            if (![NSThread isMainThread]) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    completion(nil, error ? : jsonError);
                    return;
                });
            } else {
                completion(nil, error ? : jsonError);
                return;
            }
        }

        // Check for errors
        if([jsonData[@"errors"] isKindOfClass:[NSArray class]])
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                completion(nil, [NSError errorWithDomain:@"io.getlingo" code:GLErrorCode_WrongLang userInfo:[NSDictionary dictionaryWithObject:@"Wrong data type received from server" forKey:NSLocalizedDescriptionKey]]);
            });
            return;
        }

        if(![jsonData[@"data"] isKindOfClass:[NSArray class]])
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                completion(nil, [NSError errorWithDomain:@"io.getlingo" code:GLErrorCode_DataNotArray userInfo:[NSDictionary dictionaryWithObject:@"Wrong data type received from server" forKey:NSLocalizedDescriptionKey]]);
            });
            return;
        }

        // Save timestamp
        [prefs setObject:[NSDate date] forKey:timestampLastFetchKey];

        // Check meta
        NSNumber *status = jsonData[@"meta"][@"status"];

        if(![status isEqualToNumber:@1] && ![status isEqualToNumber:@2])
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                completion(nil, [NSError errorWithDomain:@"io.getlingo" code:GLErrorCode_WrongStatusCode userInfo:[NSDictionary dictionaryWithObject:@"Wrong status code recieved from server" forKey:NSLocalizedDescriptionKey]]);
            });
            return;
        }

        // Updated version is avaliable
        if ([status isEqualToNumber:@1])
        {
            NSArray *arrayOfDictionaries = jsonData[@"data"];
            NSMutableDictionary *dicOfStringObjects = [[NSMutableDictionary alloc] init];
            for(NSDictionary *dic in arrayOfDictionaries){
                GLStringObject *newString = [[GLStringObject alloc] initWithDictionary:dic];
                [dicOfStringObjects setValue:newString forKey:newString.key];
            }
            NSDictionary *returnDictionary = [[NSDictionary alloc] initWithDictionary:dicOfStringObjects];
            dispatch_sync(dispatch_get_main_queue(), ^{
                completion(returnDictionary, nil);
            });
            return;
        }

        // No new data available, returning empty dictionary
        if ([status isEqualToNumber:@2])
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                completion(@{}, nil);
            });
            return;
        }
    }];
    [task resume];

}
@end
