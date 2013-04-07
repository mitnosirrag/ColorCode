//
//  ColorCode.m
//  Color Code
//
//  Created by Tim Garrison on 1/2/10.
//  Copyright 2010 Implied Solutions. All rights reserved.
//

#import "ColorCode.h"
#import <Foundation/Foundation.h>
#import <CoreServices/CoreServices.h>
#import "UserSettings.h"

@implementation ColorCode

/* 
 these defaults should PROBABLY be set from the UserDefaults.plist file, but 
 i already had them in place and it didnt seem like it was worth the hassle to 
 to make such a big change
 */
NSString * const DEFAULT_SOURCE_PATH = @"~/Desktop/ColorCode";

NSString * const DEFAULT_DESTINATION_DIRECTORY_RED    = @"~/Documents/ColorCode/Red";
NSString * const DEFAULT_DESTINATION_DIRECTORY_ORANGE = @"~/Documents/ColorCode/Orange";
NSString * const DEFAULT_DESTINATION_DIRECTORY_YELLOW = @"~/Documents/ColorCode/Yellow";
NSString * const DEFAULT_DESTINATION_DIRECTORY_GREEN  = @"~/Documents/ColorCode/Green";
NSString * const DEFAULT_DESTINATION_DIRECTORY_BLUE   = @"~/Documents/ColorCode/Blue";
NSString * const DEFAULT_DESTINATION_DIRECTORY_VIOLET = @"~/Documents/ColorCode/Violet";
NSString * const DEFAULT_DESTINATION_DIRECTORY_GREY   = @"~/Documents/ColorCode/Grey";

@synthesize globalErrorFlag;
@synthesize sourcePath;
@synthesize colorCodeDictionary, destinationDictionary;
@synthesize DO_NOT_MOVE_COLOR_LABEL;

- (id) init {
	if ( self = [super init] ) {
		self.globalErrorFlag = nil;
		self.DO_NOT_MOVE_COLOR_LABEL = [NSNumber numberWithUnsignedInt:0];
		self.colorCodeDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
									[NSNumber numberWithUnsignedShort:6], @"DESTINATION_DIRECTORY_RED_INT",
									[NSNumber numberWithUnsignedShort:7], @"DESTINATION_DIRECTORY_ORANGE_INT",
									[NSNumber numberWithUnsignedShort:5], @"DESTINATION_DIRECTORY_YELLOW_INT",
									[NSNumber numberWithUnsignedShort:2], @"DESTINATION_DIRECTORY_GREEN_INT",
									[NSNumber numberWithUnsignedShort:4], @"DESTINATION_DIRECTORY_BLUE_INT",
									[NSNumber numberWithUnsignedShort:3], @"DESTINATION_DIRECTORY_VIOLET_INT",
									[NSNumber numberWithUnsignedShort:1], @"DESTINATION_DIRECTORY_GREY_INT",
									nil];
	}
	return self;
}

- (void) dealloc {
	self.sourcePath = nil;
	self.colorCodeDictionary = nil;
	[super dealloc];
}

- (void) chooseDestinations {
    
	NSString *userSetRed = nil, *userSetOrange = nil, *userSetYellow = nil, *userSetGreen = nil, *userSetBlue = nil, 
		*userSetViolet = nil, *userSetGrey = nil;
    
    UserSettings *userSettings = [[UserSettings alloc] init];
    NSMutableDictionary *colorDestinationPaths = [userSettings colorDestinationPaths];
    
    userSetRed    = [[colorDestinationPaths objectForKey:@"DestinationDirectoryRed"] stringByExpandingTildeInPath];
    userSetOrange = [[colorDestinationPaths objectForKey:@"DestinationDirectoryOrange"] stringByExpandingTildeInPath];
    userSetYellow = [[colorDestinationPaths objectForKey:@"DestinationDirectoryYellow"] stringByExpandingTildeInPath];
    userSetGreen  = [[colorDestinationPaths objectForKey:@"DestinationDirectoryGreen"] stringByExpandingTildeInPath];
    userSetBlue   = [[colorDestinationPaths objectForKey:@"DestinationDirectoryBlue"] stringByExpandingTildeInPath];
    userSetViolet = [[colorDestinationPaths objectForKey:@"DestinationDirectoryViolet"] stringByExpandingTildeInPath];
    userSetGrey   = [[colorDestinationPaths objectForKey:@"DestinationDirectoryGrey"] stringByExpandingTildeInPath];

	NSString *red    = (0 == [userSetRed length])    ? [DEFAULT_DESTINATION_DIRECTORY_RED stringByExpandingTildeInPath]    : userSetRed;
	NSString *orange = (0 == [userSetOrange length]) ? [DEFAULT_DESTINATION_DIRECTORY_ORANGE stringByExpandingTildeInPath] : userSetOrange;
	NSString *yellow = (0 == [userSetYellow length]) ? [DEFAULT_DESTINATION_DIRECTORY_YELLOW stringByExpandingTildeInPath] : userSetYellow;
	NSString *green  = (0 == [userSetGreen length])  ? [DEFAULT_DESTINATION_DIRECTORY_GREEN stringByExpandingTildeInPath]  : userSetGreen;
	NSString *blue   = (0 == [userSetBlue length])   ? [DEFAULT_DESTINATION_DIRECTORY_BLUE stringByExpandingTildeInPath]   : userSetBlue;
	NSString *violet = (0 == [userSetViolet length]) ? [DEFAULT_DESTINATION_DIRECTORY_VIOLET stringByExpandingTildeInPath] : userSetViolet;
	NSString *grey   = (0 == [userSetGrey length])   ? [DEFAULT_DESTINATION_DIRECTORY_GREY stringByExpandingTildeInPath]   : userSetGrey;
    
	self.destinationDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
								  red,    [colorCodeDictionary objectForKey:@"DESTINATION_DIRECTORY_RED_INT"],
								  orange, [colorCodeDictionary objectForKey:@"DESTINATION_DIRECTORY_ORANGE_INT"],
								  yellow, [colorCodeDictionary objectForKey:@"DESTINATION_DIRECTORY_YELLOW_INT"],
								  green,  [colorCodeDictionary objectForKey:@"DESTINATION_DIRECTORY_GREEN_INT"],
								  blue,   [colorCodeDictionary objectForKey:@"DESTINATION_DIRECTORY_BLUE_INT"],
								  violet, [colorCodeDictionary objectForKey:@"DESTINATION_DIRECTORY_VIOLET_INT"],
								  grey,   [colorCodeDictionary objectForKey:@"DESTINATION_DIRECTORY_GREY_INT"],
								  nil];	
