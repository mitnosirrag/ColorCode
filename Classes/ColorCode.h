//
//  ColorCode.h
//  Color Code
//
//  Created by Tim Garrison on 1/2/10.
//  Copyright 2010 Implied Solutions. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const DEFAULT_SOURCE_PATH;

extern NSString * const DEFAULT_DESTINATION_DIRECTORY_RED;
extern NSString * const DEFAULT_DESTINATION_DIRECTORY_ORANGE;
extern NSString * const DEFAULT_DESTINATION_DIRECTORY_YELLOW;
extern NSString * const DEFAULT_DESTINATION_DIRECTORY_GREEN;
extern NSString * const DEFAULT_DESTINATION_DIRECTORY_BLUE;
extern NSString * const DEFAULT_DESTINATION_DIRECTORY_VIOLET;
extern NSString * const DEFAULT_DESTINATION_DIRECTORY_GREY;

@interface ColorCode : NSObject {
	
	NSString *globalErrorFlag; /* if this is ever set, stop whatever is happening */
	
	NSString *sourcePath;
	NSDictionary *colorCodeDictionary, *destinationDictionary;
	NSNumber *DO_NOT_MOVE_COLOR_LABEL;

	
	/*NSString *sourcePath = @"/Users/tim/Desktop/ColorCode";
	 NSDictionary *destinationDirectories = [NSDictionary dictionaryWithObjectsAndKeys:
	 const DESTINATION_DIRECTORY_RED, @"Red",
	 nil];
*/	 
	
}

@property (retain) NSString *globalErrorFlag;
@property (retain) NSString *sourcePath;
@property (retain) NSDictionary *colorCodeDictionary, *destinationDictionary;
@property (retain) NSNumber *DO_NOT_MOVE_COLOR_LABEL;

- (void) chooseDestinations;
- (void) moveFilesFromSourceDirectoryToDestinationDirectoriesByColor;
	
@end
