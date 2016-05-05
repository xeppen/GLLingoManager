//
//  GLTranslationObject.h
//  GetLingoSampleApp
//
//  Created by Sebastian Ljungberg on 16/02/16.
//  Copyright © 2016 Xeppen Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLStringObject : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *languageCode;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
