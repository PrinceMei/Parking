//
//  Utility.m
//  Parking
//
//  Created by Tonny on 5/24/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (void)takePhotoWithDelegate:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate inViewController:(UIViewController *)viewController{
#if TARGET_IPHONE_SIMULATOR
    [self choseFormLibraryWithDelegate:delegate inViewController:viewController];
    return;
#endif
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = delegate;
    imagePickerController.allowsEditing = YES;
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [viewController presentModalViewController:imagePickerController animated:YES];
}

+ (void)choseFormLibraryWithDelegate:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate inViewController:(UIViewController *)viewController{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = delegate;
    imagePickerController.allowsEditing = YES;
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [viewController presentModalViewController:imagePickerController animated:YES];
}

@end
