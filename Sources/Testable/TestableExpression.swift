//import Foundation
//
//@propertyWrapper
//public struct TestableExpression<Value> {
//  var expression: String
//  var defaultValue: Value
//  public var projectedValue: Value
//
//  //  init(wrappedValue: Value) {
//  //    defaultValue = wrappedValue
//  //    projectedValue = wrappedValue
//  //    expression = "no expression set error"
//  //  }
//
//  init(wrappedValue: Value, expression: String) {
//    self.expression = expression
//    defaultValue = wrappedValue
//    projectedValue = wrappedValue
//  }
//
//  public var wrappedValue: Value {
//    get {
//      return defaultValue
//    }
//    set {
//      defaultValue = newValue
//    }
//  }
//
//}
