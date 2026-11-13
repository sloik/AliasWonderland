------------------------- MODULE AliasWonderland -------------------------
(* Finite model of Sources/AliasWonderland. The library is only typealiases *)
(* over function types, so the model is the alias table (name -> the flags  *)
(* of the function type it expands to) plus the equivalences the aliases    *)
(* promise: Consumer<I> == Closure<I, Void>, Producer<T> == Closure<(), T>, *)
(* SideEffectClosure == Consumer<>, naming matches effects, and the effect  *)
(* conversion order. Parameter packs are abstracted to short sequences over *)
(* {"A","B"}; the output type to {"X","Y"} or "void"; Swift types are not   *)
(* modelled (no inference, no @Sendable/actor checking).                    *)
EXTENDS Naturals, Sequences, FiniteSets

CONSTANTS Mutant       \* "none" or a seeded bug

VARIABLE u
Init == u = 0
Next == UNCHANGED u
Spec == Init /\ [][Next]_u

Seqs(S, n) == UNION {[1..k -> S] : k \in 0..n}
Packs == Seqs({"A", "B"}, 2)     \* input parameter packs
Outs  == {"X", "Y"}              \* output type / producer pack

\* One record per public typealias. thr/asy/main/snd = throws / async / @MainActor / @Sendable.
\* parts = the words in the alias name that announce an effect.
E(n, fam, thr, asy, main, snd, parts) ==
  [name |-> n, fam |-> fam, thr |-> thr, asy |-> asy, main |-> main, snd |-> snd, parts |-> parts]

