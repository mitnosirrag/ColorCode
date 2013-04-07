//
//  UserSettings.m
//  Color Code
//
//  Created by Tim Garrison on 1/27/10.
//  Copyright 2010 Implied Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreServices/CoreServices.h>
#import "UserSettings.h"


@implementation UserSettings

NSString * const APPLICATION_SUPPORT_DIRECTORY = @"~/Library/Application Support/Color Code/";
NSString * const USER_SETTINGS_FILENAME = @"userData.plist";

@synthesize filePath, sourcePath;
//@synthesize redPath, orangePath, yellowPath, greenPath, bluePath, violetPath, greyPath;
@synthesize colorDestinationPaths;

- (id) init {
    if ( self = [super init] ) {
        [self loadUserSettingsToDictionary];
        self.sourcePath = [[colorDestinationPaths objectForKey:@"SourceDirectory"] stringByExpandingTildeInPath];
    }
    return self;
}

+ (NSString *)pathForSettingsFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *folder = APPLICATION_SUPPORT_DIRECTORY;
    folder = [folder stringByExpandingTildeInPath];
    NSString *fileName = USER_SETTINGS_FILENAME;
    fileName = [NSString stringWithFormat:@"%@/%@",
                folder,
                USER_SETTINGS_FILENAME];
    if ( NO == [fileManager fileExistsAtPath: folder] ) {
        [fileManager createDirectoryAtPath: folder attributes:nil errors:nil];
    }
    if ( NO == [fileManager fileExistsAtPath:fileName] ) {
        [UserSettings copyDefaultsToUserSettings];
    }
    
    return fileName;
}

+ (BOOL)copyDefaultsToUserSettings {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    
    NSString *fileName = [[NSString stringWithFormat:@"%@%@", 
                           APPLICATION_SUPPORT_DIRECTORY,
                           USER_SETTINGS_FILENAME] stringByExpandingTildeInPath];
    NSString *defaultFileName = [[NSBundle mainBundle] pathForResource:@"UserDefaults" 
                                                                    ofType:@"plist"];
    // if the file already exists, we need to delete it
    if ( NO != [fileManager fileExistsAtPath:fileName] ) {
        if ( ![fileManager removeItemAtPath:fileName error:&error] ) {
            NSLog(@"Error (001): %@", error);
            return NO;
        }
    }
    // copy the default plist to the application support directory
    if ( ![fileManager copyItemAtPath:defaultFileName toPath:fileName error:&error] ) {
        NSLog(@"Error (002): %@", error);
        return NO;
    }
    return YES;
}

- (void)setUserPreferencesKeyValue:(NSString *)key value:(NSString *)value {
    [self.colorDestinationPaths setObject:value forKey:key];
}

- (void)writePreferencesToPlist {
    [self.colorDestinationPaths writeToFile:[UserSettings pathForSettingsFile] atomically:YES];
}

- (void)loadUserSettingsToDictionary {
    self.colorDestinationPaths = [[NSMutableDictionary alloc] 
                                  initWithContentsOfFile:[UserSettings pathForSettingsFile]];
}
    
- (int)addToLoginItems {
    NSBundle *appBundle = [NSBundle bundleWithIdentifier:@"com.productofdivorce.colorcode"];
    NSString *pathToApp = [appBundle bundlePath];

    OSStatus status;
    CFURLRef URLToToggle = (CFURLRef)[NSURL fileURLWithPath:pathToApp];
    LSSharedFileListItemRef existingItem = NULL;
   	LSSharedFileListRef loginItems = LSSharedFileListCreate(kCFAllocatorDefault, kLSSharedFileListSessionLoginItems, /*options*/ NULL);
    
    UInt32 seed = 0U;
    NSArray *currentLoginItems = [NSMakeCollectable(LSSharedFileListCopySnapshot(loginItems, &seed)) autorelease];
    for (id itemObject in currentLoginItems) {
        LSSharedFileListItemRef item = (LSSharedFileListItemRef)itemObject;
        
        UInt32 resolutionFlags = kLSSharedFileListNoUserInteraction | kLSSharedFileListDoNotMountVolumes;
        CFURLRef URL = NULL;
        OSStatus err = LSSharedFileListItemResolve(item, resolutionFlags, &URL, NULL);
        if ( err == noErr ) {
            Boolean foundIt = CFEqual(URL, URLToToggle);
            CFRelease(URL);
            
            if ( foundIt ) {
                existingItem = item;
                return 0; // already in place
            }
        }
    }
    
    if ( NULL == existingItem ) {
        NSString *displayName = [[NSFileManager defaultManager] displayNameAtPath:pathToApp];
        IconRef icon = NULL;
        FSRef ref;
        Boolean gotRef = CFURLGetFSRef(URLToToggle, &ref);
        if ( gotRef ) {
            status = GetIconRefFromFileInfo(&ref, 0, NULL,kFSCatInfoNone, NULL,kIconServicesNormalUsageFlag, &icon, NULL);
            if ( noErr != status ) {
                icon = NULL;
            }
        }
        
        LSSharedFileListInsertItemURL(loginItems, kLSSharedFileListItemBeforeFirst, (CFStringRef)displayName, icon, URLToToggle, NULL, NULL);
    } else if ( NULL != existingItem ) {
        // this isnt good
        return 2; // app fails to add to login items
    }
                
    return 1; // app now a login item
}
    

@end
