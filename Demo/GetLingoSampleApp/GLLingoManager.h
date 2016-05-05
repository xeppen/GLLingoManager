//
//  GLLingoManager.h
//  GetLingoSampleApp
//
//  Created by Sebastian Ljungberg on 15/02/16.
//  Copyright © 2016 Xeppen Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLLingoManager : NSObject

+ (instancetype) sharedManager;

-(NSString *) getLocalizedStringForKey: (NSString *)key withDefault: (NSString *)defaultString;

-(void) fetch;

-(void)setApiKey:(NSString *)apiKey andAppId:(NSString *)appId andPreferedLanguage:(NSString *) languageCode;

// Macro
#define GLLocalizationString(key, default) [[GLLingoManager sharedManager] getLocalizedStringForKey:key withDefault:default]

@end
