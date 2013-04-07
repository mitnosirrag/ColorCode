//
//  Preferences.m
//  Color Code
//
//  Created by Tim Garrison on 1/19/10.
//  Copyright 2010 Implied Solutions. All rights reserved.
//

#import "PreferencesController.h"
#import "UserSettings.h"

@implementation PreferencesController

@synthesize selectedPopUpTitle;

BOOL popUpMenuPathsPreLoaded;

- (void)showPreferencesPanel {
	[NSApp activateIgnoringOtherApps:YES];
	if ( ![preferencesPanel isVisible] ) {
		[preferencesPanel center];
		[preferencesPanel makeFirstResponder:nil];
	}
	[preferencesPanel makeKeyAndOrderFront:nil];
    if ( YES != popUpMenuPathsPreLoaded ) {
        [self preloadPopUpMenuPaths];
        //popUpMenuPathsPreLoaded = YES;
    }
}

- (void)preloadPopUpMenuPaths {
    UserSettings *userSettings = [[UserSettings alloc] init];
    NSMutableDictionary *colorDestinationPaths = [userSettings colorDestinationPaths];
    [self setPopUpMenuWithPath:sourceFolderPopUp
                          path:[[colorDestinationPaths objectForKey:@"SourceDirectory"] stringByExpandingTildeInPath]];
    [self setPopUpMenuWithPath:redFolderPopUp
                          path:[[colorDestinationPaths objectForKey:@"DestinationDirectoryRed"] stringByExpandingTildeInPath]];
    [self setPopUpMenuWithPath:orangeFolderPopUp
                          path:[[colorDestinationPaths objectForKey:@"DestinationDirectoryOrange"] stringByExpandingTildeInPath]];
    [self setPopUpMenuWithPath:yellowFolderPopUp
                          path:[[colorDestinationPaths objectForKey:@"DestinationDirectoryYellow"] stringByExpandingTildeInPath]];
    [self setPopUpMenuWithPath:greenFolderPopUp
                          path:[[colorDestinationPaths objectForKey:@"DestinationDirectoryGreen"] stringByExpandingTildeInPath]];
    [self setPopUpMenuWithPath:blueFolderPopUp
                          path:[[colorDestinationPaths objectForKey:@"DestinationDirectoryBlue"] stringByExpandingTildeInPath]];
    [self setPopUpMenuWithPath:violetFolderPopUp
                          path:[[colorDestinationPaths objectForKey:@"DestinationDirectoryViolet"] stringByExpandingTildeInPath]];
    [self setPopUpMenuWithPath:greyFolderPopUp
                          path:[[colorDestinationPaths objectForKey:@"DestinationDirectoryGrey"] stringByExpandingTildeInPath]];
}

- (IBAction)chooseSourceFolder:(id)sender {
	// get current setting as the starting point
	// current hard coded for testing
    self.selectedPopUpTitle = @"SourceDirectory";
	NSString *currentFolder = [@"~/Desktop/" stringByExpandingTildeInPath];
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setCanChooseFiles:NO];
	[panel setCanChooseDirectories:YES];
	[panel setAllowsMultipleSelection:NO];
	[panel setCanCreateDirectories:YES];
	[panel setPrompt:@"OK"];
	
	[panel beginSheetForDirectory:currentFolder
							 file:nil
							types:nil
				   modalForWindow:preferencesPanel
					modalDelegate:self
				   didEndSelector:@selector(openPanelDidEnd:returnCode:contextInfo:)
					  contextInfo:sourceFolderPopUp];
}

- (IBAction)chooseRedDestinationFolder:(id)sender {
	// get current setting as the starting point
	// current hard coded for testing
    self.selectedPopUpTitle = @"DestinationDirectoryRed";
	NSString *currentFolder = [@"~/Documents/ColorCode/Red/" stringByExpandingTildeInPath];
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setCanChooseFiles:NO];
	[panel setCanChooseDirectories:YES];
	[panel setAllowsMultipleSelection:NO];
	[panel setCanCreateDirectories:YES];
	[panel setPrompt:@"OK"];
	
	[panel beginSheetForDirectory:currentFolder
							 file:nil
							types:nil
				   modalForWindow:preferencesPanel
					modalDelegate:self
				   didEndSelector:@selector(openPanelDidEnd:returnCode:contextInfo:)
					  contextInfo:redFolderPopUp];
}

- (IBAction)chooseOrangeDestinationFolder:(id)sender {
	// get current setting as the starting point
	// current hard coded for testing
    self.selectedPopUpTitle = @"DestinationDirectoryOrange";
	NSString *currentFolder = [@"~/Documents/ColorCode/Orange/" stringByExpandingTildeInPath];
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setCanChooseFiles:NO];
	[panel setCanChooseDirectories:YES];
	[panel setAllowsMultipleSelection:NO];
	[panel setCanCreateDirectories:YES];
	[panel setPrompt:@"OK"];
	
	[panel beginSheetForDirectory:currentFolder
							 file:nil
							types:nil
				   modalForWindow:preferencesPanel
					modalDelegate:self
				   didEndSelector:@selector(openPanelDidEnd:returnCode:contextInfo:)
					  contextInfo:orangeFolderPopUp];
}

- (IBAction)chooseYellowDestinationFolder:(id)sender {
	// get current setting as the starting point
	// current hard coded for testing
    self.selectedPopUpTitle = @"DestinationDirectoryYellow";
	NSString *currentFolder = [@"~/Documents/ColorCode/Yellow/" stringByExpandingTildeInPath];
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setCanChooseFiles:NO];
	[panel setCanChooseDirectories:YES];
	[panel setAllowsMultipleSelection:NO];
	[panel setCanCreateDirectories:YES];
	[panel setPrompt:@"OK"];
	
	[panel beginSheetForDirectory:currentFolder
							 file:nil
							types:nil
				   modalForWindow:preferencesPanel
					modalDelegate:self
				   didEndSelector:@selector(openPanelDidEnd:returnCode:contextInfo:)
					  contextInfo:yellowFolderPopUp];
}

