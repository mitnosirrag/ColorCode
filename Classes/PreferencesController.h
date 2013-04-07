//
//  Preferences.h
//  Color Code
//
//  Created by Tim Garrison on 1/19/10.
//  Copyright 2010 Implied Solutions. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PreferencesController : NSWindowController {
	IBOutlet NSWindow *preferencesPanel;
	
	IBOutlet NSPopUpButton *sourceFolderPopUp;
	IBOutlet NSPopUpButton *redFolderPopUp;
	IBOutlet NSPopUpButton *orangeFolderPopUp;
	IBOutlet NSPopUpButton *yellowFolderPopUp;
	IBOutlet NSPopUpButton *greenFolderPopUp;
	IBOutlet NSPopUpButton *blueFolderPopUp;
	IBOutlet NSPopUpButton *violetFolderPopUp;
	IBOutlet NSPopUpButton *greyFolderPopUp;
    
    NSString *selectedPopUpTitle;

    BOOL popUpMenuPathsPreLoaded;
}

- (void)showPreferencesPanel;

// folder location selectors
- (IBAction)chooseSourceFolder:(id)sender;
- (IBAction)chooseRedDestinationFolder:(id)sender;
- (IBAction)chooseOrangeDestinationFolder:(id)sender;
- (IBAction)chooseYellowDestinationFolder:(id)sender;
- (IBAction)chooseGreenDestinationFolder:(id)sender;
- (IBAction)chooseBlueDestinationFolder:(id)sender;
- (IBAction)chooseVioletDestinationFolder:(id)sender;
- (IBAction)chooseGreyDestinationFolder:(id)sender;

// action buttons at the bottom of window
- (IBAction)resetButtonClicked:(id)sender;
- (IBAction)closeButtonClicked:(id)sender;

- (void)setPopUpMenuWithPath:(NSPopUpButton *)popUpMenu path:(NSString *)path;
- (void)preloadPopUpMenuPaths;

@property (retain) NSString *selectedPopUpTitle;

@end
