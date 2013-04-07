//
//  UserSettings.h
//  Color Code
//
//  Created by Tim Garrison on 1/27/10.
//  Copyright 2010 Implied Solutions. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const APPLICATION_SUPPORT_DIRECTORY;
extern NSString * const USER_SETTINGS_FILENAME;

@interface UserSettings : NSObject {
    
    NSString *filePath, *sourcePath;
    NSMutableDictionary *colorDestinationPaths;
}

@property (retain) NSString *filePath, *sourcePath;
@property (retain) NSMutableDictionary *colorDestinationPaths;

+ (NSString *)pathForSettingsFile;
+ (BOOL)copyDefaultsToUserSettings;

- (int)addToLoginItems;
- (void)loadUserSettingsToDictionary;
- (void)setUserPreferencesKeyValue:(NSString *)key value:(NSString *)value;
- (void)writePreferencesToPlist;


@end
