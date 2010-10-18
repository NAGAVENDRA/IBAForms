//
// Copyright 2010 Itty Bitty Apps Pty Ltd
// 
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this 
// file except in compliance with the License. You may obtain a copy of the License at 
// 
// http://www.apache.org/licenses/LICENSE-2.0 
// 
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF 
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "IBADateFormField.h"
#import "IBAFormConstants.h"
#import "IBAInputCommon.h"

@implementation IBADateFormField

@synthesize dateFormFieldCell;
@synthesize dateFormatter;
@synthesize dateFormFieldType;
@synthesize defaultValue;

- (void)dealloc {
	IBA_RELEASE_SAFELY(dateFormFieldCell);
	IBA_RELEASE_SAFELY(dateFormatter);
	
	[super dealloc];
}


- (id)initWithKey:(NSString *)aKey title:(NSString *)aTitle defaultValue:(NSDate *)date type:(IBADateFormFieldType)dateFieldType 
		 editable:(BOOL)editableFlag movable:(BOOL)movableFlag dateFormatter:(NSDateFormatter *)aDateFormatter {
	self = [super initWithKey:aKey title:aTitle editable:editableFlag movable:movableFlag];
	if (self != nil) {
		self.dateFormFieldType = dateFieldType;
		self.defaultValue = date;
		
		self.dateFormatter = aDateFormatter;	
		if (self.dateFormatter == nil) {
			self.dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
			[self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
			[self.dateFormatter setTimeStyle:NSDateFormatterNoStyle];	
			[dateFormatter setDateFormat:@"EEE d MMM yyyy"];
		}
	}
	
	return self;
}

- (id)initWithKey:(NSString *)aKey title:(NSString *)aTitle defaultValue:(NSDate *)date type:(IBADateFormFieldType)dateFieldType {	
	return [self initWithKey:aKey title:aTitle defaultValue:date type:dateFieldType editable:NO movable:NO dateFormatter:nil];
}

- (id)initWithKey:(NSString *)aKey title:(NSString *)aTitle defaultValue:(NSDate *)date {	
	return [self initWithKey:aKey title:aTitle defaultValue:date type:IBADateFormFieldTypeDate];
}

- (id)init {
	return [self initWithKey:nil title:nil];
}

- (NSString *)formFieldStringValue {
	return [self.dateFormatter stringFromDate:[self formFieldValue]];
}

- (void)clear:(id)sender {
	[self setFormFieldValue:nil];
}

#pragma mark -
#pragma mark Cell management

- (IBAFormFieldCell *)cell {
	return [self dateFormFieldCell];
}


- (IBADateFormFieldCell *)dateFormFieldCell {
	if (dateFormFieldCell == nil) {
		dateFormFieldCell = [[IBADateFormFieldCell alloc] initWithFormFieldStyle:self.formFieldStyle reuseIdentifier:@"Cell"];
		dateFormFieldCell.nullable = self.nullable;
		[dateFormFieldCell.clearButton addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
	}
	
	return dateFormFieldCell;
}

- (void)updateCellContents {
	self.dateFormFieldCell.label.text = self.title;
	self.dateFormFieldCell.textField.text = [self formFieldStringValue];
}

#pragma mark -
#pragma mark IBAInputRequestor

- (NSString *)dataType {
	NSString *dataType = nil;
	
	switch (self.dateFormFieldType) {
		case IBADateFormFieldTypeDate:
			dataType = IBAInputDataTypeDate;
			break;
		case IBADateFormFieldTypeTime:
			dataType = IBAInputDataTypeTime;
			break;
		case IBADateFormFieldTypeDateTime:
			dataType = IBAInputDataTypeDateTime;
			break;
		default:
			break;
	}
	
	return dataType;
}


- (id)defaultInputRequestorValue {
	NSDate *defaultDate = self.defaultValue;
	if (defaultDate == nil) {
		defaultDate = [NSDate date];
	}
	
	return defaultDate;
}


@end
