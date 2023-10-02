
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

public typealias Consumer<I>                          = (I)                              -> Void
public typealias Consumer2I<I1,I2>                    = (I1, I2)                         -> Void
public typealias Consumer3I<I1,I2,I3>                 = (I1, I2, I3)                     -> Void
public typealias Consumer4I<I1,I2,I3,I4>              = (I1, I2, I3, I4)                 -> Void
public typealias Consumer5I<I1,I2,I3,I4,I5>           = (I1, I2, I3, I4, I5)             -> Void
public typealias Consumer6I<I1,I2,I3,I4,I5,I6>        = (I1, I2, I3, I4, I5, I6)         -> Void
public typealias Consumer7I<I1,I2,I3,I4,I5,I6,I7>     = (I1, I2, I3, I4, I5, I6, I7)     -> Void
public typealias Consumer8I<I1,I2,I3,I4,I5,I6,I7, I8> = (I1, I2, I3, I4, I5, I6, I7, I8) -> Void

public typealias ThrowsConsumer<I>                          = (I) throws                              -> Void
public typealias ThrowsConsumer2I<I1,I2>                    = (I1, I2) throws                         -> Void
public typealias ThrowsConsumer3I<I1,I2,I3>                 = (I1, I2, I3) throws                     -> Void
public typealias ThrowsConsumer4I<I1,I2,I3,I4>              = (I1, I2, I3, I4) throws                 -> Void
public typealias ThrowsConsumer5I<I1,I2,I3,I4,I5>           = (I1, I2, I3, I4, I5) throws             -> Void
public typealias ThrowsConsumer6I<I1,I2,I3,I4,I5,I6>        = (I1, I2, I3, I4, I5, I6) throws         -> Void
public typealias ThrowsConsumer7I<I1,I2,I3,I4,I5,I6,I7>     = (I1, I2, I3, I4, I5, I6, I7) throws     -> Void
public typealias ThrowsConsumer8I<I1,I2,I3,I4,I5,I6,I7, I8> = (I1, I2, I3, I4, I5, I6, I7, I8) throws -> Void

// MARK: - Async Consumer

public typealias AsyncConsumer<I> = (I) async -> Void
public typealias AsyncConsumer2I<I1,I2> = (I1, I2) async -> Void

// MARK: - Async Throws Consumer

public typealias AsyncThrowsConsumer<I> = (I) async throws -> Void
public typealias AsyncThrowsConsumer2I<I1,I2> = (I1, I2) async throws -> Void

