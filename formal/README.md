# Formal model (TLA+)

AliasWonderland is only `typealias` declarations over function types, so
`AliasWonderland.tla` models the **alias table** (each public alias with the flags of the function
type it expands to: `throws`, `async`, `@MainActor`, `@Sendable`, and its shape: consumer /
closure / producer) and the semantic equivalences the aliases promise. It does not model Swift's
type checker. Parameter packs are abstracted to sequences over `{"A","B"}` (length <= 2), output
types to `{"X","Y"}`. There is one dummy state (`u = 0`); every law is a closed formula over the
finite alias table.

| Invariant | Swift API it abstracts |
|---|---|
| `NameMatchesFlags` | the words `Main` / `Async` / `Throws` / `Sendable` in an alias name match `@MainActor` / `async` / `throws` / `@Sendable` in its expansion |
| `NoDuplicateSignatures` | no two aliases of one family expand to the same function type |
| `ConsumerEqualsClosureVoid` | `Consumer<I>` (and every Throws/Async/Main variant) `== Closure<I, Void>` with the same effects |
| `ProducerEqualsClosureNoInput` | `Producer<T>` `== Closure<(), T>` for every variant |
| `SideEffectIsEmptyConsumer` | `SideEffectClosure == Consumer<>`, `MainSideEffectClosure == MainConsumer<>` |
| `SendableOnlyAddsSendability` | `SendableAsyncProducer == AsyncProducer` + `@Sendable` |
| `ConsumerFamilyComplete` | all 8 throws x async x main combinations exist as consumer aliases |
| `EffectOrderIsPartialOrder`, `PlainIsBottomOfEffects` | plain -> throws / async -> async throws conversion order inside a family: reflexive, antisymmetric, transitive, plain is the bottom |

## Non-vacuity

`consumer_returns_value` -> `ConsumerEqualsClosureVoid`; `producer_takes_input` ->
`ProducerEqualsClosureNoInput`; `throws_flag_dropped` -> `NameMatchesFlags`; `main_flag_dropped`
-> `NoDuplicateSignatures`. `run_tlc.sh` fails if a mutant passes.

## Findings

None: no promised law is violated. Coverage gaps (not violations): there is no `MainClosure` /
`MainThrowsClosure` and no `MainProducer` / `MainThrowsProducer` (only the `MainAsync*` forms
exist), so `ConsumerEqualsClosureVoid` is checked only where both aliases exist, and
`ConsumerFamilyComplete` is asserted for consumers only.

## Running

```sh
TLA_JAR=/path/to/tla2tools-1.7.4.jar formal/run_tlc.sh   # needs Java 11+
```

The script checks the jar's SHA-256 against the pinned tla2tools 1.7.4. CI runs it on a
self-hosted Oracle ARM64 runner, only on pushes to the default branch or by manual dispatch
(`.github/workflows/oracle-tla.yml`). The Swift build and tests stay on hosted macOS.

## Limits

The alias table is transcribed by hand from `Sources/AliasWonderland`; the compiler, not this
model, checks the aliases. The conversion order models the Swift rule (non-throwing -> throwing,
sync -> async, same isolation) and is not verified against the compiler. If an alias is added or
changed, update the table (and the `Cardinality` check in `TypeOK`) in the same PR.
