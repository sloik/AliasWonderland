
// MARK: - Closure

/*:

 Alias for function type. Makes signatures of higher order functions more manageable.

 */

public typealias Closure<each I, O>           = (repeat each I)              -> O
public typealias ThrowsClosure<each I,O>      = (repeat each I) throws       -> O
public typealias AsyncClosure<each I, O>      = (repeat each I) async        -> O
public typealias AsyncThrowsClosure<each I,O> = (repeat each I) async throws -> O

// MARK: - Producer Closures

/*:
 # Producers

 Functions that can return an instance of some type.
 */

public typealias Producer<each T>              = ()                 -> (repeat each T)

public typealias ThrowsProducer<each T>        = () throws          -> (repeat each T)

/// Asynchronous function returning some value.
public typealias AsyncProducer<each T>         = () async           -> (repeat each T)

/// Asynchronous function returning some value.
public typealias AsyncThrowsProducer<each T>   = () async throws    -> (repeat each T)

/// Asynchronous function returning some value.
public typealias SendableAsyncProducer<each T> = @Sendable () async -> (repeat each T)
