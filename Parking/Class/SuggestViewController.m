//
//  SuggestViewController.m
//  Parking
//
//  Created by Tonny on 5/23/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import "SuggestViewController.h"

@interface SuggestViewController ()

@end

@implementation SuggestViewController

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

    [_textView becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification 
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                            selector:@selector(textChanged:)
                                name:UITextViewTextDidChangeNotification 
                              object:_textView];
}

- (void)viewDidUnload
{
    _textView = nil;
    _placeholderLbl = nil;
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

#pragma mark - NSNotification

-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];

    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    [UIView animateWithDuration:[[note.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                     animations:^{
                         _textView.height = 416-keyboardBounds.size.height-10;
                     }];
}

- (void)textChanged:(NSNotification *)noti{
    NSString *text = _textView.text;
    _placeholderLbl.alpha = (text.length == 0);
}

@end