- (IBAction)chooseGreenDestinationFolder:(id)sender {
	// get current setting as the starting point
	// current hard coded for testing
    self.selectedPopUpTitle = @"DestinationDirectoryGreen";
	NSString *currentFolder = [@"~/Documents/ColorCode/Green/" stringByExpandingTildeInPath];
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setCanChooseFiles:NO];
	[panel setCanChooseDirectories:YES];
	[panel setAllowsMultipleSelection:NO];
	[panel setCanCreateDirectories:YES];
	[panel setPrompt:@"OK"];
	
	[panel beginSheetForDirectory:currentFolder
							 file:nil
							types:nil
				   modalForWindow:preferencesPanel
					modalDelegate:self
				   didEndSelector:@selector(openPanelDidEnd:returnCode:contextInfo:)
					  contextInfo:greenFolderPopUp];
}

- (IBAction)chooseBlueDestinationFolder:(id)sender {
	// get current setting as the starting point
	// current hard coded for testing
    self.selectedPopUpTitle = @"DestinationDirectoryBlue";
	NSString *currentFolder = [@"~/Documents/ColorCode/Blue/" stringByExpandingTildeInPath];
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setCanChooseFiles:NO];
	[panel setCanChooseDirectories:YES];
	[panel setAllowsMultipleSelection:NO];
	[panel setCanCreateDirectories:YES];
	[panel setPrompt:@"OK"];
	
	[panel beginSheetForDirectory:currentFolder
							 file:nil
							types:nil
				   modalForWindow:preferencesPanel
					modalDelegate:self
				   didEndSelector:@selector(openPanelDidEnd:returnCode:contextInfo:)
					  contextInfo:blueFolderPopUp];
}

- (IBAction)chooseVioletDestinationFolder:(id)sender {
	// get current setting as the starting point
	// current hard coded for testing
    self.selectedPopUpTitle = @"DestinationDirectoryViolet";
	NSString *currentFolder = [@"~/Documents/ColorCode/Violet/" stringByExpandingTildeInPath];
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setCanChooseFiles:NO];
	[panel setCanChooseDirectories:YES];
	[panel setAllowsMultipleSelection:NO];
	[panel setCanCreateDirectories:YES];
	[panel setPrompt:@"OK"];
	
	[panel beginSheetForDirectory:currentFolder
							 file:nil
							types:nil
				   modalForWindow:preferencesPanel
					modalDelegate:self
				   didEndSelector:@selector(openPanelDidEnd:returnCode:contextInfo:)
					  contextInfo:violetFolderPopUp];
}

- (IBAction)chooseGreyDestinationFolder:(id)sender {
	// get current setting as the starting point
	// current hard coded for testing
    self.selectedPopUpTitle = @"DestinationDirectoryGrey";
	NSString *currentFolder = [@"~/Documents/ColorCode/Grey/" stringByExpandingTildeInPath];
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setCanChooseFiles:NO];
	[panel setCanChooseDirectories:YES];
	[panel setAllowsMultipleSelection:NO];
	[panel setCanCreateDirectories:YES];
	[panel setPrompt:@"OK"];
	
	[panel beginSheetForDirectory:currentFolder
							 file:nil
							types:nil
				   modalForWindow:preferencesPanel
					modalDelegate:self
				   didEndSelector:@selector(openPanelDidEnd:returnCode:contextInfo:)
  					  contextInfo:greyFolderPopUp];
}

- (IBAction)resetButtonClicked:(id)sender {
	NSAlert *resetAlert = [NSAlert alertWithMessageText:@"Are you sure you want to reset all directories?"
										  defaultButton:@"OK" 
										alternateButton:@"Cancel"
											otherButton:nil
							  informativeTextWithFormat:@""];
	NSInteger resetAlertResult = [resetAlert runModal];
	if ( NSAlertAlternateReturn != resetAlertResult ) {
        [UserSettings copyDefaultsToUserSettings];
        [self preloadPopUpMenuPaths];
	}
}

- (IBAction)closeButtonClicked:(id)sender {
	[preferencesPanel orderOut:sender];
}

- (void)setPopUpMenuWithPath:(NSPopUpButton *)popUpMenu path:(NSString *)path {
	NSMenuItem *placeholder = [popUpMenu itemAtIndex:0];
	if ( !placeholder ) {
		return;
	}
	
	NSImage *icon = [[NSWorkspace sharedWorkspace] iconForFile:path];
	[icon setScalesWhenResized:YES];
	[icon setSize:NSMakeSize(16.0,16.0)];
	
	[placeholder setTitle:[[NSFileManager defaultManager] displayNameAtPath:path]];
	[placeholder setImage:icon];
	
	[popUpMenu selectItemAtIndex:0];
}

- (void)openPanelDidEnd:(NSOpenPanel *)sheet returnCode:(int)returnCode contextInfo:(void *)contextInfo {
	if ( NSOKButton == returnCode ) {
		NSString *newPath = [[sheet filenames] objectAtIndex:0];
        
		// write the new value for source
        UserSettings *userSettings = [[UserSettings alloc] init];
        [userSettings setUserPreferencesKeyValue:self.selectedPopUpTitle value:newPath];
        
        // save the settings to plist
        [userSettings writePreferencesToPlist];
		 
		// update the menu
		[self setPopUpMenuWithPath:contextInfo
							  path:newPath];
	} else {
		[(NSPopUpButton *) contextInfo selectItemAtIndex:0];
	}
}

@end
