//
//  GLTranslationObject.m
//  GetLingoSampleApp
//
//  Created by Sebastian Ljungberg on 16/02/16.
//  Copyright © 2016 Xeppen Productions. All rights reserved.
//

#import "GLStringObject.h"

@implementation GLStringObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
    }
    return self;
}

- (void)setDictionary:(NSDictionary *)dictionary
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];

    self.key = [NSString stringWithFormat:@"%@", dictionary[@"localized_string"][@"key"]] ?  : @"";
    self.value = [NSString stringWithFormat:@"%@", dictionary[@"value"]] ? : @"";
    self.stringId = dictionary[@"id"] ? : @0;
    self.language = dictionary[@"language"][@"name"] ? : @"";
    self.languageCode = dictionary[@"language"][@"language_code"] ? : @"";
}

- (NSString *)description
{

    NSDictionary *dict = @{
                           @"key": self.key ? : @"",
                           @"value": self.value ? : @"",
                           @"language": self.language ? : @"",
                           @"languageCode": self.languageCode ? : @""
                           };
    return [dict description];
}

#pragma mark - NSCoding

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if (self)
    {
        //Set dictionary first so that it does not trigger a reset of all the fields
        self.key = [aDecoder decodeObjectForKey:@"key"];
        self.value = [aDecoder decodeObjectForKey:@"value"];
        self.stringId = [aDecoder decodeObjectForKey:@"id"];
        self.language = [aDecoder decodeObjectForKey:@"language"];
        self.languageCode= [aDecoder decodeObjectForKey:@"languageCode"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.key forKey:@"key"];
    [aCoder encodeObject:self.value forKey:@"value"];
    [aCoder encodeObject:self.stringId forKey:@"id"];
    [aCoder encodeObject:self.language forKey:@"language"];
    [aCoder encodeObject:self.languageCode forKey:@"languageCode"];
}

#pragma mark -

@end
