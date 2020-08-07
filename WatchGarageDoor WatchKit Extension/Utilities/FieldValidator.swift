//
//  FieldValidator.swift
//
//
//  Created by Bartolomeo Sorrentino on 16/06/2019.
//  Copyright © 2019 Bartolomeo Sorrentino. All rights reserved.
//
//  This module was copied from the GitHub below and made usable in WatchKit Extension.
//  https://github.com/bsorrentino/swiftui-fieldvalidator.git
//
//    MIT License
//
//    Copyright (c) 2019 bsorrentino
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.


import SwiftUI
import Combine

@available(iOS 13, *)
@available(watchOS 6, *)
public struct FieldChecker {
    
    public var errorMessage:String?
    
    public var valid:Bool {
         self.errorMessage == nil
     }
    public init( errorMessage:String? = nil ) {
        self.errorMessage = errorMessage
    }
}

@available(iOS 13, *)
@available(watchOS 6, *)
public class FieldValidator<T> : ObservableObject where T : Hashable {
    public typealias Validator = (T) -> String?
    
    @Binding private var bindValue:T
    @Binding private var checker:FieldChecker
    
    @Published public var value:T
    {
        willSet {
            self.doValidate(newValue)
        }
        didSet {
            self.bindValue = self.value
        }
    }
    private let validator:Validator
    
    public var isValid:Bool {
        self.checker.valid
    }
    
    public var errorMessage:String? {
        self.checker.errorMessage
    }
    
    public init( _ value:Binding<T>, checker:Binding<FieldChecker>, validator:@escaping Validator  ) {
        self.validator = validator
        self._bindValue = value
        self.value = value.wrappedValue
        self._checker = checker
    }
    
    public func doValidate( _ newValue:T? = nil ) -> Void {
                
        self.checker.errorMessage =
                        (newValue != nil) ?
                            self.validator( newValue! ) :
                            self.validator( self.value )
    }
}

@available(iOS 13, *)
@available(watchOS 6, *)
public struct TextFieldWithValidator : View {
    // specialize validator for TestField ( T = String )
    public typealias Validator = (String) -> String?
    
    var title:String?
    
    @ObservedObject var field:FieldValidator<String>
    
    public init( title:String = "", value:Binding<String>, checker:Binding<FieldChecker>, validator:@escaping Validator ) {
        self.title = title;
        self.field = FieldValidator(value, checker:checker, validator:validator )
        
    }

    public var body: some View {
        VStack {
            TextField( title ?? "", text: $field.value )
                .onAppear { // run validation on appear
                    self.field.doValidate()
                }
        }
    }
}

@available(iOS 13, *)
@available(watchOS 6, *)
public struct SecureFieldWithValidator : View {
    // specialize validator for TestField ( T = String )
    public typealias Validator = (String) -> String?
    
    var title:String?
    
    @ObservedObject var field:FieldValidator<String>
    
    public init( title:String = "", value:Binding<String>, checker:Binding<FieldChecker>, validator:@escaping Validator ) {
        self.title = title;
        self.field = FieldValidator(value, checker:checker, validator:validator )
        
    }

    public var body: some View {
        VStack {
            SecureField( title ?? "", text: $field.value )
                .onAppear { // run validation on appear
                    self.field.doValidate()
                }
        }
    }
}