Aliases == {
  \* SideEffectAliases.swift
  E("SideEffectClosure",      "Consumer0", FALSE, FALSE, FALSE, FALSE, {}),
  E("MainSideEffectClosure",  "Consumer0", FALSE, FALSE,
        (Mutant # "main_flag_dropped"), FALSE, {"Main"}),
  E("Consumer",               "Consumer", FALSE, FALSE, FALSE, FALSE, {}),
  E("MainConsumer",           "Consumer", FALSE, FALSE,
        (Mutant # "main_flag_dropped"), FALSE, {"Main"}),
  E("ThrowsConsumer",         "Consumer", TRUE,  FALSE, FALSE, FALSE, {"Throws"}),
  E("MainThrowsConsumer",     "Consumer", TRUE,  FALSE, TRUE,  FALSE, {"Main", "Throws"}),
  E("AsyncConsumer",          "Consumer", FALSE, TRUE,  FALSE, FALSE, {"Async"}),
  E("MainAsyncConsumer",      "Consumer", FALSE, TRUE,  TRUE,  FALSE, {"Main", "Async"}),
  E("AsyncThrowsConsumer",    "Consumer", (Mutant # "throws_flag_dropped"), TRUE, FALSE, FALSE,
        {"Async", "Throws"}),
  E("MainAsyncThrowsConsumer","Consumer", TRUE,  TRUE,  TRUE,  FALSE, {"Main", "Async", "Throws"}),
  \* ClosuresAliases.swift
  E("Closure",                "Closure",  FALSE, FALSE, FALSE, FALSE, {}),
  E("ThrowsClosure",          "Closure",  TRUE,  FALSE, FALSE, FALSE, {"Throws"}),
  E("AsyncClosure",           "Closure",  FALSE, TRUE,  FALSE, FALSE, {"Async"}),
  E("AsyncThrowsClosure",     "Closure",  TRUE,  TRUE,  FALSE, FALSE, {"Async", "Throws"}),
  E("MainAsyncClosure",       "Closure",  FALSE, TRUE,  TRUE,  FALSE, {"Main", "Async"}),
  E("MainAsyncThrowsClosure", "Closure",  TRUE,  TRUE,  TRUE,  FALSE, {"Main", "Async", "Throws"}),
  E("Producer",               "Producer", FALSE, FALSE, FALSE, FALSE, {}),
  E("ThrowsProducer",         "Producer", TRUE,  FALSE, FALSE, FALSE, {"Throws"}),
  E("AsyncProducer",          "Producer", FALSE, TRUE,  FALSE, FALSE, {"Async"}),
  E("MainAsyncProducer",      "Producer", FALSE, TRUE,  TRUE,  FALSE, {"Main", "Async"}),
  E("AsyncThrowsProducer",    "Producer", TRUE,  TRUE,  FALSE, FALSE, {"Async", "Throws"}),
  E("MainAsyncThrowsProducer","Producer", TRUE,  TRUE,  TRUE,  FALSE, {"Main", "Async", "Throws"}),
  E("SendableAsyncProducer",  "Producer", FALSE, TRUE,  FALSE, TRUE,  {"Async", "Sendable"})}

Fam(f) == {a \in Aliases : a.fam = f}
Flags(a) == <<a.thr, a.asy, a.main, a.snd>>

\* The function type an alias denotes, given its parameter pack I and output/pack O.
Denote(a, I, O) ==
  IF a.fam = "Consumer"  THEN <<I,     IF Mutant = "consumer_returns_value" /\ a.thr THEN O ELSE "void", Flags(a)>>
  ELSE IF a.fam = "Consumer0" THEN <<<<>>, "void", Flags(a)>>
  ELSE IF a.fam = "Closure"   THEN <<I,    O,      Flags(a)>>
  ELSE <<IF Mutant = "producer_takes_input" THEN I ELSE <<>>, O, Flags(a)>>   \* Producer

\* Swift's conversion order between function types of the same shape.
Convertible(a, b) ==
  /\ a.fam = b.fam /\ a.main = b.main /\ a.snd = b.snd
  /\ (a.thr => b.thr) /\ (a.asy => b.asy)

TypeOK == u = 0 /\ Cardinality(Aliases) = 23

\* The alias names carry the effect words: Main / Async / Throws / Sendable.
NameMatchesFlags == u = 0 =>
  \A a \in Aliases :
    /\ ("Main" \in a.parts)   = a.main
    /\ ("Async" \in a.parts)  = a.asy
    /\ ("Throws" \in a.parts) = a.thr
    /\ ("Sendable" \in a.parts) = a.snd

\* Two aliases of one family never denote the same function type.
NoDuplicateSignatures == u = 0 =>
  \A a, b \in Aliases : (a.fam = b.fam /\ Flags(a) = Flags(b)) => a = b

\* Consumer<I> == Closure<I, Void> (wherever the matching Closure alias exists).
ConsumerEqualsClosureVoid == u = 0 =>
  \A c \in Fam("Consumer") : \A k \in Fam("Closure") :
    Flags(c) = Flags(k) => \A I \in Packs : \A O \in Outs :
      Denote(c, I, O) = Denote(k, I, "void")

\* Producer<T> == Closure<(), T>.
ProducerEqualsClosureNoInput == u = 0 =>
  \A p \in Fam("Producer") : \A k \in Fam("Closure") :
    Flags(p) = Flags(k) => \A I \in Packs : \A O \in Outs :
      Denote(p, I, O) = Denote(k, <<>>, O)

\* SideEffectClosure == Consumer<> and MainSideEffectClosure == MainConsumer<>.
SideEffectIsEmptyConsumer == u = 0 =>
  \A s \in Fam("Consumer0") : \E c \in Fam("Consumer") :
    Flags(s) = Flags(c) /\ \A O \in Outs : Denote(s, <<>>, O) = Denote(c, <<>>, O)

\* SendableAsyncProducer == AsyncProducer plus @Sendable, nothing else.
SendableOnlyAddsSendability == u = 0 =>
  \A s \in {a \in Aliases : a.snd} : \E p \in Fam("Producer") :
    p.name = "AsyncProducer" /\ \A O \in Outs :
      Denote(s, <<>>, O)[1] = Denote(p, <<>>, O)[1] /\ Denote(s, <<>>, O)[2] = Denote(p, <<>>, O)[2]
      /\ s.thr = p.thr /\ s.asy = p.asy /\ s.main = p.main

\* Every combination of throws x async x MainActor exists for consumers.
ConsumerFamilyComplete == u = 0 =>
  \A t, y, m \in BOOLEAN : \E c \in Fam("Consumer") : Flags(c) = <<t, y, m, FALSE>>

\* The conversion order (plain -> throws / async -> async throws) is a partial order with a bottom.
EffectOrderIsPartialOrder == u = 0 =>
  \A f \in {"Consumer", "Closure", "Producer"} :
    /\ \A a \in Fam(f) : Convertible(a, a)
    /\ \A a, b \in Fam(f) : (Convertible(a, b) /\ Convertible(b, a)) => a = b
    /\ \A a, b, c \in Fam(f) : (Convertible(a, b) /\ Convertible(b, c)) => Convertible(a, c)
PlainIsBottomOfEffects == u = 0 =>
  \A f \in {"Consumer", "Closure", "Producer"} :
    \A a \in Fam(f) : (~a.main /\ ~a.snd) =>
      \E p \in Fam(f) : p.name \in {"Consumer", "Closure", "Producer"} /\ Convertible(p, a)
=============================================================================
