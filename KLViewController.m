//
//  KLViewController.m
//  KLNoteViewController
//
//  Created by Kieran Lafferty on 2012-12-29.
//  Copyright (c) 2012 Kieran Lafferty. All rights reserved.
//

#import "KLViewController.h"
#import "KLCustomViewController.h"
@interface KLViewController ()

@end

@implementation KLViewController

- (void)viewDidLoad
{

	// Do any additional setup after loading the view, typically from a nib.
    
    //Initialize the controller data
    NSString* plistPath = [[NSBundle mainBundle] pathForResource: @"NavigationControllerData"
                                                          ofType: @"plist"];
    // Build the array from the plist
    self.viewControllerData = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfControllerCardsInNoteView:(KLNoteViewController*) noteView {
    return  [self.viewControllerData count];
}
- (UIViewController *)noteView:(KLNoteViewController*)noteView viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Get the relevant data for the navigation controller
    NSDictionary* navDict = [self.viewControllerData objectAtIndex: indexPath.row];
    
    //Initialize a blank uiviewcontroller for display purposes
    UIStoryboard *st = self.storyboard;
    
    KLCustomViewController* viewController = [st instantiateViewControllerWithIdentifier:@"RootViewController"];
    [viewController setInfo: navDict];

    //Return the custom view controller
    return viewController;
}

-(void) noteViewController: (KLNoteViewController*) noteViewController didUpdateControllerCard:(KLControllerCard*)controllerCard toDisplayState:(KLControllerCardState) toState fromDisplayState:(KLControllerCardState) fromState {

    
    NSIndexPath* index = [noteViewController indexPathForControllerCard: controllerCard];
    NSDictionary* navDict = [self.viewControllerData objectAtIndex: index.row];
    
    NSLog(@"%@ changed state %ld", [navDict objectForKey:@"title"], toState);
    
}
- (IBAction)reloadCardData:(id)sender {
    [self reloadDataAnimated:YES];
    
}
@end