/*	NSLog(@"%@",self.destinationDictionary);*/
}

- (void) moveFilesFromSourceDirectoryToDestinationDirectoriesByColor {
	NSError *error = nil;
    NSString *humanReadableError = nil;
    UserSettings *userSettings = [[UserSettings alloc] init];
    self.sourcePath            = [userSettings sourcePath];
    [self chooseDestinations];
    //NSLog(@"destinations are: \"%@\"",self.destinationDictionary);
	NSArray *directoryContents = [[NSFileManager defaultManager]
								  contentsOfDirectoryAtPath:self.sourcePath error:&error];
//    NSLog(@"The contents we will be moving are: \"%@\"", directoryContents);
	if ( nil != error ) {
		NSLog(@"Error: Directory \"%@\" does not exist", self.sourcePath);
/*		self.globalErrorFlag = YES; */
	} else {
		for ( int i = 0; i < [directoryContents count]; i++ ) {
			NSString *currentIndex     = [directoryContents objectAtIndex:i];
			NSString *currentIndexPath = [NSString stringWithFormat:@"%@/%@",
										  self.sourcePath, currentIndex];
/*			NSLog(@"%@", currentIndexPath);*/

			CFStringRef currentIndexPathRef           = (CFStringRef) currentIndexPath;
			MDItemRef   currentIndexPathItem          = MDItemCreate(kCFAllocatorDefault, currentIndexPathRef);
			CFTypeRef   currentIndexPathColorLabelRef = MDItemCopyAttribute(currentIndexPathItem,kMDItemFSLabel);
			NSNumber    *currentIndexPathColorLabel   = (NSNumber*) currentIndexPathColorLabelRef;
/*			NSLog(@"Color code is: %@", currentIndexPathColorLabel);*/
			
			if ( ![currentIndexPathColorLabel isEqualToNumber:DO_NOT_MOVE_COLOR_LABEL] ) {
				NSString *currentIndexDestinationPath = [self.destinationDictionary objectForKey:currentIndexPathColorLabel];
                
                /* does the destination directory exist? if not, we need to create it */
                if ( ![[NSFileManager defaultManager] fileExistsAtPath:currentIndexDestinationPath] ) {
                    NSLog(@"Destination folder: \"%@\" does not exist, I will create it", currentIndexDestinationPath);
                    [[NSFileManager defaultManager] createDirectoryAtPath:currentIndexDestinationPath withIntermediateDirectories:YES attributes:nil error:&error];
                }
                
/*				NSLog(@"The color is: %i", currentIndexPathColorLabel);
				NSLog(@"The destination for \"%@\" will be \"%@\"", currentIndexPath, 
					  [self.destinationDictionary objectForKey:currentIndexPathColorLabel]);*/
                
                /* does the file we are trying to move even exist? */
				currentIndexDestinationPath = [NSString stringWithFormat:@"%@/%@",
                                               currentIndexDestinationPath,currentIndex];
				if ( ![[NSFileManager defaultManager] isReadableFileAtPath:currentIndexPath] ) {
                    humanReadableError = [NSString stringWithFormat:@"The directory: \"%@\" does not exist", currentIndexPath];
					NSLog(@"\"%@\" does not exist", currentIndexPath);
				} else if ( [[NSFileManager defaultManager] isReadableFileAtPath:currentIndexDestinationPath] ) {
                    /* 
                     does something already exist where we are trying to put this? 
                     someday i will add the ability to overwrite or prompt, but for now
                     we dont move anything 
                     */
                    humanReadableError = [NSString stringWithFormat:@"\"%@\" already exists", currentIndexDestinationPath];
					NSLog(@"\"%@\" already exists, will not move source to destination", currentIndexDestinationPath);
				} else {
					NSLog(@"Moved: \"%@\" - To: \"%@\"", currentIndexPath, currentIndexDestinationPath);
					[[NSFileManager defaultManager] moveItemAtPath:currentIndexPath
															toPath:currentIndexDestinationPath
															 error:&error];
				}
			}
		}
        if ( nil != error ) {
            [NSApp activateIgnoringOtherApps:YES];
            NSLog(@"Error: \"%@\"", error);
            [[NSAlert alertWithError:error] runModal];
            return;
        }                    
        if ( nil != humanReadableError ) {
            [NSApp activateIgnoringOtherApps:YES];
            NSAlert *alert = [[NSAlert alloc] init];
            [alert setMessageText:humanReadableError];
            [alert runModal];
            return;
        }
	}
}
	

@end
