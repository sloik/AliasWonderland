
import Foundation

/*:

 # What is a side effect?

 Each time you run some code for "change of the world" not for the returned value you
 are dealing with a side effect (sometimes functions do both). Good examples are:

 - printing to a console
 - making a network request
 - change the state of some object (eg. change of background color)

 Each function in Swift returns a value. Sometime this value is `Void` which signals
 that this function was run for some sort of side effect.

 */

public typealias SideEffectClosure = () -> Void

// MARK: - Consumers Closures

/*:

 # What is a consumer?

It's a function that takes some input and performs `SideEffect`.
 Typically you can find them as many `handlers`.

 */

public typealias Consumer<each I>       = (repeat each I)        -> Void
public typealias ThrowsConsumer<each I> = (repeat each I) throws -> Void


// MARK: - Async Consumer

public typealias AsyncConsumer<each I> = (repeat each I) async -> Void

// MARK: - Async Throws Consumer

public typealias AsyncThrowsConsumer<each I> = (repeat each I) async throws -> Void

