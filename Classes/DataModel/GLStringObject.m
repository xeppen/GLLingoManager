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
    self.id = dictionary[@"id"] ? : @0;
    self.createdAt = [NSString stringWithFormat:@"%@", dictionary[@"created_at"]] ? [dateFormatter dateFromString:[NSString stringWithFormat:@"%@", dictionary[@"created_at"]]] : nil;
    self.updatedAt = [NSString stringWithFormat:@"%@", dictionary[@"updated_at"]] ? [dateFormatter dateFromString:[NSString stringWithFormat:@"%@", dictionary[@"updated_at"]]] : nil;
    self.language = dictionary[@"language"][@"name"] ? : @"";
    self.languageCode = dictionary[@"language"][@"language_code"] ? : @"";
}

- (NSString *)description
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDictionary *dict = @{
                           @"key": self.key ? : @"",
                           @"value": self.value ? : @"",
                           @"id" : [NSString stringWithFormat:@"%li",(long)self.id ? : 0],
                           @"created_at": [formatter stringFromDate:self.createdAt],
                           @"updated_at": [formatter stringFromDate:self.updatedAt],
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
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.createdAt = [aDecoder decodeObjectForKey:@"createdAt"];
        self.updatedAt = [aDecoder decodeObjectForKey:@"updatedAt"];
        self.language = [aDecoder decodeObjectForKey:@"language"];
        self.languageCode= [aDecoder decodeObjectForKey:@"languageCode"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.key forKey:@"key"];
    [aCoder encodeObject:self.value forKey:@"value"];
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.createdAt forKey:@"createdAt"];
    [aCoder encodeObject:self.updatedAt forKey:@"updatedAt"];
    [aCoder encodeObject:self.language forKey:@"language"];
    [aCoder encodeObject:self.languageCode forKey:@"languageCode"];
}

#pragma mark -

@end
