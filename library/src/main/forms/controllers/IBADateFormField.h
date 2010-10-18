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

#import "IBAInputRequestorFormField.h"
#import "IBADateFormFieldCell.h"

typedef enum {
	IBADateFormFieldTypeDate = 0,
	IBADateFormFieldTypeTime,
	IBADateFormFieldTypeDateTime,
} IBADateFormFieldType;


@interface IBADateFormField : IBAInputRequestorFormField {
	IBADateFormFieldCell *dateFormFieldCell;
	NSDateFormatter *dateFormatter;
	IBADateFormFieldType dateFormFieldType;
	NSDate *defaultValue;
}

@property (nonatomic, retain) IBADateFormFieldCell *dateFormFieldCell;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic, assign) IBADateFormFieldType dateFormFieldType;
@property (nonatomic, retain) NSDate *defaultValue;

- (id)initWithKey:(NSString *)aKey title:(NSString *)aTitle defaultValue:(NSDate *)date;
- (id)initWithKey:(NSString *)aKey title:(NSString *)aTitle defaultValue:(NSDate *)date type:(IBADateFormFieldType)dateFieldType;
- (id)initWithKey:(NSString *)aKey title:(NSString *)aTitle defaultValue:(NSDate *)date type:(IBADateFormFieldType)dateFieldType 
		 editable:(BOOL)editableFlag movable:(BOOL)movableFlag dateFormatter:(NSDateFormatter *)aDateFormatter;

- (void)clear:(id)sender;

@end
