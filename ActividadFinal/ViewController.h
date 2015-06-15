//
//  ViewController.h
//  ActividadFinal
//
//  Created by INNOVATING SOFTWARE SAS on 13/06/15.
//  Copyright (c) 2015 INNOVATING SOFTWARE SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource , UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myCollection;
@property (weak, nonatomic) IBOutlet UIButton *addRecordatorio;

@property (weak, nonatomic) IBOutlet UITextField *nombreActividad;
@property (weak, nonatomic) IBOutlet UIDatePicker *fechaActividad;

@end

