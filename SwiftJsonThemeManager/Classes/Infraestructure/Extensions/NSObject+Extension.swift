//
//  NSObject+Extension.swift
//  SwiftJsonThemeManager
//
//  Created by Felipe Florencio Garcia on 30/12/18.
//  Copyright © 2018 Felipe Florencio Garcia. All rights reserved.
//

import Foundation

public enum AssociationPolicy: UInt {
    // raw values map to objc_AssociationPolicy's raw values
    case assign = 0
    case copy = 771
    case copyNonatomic = 3
    case retain = 769
    case retainNonatomic = 1
    
    public var objc: objc_AssociationPolicy {
        return objc_AssociationPolicy(rawValue: rawValue)!
    }
}

// MARK: - NSObject Helper
extension NSObject {
    
    /* Computed Propety inside extension -
     
     This is a helper function to be able to add in a easy way the associated object to your
     variables at extensions, as this can be modified for you need you need to know the most
     important itens before change.
     1 - The parameter "key", we added as UInt8, this key is used to be unique for the memory,
     so you could change this to be string just need to update according to your need;
     2 - We set the type to be "OBJC_ASSOCIATION_RETAIN" as default, but you can change;
     
     Example:
     Using this helper you will be able to have computed property inside extension!
     
     extension MyClass {
         public var stringLocalizable: String {
             get {
                 return associatedObject(base: self, key: &UInt8(999), initialiser: { () -> NSString in
                     return ""
                 }) as String
             }
             set {
                 associateObject(base: self, key: &UInt8(999), value: newValue as NSString)
             }
         }
     }
     */
    
    
    public func associatedObject<ValueType: AnyObject>(base: AnyObject, key: UnsafePointer<UInt8>, policy: objc_AssociationPolicy = AssociationPolicy.retain.objc, initialiser: () -> ValueType) -> ValueType {
        guard let associated = objc_getAssociatedObject(base, key) as? ValueType else {
            let associated = initialiser()
            objc_setAssociatedObject(base, key, associated, policy)
            return associated
        }
        return associated
    }
    
    public func optionalAssociatedObject<ValueType: AnyObject>(base: AnyObject, key: UnsafePointer<UInt8>, policy: objc_AssociationPolicy = AssociationPolicy.retain.objc, initialiser: () -> ValueType?) -> ValueType? {
        guard let associated = objc_getAssociatedObject(base, key) as? ValueType else {
            let associated = initialiser()
            if associated != nil {
                objc_setAssociatedObject(base, key, associated!, policy)
            }
            return associated
        }
        return associated
    }
    
    public func associateObject<ValueType: AnyObject>(base: AnyObject, key: UnsafePointer<UInt8>, policy: objc_AssociationPolicy = AssociationPolicy.retain.objc,value: ValueType) {
        objc_setAssociatedObject(base, key, value, policy)
    }
    
    public func associateOptionalObject<ValueType: AnyObject>(base: AnyObject, key: UnsafePointer<UInt8>, policy: objc_AssociationPolicy = AssociationPolicy.retain.objc, value: ValueType?) {
        objc_setAssociatedObject(base, key, value, policy)
    }
}
