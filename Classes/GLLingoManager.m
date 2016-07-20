//
//  GLLingoManager.m
//  GetLingoSampleApp
//
//  Created by Sebastian Ljungberg on 15/02/16.
//  Copyright © 2016 Xeppen Productions. All rights reserved.
//

#import "GLLingoManager.h"
#import "GLNetworkService.h"
#import "GLStringObject.h"

#define PERSISTED_DICTIONARY_KEY @"GLPersistedDictionary"
#define PERSISTED_LANGUAGECODE_ARRAY_KEY @"GLPersistedLanguageCodeArray"

@interface GLLingoManager ()

@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSDictionary *stringDictionary;
@property (nonatomic, strong) NSArray *languageCodeArray;
@property (nonatomic, strong) NSString *preferedLanguageCode;

@end

@implementation GLLingoManager


+ (instancetype)sharedManager
{
    static dispatch_once_t pred;
    static GLLingoManager *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[GLLingoManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.stringDictionary = [[NSDictionary alloc] init];
    }
    return self;
}

#pragma mark - Setters

#pragma mark - Getters

#pragma mark - Actions

-(NSString *) getLocalizedStringForKey: (NSString *)key withDefault: (NSString *)defaultString
{

    GLStringObject *translationObject = [self.stringDictionary objectForKey:key];
    if(translationObject.value.length != 0)
    {
        return translationObject.value;
    }

    NSString *returnString = NSLocalizedString(key, nil);
    if(![returnString isEqualToString:key])
        return returnString;

    if(defaultString)
        return defaultString;
    return @"";

}

-(void) fetch
{
    [self fetchDataWithCompletion:^(NSDictionary *stringDictionary){
        if (stringDictionary.count != 0) {
            self.stringDictionary = stringDictionary;
            [self persistDictionary:stringDictionary forLanguageCode:[self languageCode]];
        };
    }];
}

- (void)setApiKey:(NSString *)apiKey andAppId:(NSString *)appId
{
    [self setApiKey:apiKey andAppId:appId andPreferedLanguage:@""];
}


-(void)setApiKey:(NSString *)apiKey andAppId:(NSString *)appId andPreferedLanguage:(NSString *) languageCode
{
    if(apiKey.length != 0)
    {
        self.apiKey = apiKey;
    }
    if(appId.length != 0)
    {
        self.appId = appId;
    }
    if(languageCode.length != 0)
    {
        self.preferedLanguageCode = languageCode;
    }

    if(apiKey.length != 0 && appId.length != 0)
    {
        [self fetchDictionaryOfStrings];
        [self fetch];
    }
}

#pragma mark - Private actions
-(void) fetchDictionaryOfStrings
{
    NSDictionary *persisted_dictionary = [self persistedDictionary];
    if (persisted_dictionary.count != 0) {
        self.stringDictionary = [self persistedDictionary];
    }
}

-(void) fetchDataWithCompletion:(void(^)(NSDictionary *stringDictionary)) completion
{
    if(self.apiKey)
    {
        if(self.preferedLanguageCode.length != 0)
        {
            [GLNetworkService fetchStringsForLanguageCode:self.preferedLanguageCode withAppKey:self.apiKey withAppId:self.appId withCompletion:^(NSDictionary *stringDictionary, NSError *error) {
                if(error)
                {
                    // TODO: Handle error
                    return;
                }

                // If new data is avaliable.
                if(stringDictionary.count > 0)
                {
                    self.stringDictionary = stringDictionary;
                    if(completion)
                        completion(stringDictionary);
                }

            }];
        } else {
            // Use device language
            NSString *languageCode = [self deviceLanguageCode];

            [GLNetworkService fetchStringsForLanguageCode:languageCode withAppKey:self.apiKey withAppId:self.appId withCompletion:^(NSDictionary *stringDictionary, NSError *error) {
                if(error)
                {
                    //TODO
                    return;
                }

                self.stringDictionary = stringDictionary;
                if(completion)
                    completion(stringDictionary);
            }];
        }
    } else {
    }
}

-(NSDictionary *)persistedDictionary
{
    NSString *persistedDictionaryLanguageKey = @"";
    if(self.preferedLanguageCode.length != 0){
        persistedDictionaryLanguageKey = [NSString stringWithFormat:@"%@_%@", PERSISTED_DICTIONARY_KEY, self.preferedLanguageCode];
    } else {
        persistedDictionaryLanguageKey = [NSString stringWithFormat:@"%@_%@", PERSISTED_DICTIONARY_KEY, [self deviceLanguageCode]];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:persistedDictionaryLanguageKey];
    NSDictionary *dictionary = [[NSDictionary alloc] init];
    if (encodedObject) {
        dictionary = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    }
    return dictionary;
}

-(void)persistDictionary:(NSDictionary *)dictionary forLanguageCode:(NSString *) langCode
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *persistedDictionaryLanguageKey = [NSString stringWithFormat:@"%@_%@", PERSISTED_DICTIONARY_KEY, langCode];


    if (dictionary.count == 0)
    {
        [defaults removeObjectForKey:persistedDictionaryLanguageKey];
        return;
    }


    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
    [defaults setObject:encodedObject forKey:persistedDictionaryLanguageKey];
    [defaults synchronize];
}

-(NSString *)deviceLanguageCode
{
    NSString *language = [[NSLocale preferredLanguages] firstObject];
    NSArray *stringParts = [language componentsSeparatedByString:@"-"];
    NSString *languageCode = [stringParts firstObject];
    return languageCode;
}

-(NSString *)languageCode {
    __block NSString *currentLanguageCode = [[NSString alloc] init];
    if (self.preferedLanguageCode.length != 0) {
        currentLanguageCode = self.preferedLanguageCode;
    } else {
        currentLanguageCode = [self deviceLanguageCode];
    }
    return currentLanguageCode;
}
@end
