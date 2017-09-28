//: Playground - noun: a place where people can play

import UIKit

import RxCocoa
import RxSwift

let a /*: Observable<Int>*/ = Variable(1)   // a = 1
let b /*: Observable<Int>*/ = Variable(2)   // b = 2

// combines latest values of variables `a` and `b` using `+`
let c = Observable.combineLatest(a.asObservable(), b.asObservable()) { $0 + $1 }
    .filter { $0 >= 0 }               // if `a + b >= 0` is true, `a + b` is passed to the map operator
    .map { "\($0) is positive" }      // maps `a + b` to "\(a + b) is positive"

// Since the initial values are a = 1 and b = 2
// 1 + 2 = 3 which is >= 0, so `c` is initially equal to "3 is positive"

// To pull values out of the Rx `Observable` `c`, subscribe to values from `c`.
// `subscribe(onNext:)` means subscribe to the next (fresh) values of `c`.
// That also includes the initial value "3 is positive".
c.subscribe(onNext: { print($0) })          // prints: "3 is positive"

// Now, let's increase the value of `a`
a.value = 4                                   // prints: 6 is positive
// The sum of the latest values, `4` and `2`, is now `6`.
// Since this is `>= 0`, the `map` operator produces "6 is positive"
// and that result is "assigned" to `c`.
// Since the value of `c` changed, `{ print($0) }` will get called,
// and "6 is positive" will be printed.

// Now, let's change the value of `b`
b.value = -8                                 // doesn't print anything
// The sum of the latest values, `4 + (-8)`, is `-4`.
// Since this is not `>= 0`, `map` doesn't get executed.
// This means that `c` still contains "6 is positive"
// Since `c` hasn't been updated, a new "next" value hasn't been produced,
// and `{ print($0) }` won't be called.























