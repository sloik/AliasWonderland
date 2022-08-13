
// MARK: - Closure

/*:

 Alias for function type. Makes signatures of higher order functions more managable.

 */

public typealias Closure<I, O>                          = (I)                              -> O
public typealias Closure2I<I1,I2, O>                    = (I1, I2)                         -> O
public typealias Closure3I<I1,I2,I3, O>                 = (I1, I2, I3)                     -> O
public typealias Closure4I<I1,I2,I3,I4, O>              = (I1, I2, I3, I4)                 -> O
public typealias Closure5I<I1,I2,I3,I4,I5, O>           = (I1, I2, I3, I4, I5)             -> O
public typealias Closure6I<I1,I2,I3,I4,I5,I6, O>        = (I1, I2, I3, I4, I5, I6)         -> O
public typealias Closure7I<I1,I2,I3,I4,I5,I6,I7, O>     = (I1, I2, I3, I4, I5, I6, I7)     -> O
public typealias Closure8I<I1,I2,I3,I4,I5,I6,I7, I8, O> = (I1, I2, I3, I4, I5, I6, I7, I8) -> O

// MARK: - Producer Closures
/*:
 # Producers

 Functions that can return an instacne of some type.
 */

public typealias Producer<T> = () -> T

// MARK: Async

public typealias AsyncClosure<I, O>                          = (I) async                              -> O
public typealias AsyncClosure2I<I1,I2, O>                    = (I1, I2) async                         -> O
public typealias AsyncClosure3I<I1,I2,I3, O>                 = (I1, I2, I3) async                     -> O
public typealias AsyncClosure4I<I1,I2,I3,I4, O>              = (I1, I2, I3, I4) async                 -> O
public typealias AsyncClosure5I<I1,I2,I3,I4,I5, O>           = (I1, I2, I3, I4, I5) async             -> O
public typealias AsyncClosure6I<I1,I2,I3,I4,I5,I6, O>        = (I1, I2, I3, I4, I5, I6) async         -> O
public typealias AsyncClosure7I<I1,I2,I3,I4,I5,I6,I7, O>     = (I1, I2, I3, I4, I5, I6, I7) async     -> O
public typealias AsyncClosure8I<I1,I2,I3,I4,I5,I6,I7, I8, O> = (I1, I2, I3, I4, I5, I6, I7, I8) async -> O

/// Asynchronus function returning some value.
public typealias AsyncProducer<T> = () async -> T
