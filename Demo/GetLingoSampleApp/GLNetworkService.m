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

NSString *getLingoApiBasicUrl = @"https://getlingo.herokuapp.com/api/apps";
NSString *getLingoApiTranslationsUrl = @"http://www.getlingo.io/api/apps/";

/**
 *  API Path : https://getlingo.herokuapp.com/api/apps/
 *  Params : [
 *               "Authorization"  - the app key
 *           ]
 */
+ (void) fetchStringsForAppKey:(NSString *)apiKey withAppId:(NSString *)appId withCompletion:(void (^)(NSDictionary *stringDictionary, NSError *error))completion
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", getLingoApiBasicUrl, appId]; //TODO
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"Get Lingo translation url: %@", url);
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
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        
        if(error || jsonError)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error ? : jsonError);
            });
            return;
        }
        
        NSArray *arrayOfStringObjects = json[@"app"][@"localized_strings"];
        
        NSMutableDictionary *dicOfStrings = [[NSMutableDictionary alloc] init];
        for(NSDictionary *dic in arrayOfStringObjects){
            GLStringObject *newString = [[GLStringObject alloc] initWithDictionary:dic];
            [dicOfStrings setValue:newString forKey:newString.key];
        }
        NSDictionary *returnDictionary = [[NSDictionary alloc] initWithDictionary:dicOfStrings];
        dispatch_sync(dispatch_get_main_queue(), ^{
            completion(returnDictionary, nil);
        });
        
    }];
    [task resume];

}

+ (void) fetchStringsForLanguageCode:(NSString *)langCode withAppKey:(NSString *)apiKey withAppId:(NSString *)appId withCompletion:(void (^)(NSDictionary *stringDictionary, NSError *error))completion
{   
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/translations?%@%@", getLingoApiTranslationsUrl, appId, @"language_code=", langCode]];
    NSLog(@"Get Lingo url: %@", url);
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
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        
        if(error || jsonError)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error ? : jsonError);
            });
            return;
        }
        
        NSArray *arrayOfStringObjects = json[@"translations"];
        
        NSMutableDictionary *dicOfStrings = [[NSMutableDictionary alloc] init];
        for(NSDictionary *dic in arrayOfStringObjects){
            GLStringObject *newString = [[GLStringObject alloc] initWithDictionary:dic];
            
            [dicOfStrings setValue:newString forKey:newString.key];
        }
        NSDictionary *returnDictionary = [[NSDictionary alloc] initWithDictionary:dicOfStrings];
        dispatch_sync(dispatch_get_main_queue(), ^{
            completion(returnDictionary, nil);
        });
        
    }];
    [task resume];

}
@end
