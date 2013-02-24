//
//  Utility.h
//  Parking
//
//  Created by Tonny on 5/24/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (void)takePhotoWithDelegate:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate inViewController:(UIViewController *)viewController;

+ (void)choseFormLibraryWithDelegate:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate inViewController:(UIViewController *)viewController;
@end
