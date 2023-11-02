
// MARK: - Closure

/*:

 Alias for function type. Makes signatures of higher order functions more manageable.

 */

public typealias Closure<I, O>                          = (I)                              -> O
public typealias Closure2I<I1,I2, O>                    = (I1, I2)                         -> O
public typealias Closure3I<I1,I2,I3, O>                 = (I1, I2, I3)                     -> O
public typealias Closure4I<I1,I2,I3,I4, O>              = (I1, I2, I3, I4)                 -> O
public typealias Closure5I<I1,I2,I3,I4,I5, O>           = (I1, I2, I3, I4, I5)             -> O
public typealias Closure6I<I1,I2,I3,I4,I5,I6, O>        = (I1, I2, I3, I4, I5, I6)         -> O
public typealias Closure7I<I1,I2,I3,I4,I5,I6,I7, O>     = (I1, I2, I3, I4, I5, I6, I7)     -> O
public typealias Closure8I<I1,I2,I3,I4,I5,I6,I7, I8, O> = (I1, I2, I3, I4, I5, I6, I7, I8) -> O

public typealias ThrowsClosure<I,O>                = (I) throws              -> O
public typealias ThrowsClosure2I<I1,I2,O>          = (I1,I2) throws          -> O
public typealias ThrowsClosure3I<I1,I2,I3,O>       = (I1,I2,I3) throws       -> O
public typealias ThrowsClosure4I<I1,I2,I3,I4,O>    = (I1,I2,I3,I4) throws    -> O
public typealias ThrowsClosure5I<I1,I2,I3,I4,I5,O> = (I1,I2,I3,I4,I5) throws -> O

public typealias AsyncThrowsClosure<I,O>                = (I) async throws              -> O
public typealias AsyncThrowsClosure2I<I1,I2,O>          = (I1,I2) async throws          -> O
public typealias AsyncThrowsClosure3I<I1,I2,I3,O>       = (I1,I2,I3) async throws       -> O
public typealias AsyncThrowsClosure4I<I1,I2,I3,I4,O>    = (I1,I2,I3,I4) async throws    -> O
public typealias AsyncThrowsClosure5I<I1,I2,I3,I4,I5,O> = (I1,I2,I3,I4,I5) async throws -> O

public typealias AsyncThrowsClosure2I2O<I1, I2, O1, O2> = (I1,I2) async throws -> (O1, O2)

// MARK: - Producer Closures
/*:
 # Producers

 Functions that can return an instance of some type.
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

/// Asynchronous function returning some value.
public typealias AsyncProducer<T> = () async -> T

public typealias AsyncThrowsProducer<O1, O2> = () async throws -> (O1, O2)

/// Asynchronous function returning some value.
public typealias SendableAsyncProducer<T> = @Sendable () async -> T
