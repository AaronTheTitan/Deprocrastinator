//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Aaron Bradley on 1/12/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *taskTableView;
@property (strong, nonatomic) IBOutlet UITextField *taskTextField;

@property NSString *userTask;
@property NSMutableArray *userTasksArray;
@property UITableViewCell *cell;

//@property NSArray *priorityColorsArray;

@property int numberOfSwipesToRight;

//@property CGPoint taskTouched;

@end



@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.userTasksArray = [[NSMutableArray alloc] init];

//    self.priorityColorsArray = [[NSArray alloc] initWithObjects:[UIColor redColor], [UIColor yellowColor], [UIColor greenColor], nil];

    self.numberOfSwipesToRight = 0;


}


///////


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hold Up!" message:@"Are you sure you want to delete this item.  This can't be undone" delegate:self cancelButtonTitle:@"Delete" otherButtonTitles:@"Cancel", nil];
    [alert show];

//    [alert reloadInputViews];
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.userTasksArray removeObjectAtIndex:indexPath.row];
//
//    } else {
//        [self alertView:alert clickedButtonAtIndex:1];
//    }

    
}

- (void)alertViewCancel:(UIAlertView *)alertView {
    [self.taskTableView reloadData];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {


//            [self.userTasksArray removeObjectAtIndex:];
            [self.taskTableView reloadData];
}


//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex indexPath:(NSIndexPath *)indexPath{
//
//    if (buttonIndex == 0){
//
//        [self.userTasksArray removeObjectAtIndex:indexPath.row];
//        [self.taskTableView reloadData];
//
//    } else {
//
//        [self.taskTableView reloadData];
//
//    }
//
//
//}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {

    NSString *titleItem = [self.userTasksArray objectAtIndex:sourceIndexPath.row];

    [self.userTasksArray removeObject:titleItem];
    [self.userTasksArray insertObject:titleItem atIndex:destinationIndexPath.row];

    [self.taskTableView reloadData];

}

///////


- (IBAction)onAddButtonPressed:(UIButton *)sender {

    self.userTask = [NSString stringWithFormat:@"%@", self.taskTextField.text];

    [self.userTasksArray addObject: self.taskTextField.text];
    [self.taskTableView reloadData];

    self.taskTextField.text = @"";
    [self.taskTextField endEditing:YES];

}
- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {

    if (self.editing)
    {
        self.editing = false;
        [self.taskTableView setEditing:false animated:true];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
    } else {
        self.editing = true;
        [self.taskTableView setEditing:true animated:true];
        sender.style = UIBarButtonItemStyleDone;
        sender.title = @"Done";
    }
    [self.taskTableView reloadData];
}


- (IBAction)onSwipeToRight:(UISwipeGestureRecognizer *)sender {

    CGPoint location = [sender locationInView:self.taskTableView];
    NSIndexPath *indexPath = [self.taskTableView indexPathForRowAtPoint:location];
    UITableViewCell *swipedCell = [self.taskTableView cellForRowAtIndexPath:indexPath];


    self.numberOfSwipesToRight++;

    if (self.numberOfSwipesToRight == 1) {
        swipedCell.textLabel.textColor = [UIColor redColor];
    } else if (self.numberOfSwipesToRight == 2) {
        swipedCell.textLabel.textColor = [UIColor yellowColor];
    } else if (self.numberOfSwipesToRight == 3) {
        swipedCell.textLabel.textColor = [UIColor greenColor];
    } else {
        swipedCell.textLabel.textColor = [UIColor blackColor];
        self.numberOfSwipesToRight = 0;
    }

//    [self.taskTableView reloadData];

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    self.cell = [self.taskTableView cellForRowAtIndexPath:indexPath];
    self.cell.textLabel.textColor = [UIColor greenColor];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userTasksArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    self.cell = [tableView dequeueReusableCellWithIdentifier:@"ColorCellID"];
    self.cell.textLabel.text = [self.userTasksArray objectAtIndex:indexPath.row];

    return self.cell;
    
}


@end
