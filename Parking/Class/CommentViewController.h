//
//  CommentViewController.h
//  Parking
//
//  Created by Tonny on 5/23/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    
    __weak IBOutlet UIButton            *_takePhotoBtn;
    __weak IBOutlet UITextView          *_textView;
}

@end
