//
//  CommentViewController.m
//  Parking
//
//  Created by Tonny on 5/23/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import "CommentViewController.h"
#import "Utility.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    UILabel *subLbl = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 200, 10)];
//    subLbl.font = [UIFont systemFontOfSize:10];
//    subLbl.text = @"评论";
//    [self.navigationItem.titleView addSubview:subLbl];
    
    [_textView becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                            selector:@selector(keyboardWillShow:)
                                name:UIKeyboardWillShowNotification 
                                               object:nil];
    [self setSubtitle:@"评论"];
}

- (void)viewDidUnload
{
    _textView = nil;
    _takePhotoBtn = nil;
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)cancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)sure:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)takePhoto:(id)sender {
    [Utility takePhotoWithDelegate:self inViewController:self];
}

#pragma mark - NSNotification

-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    //    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    //    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    //    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];

    [UIView animateWithDuration:[[note.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                     animations:^{
                         _textView.height = 416-keyboardBounds.size.height-10;
                     }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [_takePhotoBtn setImage:image forState:UIControlStateNormal];
    
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
}

@end
