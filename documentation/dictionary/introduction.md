## Dictionary Introduction

### The Logic and Notation of Link Grammars

#### The basic Idea

Think of words as blocks with connectors coming out. There are
different types of connectors; connectors may also point to the right
or to the left. A left-pointing connector connects with a
right-pointing connector of the same type on another word. The two
connectors together form a "link". Right-pointing connectors are
labeled "+", left-pointing connectors are labeled "-". Words have
rules about how their connectors can be connected up, that is, rules
about what would constitute a valid use of that word. A valid sentence
is one in which all the words present are used in a way which is valid
according to their rules, and which also satisfies certain global
rules.

#### Connectors and Disjuncts

A simple dictionary entry would look like this:

```
blah: A+;
```

This means that if the word "blah" is used in a sentence, it must form
an `A` link with another word; that is, there must be another word to
the right of it with an `A-` connector. Otherwise the sentence is not
valid. The expression following the colon is the "linking requirement"
for the word.

A word may have more than one connector that has to be connected. This
would be notated as:

```
blah: A+ & B+;
```

A word may have a rule that either one of two (or one of several)
connectors can be used, but exactly one must be used. In the
dictionary, we notate this as:

```
blah: A+ or B-;
```

This means that if the word can make either an `A` link to the right,
or a `B` link to the left, its use in the sentence is valid; but it
must make one or the other, and it can not make both.

These rules can be combined. For example, consider the following
notation:

```
blah: A+ or (B- & C+);
```

This means that the word must make either an `A` link to the right, or
a `B` link to the left and a `C` link to the right. No other
combination will be valid.

Such expressions can be nested without limit, such as

```
blah: (A+ or B-) & ((C- & A+ & (D- or E-)) or F+);
```

Although the `&` and `or` symbols are suggestive, they are NOT Boolean
operators! The expressions do not combine to make a Boolean algebra!
In particular, one of the two Boolean distributive laws does not
apply; one can distribute `&` over `or`, but not the other way. So,
one has that `A+ & (B- or C+)` is equal to `(A+ & B-) or (A+ &
C+)`. For a given word, either the disjunct `(A+ & B-)` must be
satisfied, or the disjunct `(A+ & C+)` must be satisfied. One and only
one of these can be satisfied; not both. One cannot distribute the
other way around: `A+ or (B- & C+)` has a completely different meaning
than `(A+ or B-) & (A+ or C+)`.

##### Connector ordering.

The ordering of elements in the "connector expression" is
important. What that dictates is the relative closeness of the words
that are being connected to. The further to the left the connector
name, the closer the connection must be. For example,

```
blah: A+ & B+;
```

This means that "blah" must make an `A` link to the right and a `B`
link to the right, and the word it makes the `A` link with must be
closer than the word it makes the `B` link with.

This only pertains, however, to connections in the same direction. For
connectors pointing in opposite directions, the ordering is
irrelevant. Therefore:

```
blah: A+ & B-;
```

Means exactly the same thing as:

```
blah: B- & A+;
```

For that matter,

```
blah: A- & B+ & C+ & D-;
```

means exactly the same thing as

```
blah: B+ & C+ & A- & D-;
```

For `or` expressions, such as `A+ or B+`, the ordering of the elements
is irrelevant.

##### Connector Subscripts

In general, a connector may only link to another one with the same
name, i.e., the same string of capital letters. However, there is
another way of controlling how connectors may link to each other,
using *connector subscripts*. A subscript is a lower-case letter
following a connector-name, like `Ss+`. An `Ss+` connector can connect
with an unspecified `S-` connector, or an `Ss-` connector, but not
with an `Sp-` connector.

Subscripts provide a very useful mechanism for enforcing agreement in
number, tense, gender and other inflections. Thus, in the above
example, the lower-case `s` can be interpreted as 'singular', and `p`
as 'plural'. Decorating the `S` connector type with the lower-case `s`
or `p` can force number agreement where it is important, and ignore it
(by means of wild-card) where its not. Thus, for example, in English,
singular common nouns carry the connector `Ss+`; the verb "is" carries
`Ss-` and "are" carries `Sp-`. This clash of subscripts blocks or
prevents the parse of "a book are" but allows "a book is". This
mechanism can be used to enforce both local and very long-range
agreement in inflections.

Connector types may have multiple subscript characters, such as
`Spa+`. An `Spa+` can connect with an `S-`, an `Sp-`, or an `Spa-`,
but not with an `Ss-` or an `Ssa-` or an `Spb-`. In this example, `a`
and `b` might be used to represent different genders or perhaps
different conjugations or declensions.

An `*` subscript type is a "wildcard character" that can connect with
any character. What's more, every connector string should be
visualized as being infinite-length, padded to the right with
`*`'s. Therefore, an `S*+` is exactly the same as an `S+`. An `S*a+`
can connect with an `S-`, an `Ss-`, an `Sp-`, or an `Ssa-`, but not
with an `Ssb-`. Similarly, `S**a+` can connect with `Sx-`, but not
with `Sxyb-`.

##### Type Theory; Equivalence to categorical grammars

These expressions do form an algebraic structure; formally, it is a
non-symmetric compact closed monoid. If the act of parsing is treated
as a transformation (that is, as an arrow between parse states), then
*Link Grammar* forms a non-symmetric compact closed monoidal
category. This essentially implies that *Link Grammar* is a form of
Lambek calculus, and is a kind of categorial grammar or pregroup
grammar. The notation, however, differs; each link type in Link
Grammar should be understood as a simple, short name for the far more
complex-looking types of a typical categorial grammar; there are no
type constructors in *Link Grammar*, and so the link types are treated
as fundamental, atomic types. In fact, they can be mapped to the
constructed types of Lambek calculus in a more-or-less
straight-forward way. There is no loss of generality in doing this;
indeed, *Link Gramar* link types are considerably easier to read,
remember and work with than the typical expressions used in categorial
grammars. Here, the word 'type' should be understood in the sense of
'type' in 'type theory'.

##### Optional connectors

Some connectors are optional; this is notated with curly brackets. For
example:

```
blah: A+ & {B+};
```

This means the word must make an `A` link to the right, and it can
make a `B` link to the right but does not have to. Curly brackets can
also be put around complex expressions, like:

```
blah: (A+ or B+) & {C- & (D+ or E-)};
```

An equivalent way of writing an optional expression like `{X-}` is
`(X- or ())`. This can be useful, since it allows a cost to be put on
the no-link option, so that the use of a link is prefered over it's
absence. We will describe **the cost system** later.

##### Multi-connectors

A word can also make an indefinite number of links of the same type to
other words. For this, we use the "multi-connector" symbol `@`. For
instance, the word below could make any number of `F` links to words to
the right (but is not required to make any).

```
blah: (A+ or B+) & {C- & (D+ or E-)} & {@F+};
```

If a word has `@A+`, with no curly brackets, it is required to make at
least one `A+` link to the right; any others are optional.

##### Free word order: Bi-directional connectors

Some languages, such as Lithuanian and Turkish, allow an almost free
word order, as the meaning can be infered from the morphology. To make
it easier to write dictionaries for such languages, the special `$`
direction may be used to indicate that the connector can connect to
either the left or right. This is merely a notational short-hand, so
that:

```
A$
```

is completely equivalent to:

```
(A+ or A-)
```

As currently implemented, the first expression is simply expanded into
the second during dictionary load. These bi-directional connectors can
be used anywhere that a normal directional connector is allowed.

##### Free word order: commutative AND

For free-word-order languages, writing expressions can become quite
tedious, when using the non-commuting & operator. Thus, the dictionary
also supports a symmetric, commutative-AND operator, denoted by
`^`. Using this operator, the entry

```
blah: A+ ^ B+;
```

means exactly the same thing as

```
blah: (A+ & B+) or (B+ & A+);
```

It is particularly convenient to use with the `$` direction indicator,
that is, as `A$ ^ B$` so that `A` and `B` can connect either to the
left or the right, as their order is reversed.

The commutation is local; the range of the commute is limited by
parenthesis, as usual. Thus, for the example below, the `C+` connector
does not commute:

```
blah: (A+ ^ B+) & C+;
```

This means exactly the same thing as

```
blah: ((A+ & B+) or (B+ & A+)) & C+;
```

##### Free word order; Heads and Tails

Free word order languages introduce another tehcnical difficulty: to
be meaningful, an explicit head and dependent must be declared. So,
for example, in standard dependency grammar, nouns are considered to
dominate the adjectives that modify them. Thus, the noun should be
considered the head, and the adjective the dependent. This
directionality can be indicated with the `h` and `d` prefixes to the
connectors. The prefixes are not required to be used. However, if both
appear, then `h` can only connect to `d`.

Thus, for example, `hA$` can connect to `dA$`, to `A$`, to `dA+` or to
`A+` but it cannot connect to `hA$` or to `hA-` or to `hA+`. The first
case holds, because `h` can mate with `d`, and both link types are
`A`, and both are bidirectional. The second case holds becase `A$` does
not indicate whether it wants to be a head or a dependent, thus it can
be either; to actually connect, it is assumed to be a dependent.

The dependency relation is then drawn with arrows. Thus, for example,
in Lithuanian, "mažas" means "small", and "namas" means "house". It is
equally grammatically valid to write "mažas namas" and "namas mažas";
however, we want to indicate which is the head (the noun), and which
is the dependent (the adjective). Thus, the Lithuanian dictionary
contains:

```
namas: hA$ ...;
mažas: dA$ ...;
```

and the parse fragments for these two cases would be drawn as:

```
       +<--A<--+
       |       |
     mažas   namas
```

and

```
       +-->A-->+
       |       |
     namas   mažas
```

In both cases, the arrows point from the head to the dependent. If
either the h or the d is missing, then the corresponding arrowhead
will not be drawn.

The English dictionary mostly does not use this dependency markup,
although there are a few unusual cases where this can help clarify the
proper construction. Consistent use in the English dict would also
allows the `S` and `SI` links to be folded into one, instead of being
treated distinctly. Again, this dependency markup is a convenience,
rather than a fundamental aspect of the link-grammar theory. So, in
Lithuation, the A link could have been replaced by `AL` and `AR` links
to indicate that the head is on the left or right, respectively; but
this would double the number of link types, and make dictionary
authoring tedious. The dependency mechanism is essentially another
convenient short-hand.

##### Dictionary entries

A dictionary entry thus consists of a word, followed by a colon,
followed by a connector expression, followed by a semi-colon. The
dictionary consists of a series of such entries. Any number of words
can be put in a list, separated by spaces; they will then all possess
the linking requirement that follows:

```
blah blee blay: A+;
```

A connector name must consist of one or more capital letters (any
number may be used), followed by any number of lower-case letters,
mixed with the wild-card character `*`, and terminated by `+`, `-` or
`$`.

##### Disjuncts

We should mention one concept here that plays an important role in the
internal workings of the parser: the *disjunct*. A disjunct is a set
of connector types that constitutes a legal use of a word. The
dictionary expression for any word can be represented as a set of
disjuncts. If a word has the following expression:

```
blah: {C-} & (A+ or B+);
```

then it has the following four disjuncts:

```
C- A+
A+
C- B+
B+
```

These disjuncts represent all the legal uses of the word "blah". Using
`C-` and `A+` is a legal use of the word; using `A+` and `B+` is not.

Disjuncts play an important role in the internal workings of the
parser. During the parse, the set of disjuncts is continually pruned
down to a smaller and smaller set, until, for the final linkage, only
a single disjunct is chosen for any given word.

The final chosen disjunct can be viewed as a very find-grained
part-of-speech tag for that word. Thus, for example, once a parse is
completed, if a word has the disjunct `S- O+` on it, then it is
absolutely certain that it is not only a verb, but that it is a
transitive verb. If `K+` also appears in the disjunct, then it is a
transitive verb taking a particle.

Fine-grained part-of-speech tags correlate strongly with word senses,
they do so better than the course-grained parts of speech
(n. v. adj. adv.) commonly used to present word meanings in ordinary
dictionaries. Thus, the fine-grained part-of-speech can be used to
suggest likely word-senses, simply based on the syntactic structure of
a sentence. This is explored in greater detail in (Linas Vepstas,
2009, "Correlating WordNet senses with Link Grammar Disjuncts using
the Mihalcea algorithm", OpenCog Project, unpublished.) which shows
how WordNet senses can be correlated with disjuncts.

##### The Cost System

It is often the case that there are multiple different parses for a
sentence; some of the parses are far more likely to be correct than
others. To capture this notion of likelihood or parse ranking, *Link
Grammar* has a cost system. Different connectors or disjuncts can be
assigned different costs; the parse with the lowest cost is the most
likely parse. Roughly speaking, costs can be understood as minus the
logarithm of the probability of the use of a connector or disjunct;
they can be though of as forming part of the entropy or mutual
information of a parse. Because of the local nature of links, costs
can also be thought of as the weights of a Markov model describing a
sentence.

The cost system uses square brackets (`[` and `]`). If a connector, or
a series of connectors, is surrounded by square brackets, it is
assigned a cost. The amount of cost is equal to the number of square
brackets on each side: thus `[A+]` will receive a cost of 1.0, while
`[[A+]]` will receive a cost of 2.0; etc.. To specify a floating-point
value for the cost, follow the square bracket by the desired
floating-point cost: thus `[A+]0.1234` gives the connector `A+` a cost
of 0.1234. Entire expressions can be given a cost: thus
`[(A+ & B-) or (C+ & D+)]3.14159` gives each of the two disjuncts `(A+
& B-)` and `(C+ & D+)` a cost of 3.14159. Note that costs are
inherently commutative over the conjunction `&` while being
distributive over the disjunction `or`. Thus, `([A+]1.1 & B+)` is
equivalent to `[A+ & B+]1.1` while `[C+ or D+]0.3` is the same as
`([C+]0.3 or [D+]0.3)`

The parser sums up the total cost of all disjuncts used in a parse to
obtain a total cost for that given parse of a sentence. Parses are
then printed in ascending cost order, as the lowest-cost parses are
the most likely. (It is this additivity of the costs that makes it
convenient to think of them as the logarithms of probabilities;
probabilities multiply, logs add). Unlikely grammatical usages are
usually given a cost of 1 or 2. Fractional costs are primarily used to
disambiguate between nearly equivalent parses, ideally, so that the
most likely parse is always first.

For the English dictionary, only connectors with a cost of less than
2.9 are considered in normal parsing; connectors with a cost of 3 or
greater are considered only in "panic mode". Panic mode is described
later. The Russian dictionary uses a different cutoff, to accomodate
the handling of morphology.

In addition to the disjunct cost, two other costs are maintained: the
total length of all of the links, and the total number of words that
failed to connect in any way to the parse. It is known from
psycho-linguistic research that sentences with short links are more
easily understood than those with long links; thus, if two sentences
have the same cost, then the one with the shorter link-length is
printed first.

The failure to use a word in a parse can be considered to be a parse
failure. Ideally, all words participate in a parse, but if this is not
possible, then parses which use more words are prefered over those
that use fewer.

This information is indicated in the cost vector shown above the
linkage:

```
Unique linkage, cost vector = (UNUSED=1 DIS=0.05 LEN=1)
```

`DIS` is the connector cost or disjunct cost for the linkage (the `[]`
system explained above), while `LEN` is the total length of all links
in the sentence (minus the number of words -- note, the total link
length can never be less than the number of words). `UNUSED` indicates
the number of unused words. Null links are described later.

#### Global Rules

As well as these "word rules", which are specified in the dictionary,
there are two other global rules which control how words can be
connected.

First of all, links can not cross. For example, the following way of
connecting these four words (connecting "cat" to "dog" and "horse" to
"fish") would be illegal. The parser simply will not find such
linkages.

```

                       +------------+
                 +---- | -----+     |
                 |     |      |     |
                cat   horse  dog  fish
```

This is the "crossing-links" (or "planarity" or "projectivity")
rule.

Secondly, all the words in a sentence must be indirectly connected to
each other. Therefore the following way of connecting these four words
would be illegal (if it was the entire linkage).

```
                 +-----+     +----+
                 |     |     |    |
                cat  horse  dog  fish
```

This is the "connectivity" rule.

A valid sentence is therefore one which can be linked up in a way that

1. all the words are used in a way that satisfies their linking requirements;
2. the crossing-links and connectivity rules are not violated.

The no-crossing rule is enforced because such a rule appears to be
psychologically correct for all languages; this is a well-studied
phenomenon, and is confirmed in experimental linguistics; see, for
example, the references below for reviews.

- Havelka, J. (2007). Beyond projectivity: multilingual evaluation of constraints and measures on non-projective structures. In: Proceedings of the 45th Annual Meeting of the Association of Computational Linguistics (ACL-07): 608-615. Prague, Czech Republic: Association for Computational Linguistics.
- Temperley, D. (2008). Dependency length minimization in natural and artificial languages. Journal of Quantitative Linguistics, 15(3):256-282.
- Gibson, E. (2000). The dependency locality theory: A distance-based theory of linguistic complexity. In Marantz, A., Miyashita, Y., and O'Neil, W., editors, Image, Language, Brain. Papers from the first Mind Articulation Project Symposium. MIT Press, Cambridge, MA.
- Ramon Ferrer-i-Cancho (2013) “Hubiness, length, crossings and their relationships in dependency trees”, ArXiv 1304.4086

Nevertheless, there are various rare cases where it seems that
grammatical structure could be better described by crossing
links. Allowing these and making productive use of them is a work item
for some future version ofthe parser.

#### Link Grammar in Relation to Other Systems

The structure assigned to a sentence by a link grammar is fairly
unique, although it can be considered to be a type of dependency
grammar. It can be related to categorical grammars in a direct way, as
shown below. Rather than thinking in terms of syntactic functions
(like subject or object) or constituents (like "verb phrase"), one
must think in terms of relationships between pairs of words. In the
sentence below, for example, there is an `S` ("subject") relation
between "dog" and "has"; a `PP` (past-participle) relationship between
"has" and "gone"; and a `D` (determiner) relation between "the" and
"dog". (Ignore the lower-case letters for the moment; they will be
explained below.)

```
       +-----Ds-----+
       |     +---A--+-Ss-+-PP-+
       |     |      |    |    |
      the black.a dog.n has gone
```

Where possible, we try to give link-types names that have mnemonic
significance in this way.

It may be seen, however, that parts of speech, syntactic functions,
and constituents may be recovered from a link structure rather
easily. For example, whatever word is on the left end of an `S` link
is the subject of a clause (or the head word of the subject phrase);
whatever is on the right end is the finite verb; whatever is on the
left-end of a `D` link is a determiner; etc..

The disjunct that is actually used during a parse is best understood
as a very fine-grained part of speech. Thus in the above example,
`dog: A- & Ds- & Ss+;` should be understood as stating that "dog" is a
singular noun that must take a determiner, and must be modified by an
adjective, and can only be used as a subject of a
sentence. Coarse-grained part-of-speech tags can be obtained by
ignoring some of these more minor details.

Most nouns, verbs, and adjectives in the dictionary are subscripted in
a POS-like way, with `.n`, `.v`, or `.a`. Although these subscripts
can be treated as POS tags, indicating syntactic categories, the
indication is not necessarily always complete or unambiguous. For high
accuracy and complete coverage, the POS is best derived from the
disjunct.

The constituent structure of sentences, while not absolutely explicit,
is also quite "close to the surface" in linkage structures. This
requires some explanation. Imagine a linkage as a graph through which
paths can be traced, similar to a street map. Constituents can be
defined as sets of words which can be reached from certain links,
tracing in a certain direction. For example, a verb phrase is
everything reachable from an `S` link, tracing to the right − that is,
not tracing through the left end of the `S` link itself. In the
sentence below, "have changed during the past 3 1/2 years" is a verb
phrase, since all these words can be reached from an `S` link (between
"addresses" and "have") going to the right. "Would be an
administrative nightmare" is **not** part of this verb phrase since
these words cannot be reached from the S link in question, except by
tracing through the left end of the link ("addresses"). For noun
phrases there are several possibilities. Anything that can be reached
from an O link tracing right is an NP, (such as "an administrative
nightmare") as is anything reachable from a J link tracing right ("the
two million customers whose addresses have changed during the past 3
1/2 years").

```
  +---------------------------------------------------------------------------
  |                                                      +--------------------
  +--------------Wd--------------+                       +---------------Opn--
  |   +------------Ds------------+                       |             +----DD
  |   |       +----G----+---AN---+----Ss---+--TH-+---Ce--+----K---+    |   +--
  |   |       |         |        |         |     |       |        |    |   |
///// a Commonwealth Edison spokesman.n said.v that tracking.g down.e the two


----------------------------Xp---------------------------------------------
---------------------------------Ss*g--------------------------------------
-------------+                                            +-----------Jp---
---+         |                                            |    +-----DD----
NN-+---Dmc---+---Mr---+--Dmcw--+----Sp---+---PP--+---MVp--+    +--L--+   +N
   |         |        |        |         |       |        |    |     |   |
million customers.n whose addresses.n have.v changed.v during the past.a 3


---------------------------------------------------------+
---------------+                                         |
-------+       |      +------------Ost------------+      |
-+     |       |      |   +-----------Ds----------+      |
N+-Dmc-+       +--Ix--+   |         +------A------+      |
 |     |       |      |   |         |             |      |
1/2 years.n would.v be.v an administrative.a nightmare.n .
```

With version 4.0, we have incorporated a system for deriving a
traditional constituent representation of a sentence from a
linkage. Click here for more information about this; you can
experiment with this system at the online demo page.

#### Link Grammar In Relation To Categorical Grammars

Link grammar appears to be isomorphic to categorial grammars (Lambek
calculus), in that there there appears to be a direct and immediate
way of translating from the one to the other (although a formal,
rigorous proof is currrently lacking). In a categorical grammar, words
are decorated with links, in a fashion more or less identical to that
of link-grammar. The primary difference is that, in categorical
grammars, the connector types are written as complex, compound types
(in the sense of "type theory" or "monoidal category"), such as `NP/N`
or `N/N` or `(NP\S)/NP`. In link-grammar, these compund types are
replaced by shorter, more human-friendly abbreviations: thus, for
example, the `NP/N` link type is just the `D` link type in
link-grammar, linking a determiner to a noun. The `N/N` link type is
called `A` in link grammar: it links adjectives to nouns. The
`(NP\S)/NP` link type is characteristic of a transitive verb,
corresponding to `S- & O+` in link-grammar.

A particularly simple way of seeing the correspondance can be obtained
by comparing the puzzle-pieces diagrams given in the original
link-grammar publications to the puzzle-piece diagrams popularized by
Bob Coecke: the diagrams are essentially identical, and thus provide
an easy, diagrammatic "proof" of the equivalence between link-grammar
and grammars based on monoidal categories. See, for example, the
diagram in:

- New Scientist Weekly (11 December 2010) "Quantum links let computers
  read", page 10. ([link](http://www.cs.ox.ac.uk/people/bob.coecke/NewScientist.pdf))
- Dimitri Kartsaklis, Mehrnoosh Sadrzadeh, Stephen Pulman, Bob Coecke,
  "Reasoning about Meaning in Natural Language with Compact Closed
  Categories and Frobenius Algebras" (2014) arXiv:1401.5980 [cs.CL]

### Using the Parser

#### Running Version 5

To run version 5 of the parser, you must first unpack the link-grammar
sources, and then follow the README file for specific information on
how to compile and install.

To actually run the program along with the dictionary (and related
files) that we provide, type "./link-parser". The parser will then
give you a prompt:

```
          linkparser>
```

Type in a sentence, and press `RETURN`. The parser will tell you whether
that sentence has a valid linkage or linkages, given the dictionary it
is using, and it will output the linkage that it finds, showing the
words that are linked together and the type of link between them. The
parser will then prompt you for another sentence. To exit the parser,
type `ctrl-D`.

For each sentence,the parser will do an exhaustive search for
linkages; it will generate all valid linkages. It will begin by
displaying the lowest-cost linkage it finds. Other linkages may then
be seen, one at a time, by pressing `RETURN`. (The ordering of the
output is determined by the cost system.) If the parser cannot find
any complete linkages of a sentence, it may simply stop and say "No
complete linkages found"; or it may try to parse the sentence,
ignoring some of the words. This depends on whether "null-links" are
in use.

A large number of options control the behaviour of the parser. These
can be listed by typing `!variables` at the prompt. General help is
obtained by typing `!help`.

#### Using Other Dictionaries

The more general way of running the parser is by typing

```
         ./link-parser [dictionary]
```

where "dictionary" may be any of:

- An absolute file-system path to a dictionary:
  e.g. `/usr/share/link-grammar/en` or `/usr/local/share/link-grammar/ru`
- A relative file-system path to a dictionary:
  e.g. `./my_home_dir/link-grammar-4.3.5/data/en`
- The name of a language, e.g. `en`. In this case, the default
  dictionary install location will be searched for dictionaries for
  the language `en`.

Dictionaries for the English (en) and Russian (ru) are complete and
extensive. The Arabic (ar) and Persian (fa) dictionaries offer fairly
comprehensive coverage. A prototype dictionary for German (de) exists,
and there are proof-of-concept dictionaries for Hebrew (he),
Indonesian (id), Lithuanian (lt), Turkish (tr) and Vietnamese (vn).

#### The Api

We have developed an API for designing customized versions of the
parser and incorporating them into applications. It is important to
realize that version 5.0 of the parser is just one way of configuring
the API. In the following sections, we discuss many features of
version 5.0 of the parser. Some of these features can be modified by
editing the dictionary, as we explain here. Other features can be
modified by configuring the API differently. For more about the API,
see our API documentation.

### General Features of the Parser

#### Macros

It is possible to define a single symbol as a longer connector
expression, and then use that symbol to refer to the longer expression
in the dictionary. To do this, simply choose a name for the longer
expression, and surround it with angle brackets `<symbol>`. Then treat
it like a word in the dictionary; list the name, then a colon, then
the connector expression that it should stand for. For example, we
define `<noun-main-s>` in the dictionary as follows:

```
    <noun-main-s>: (Ss+ & <CLAUSE>) or SIs- or Js- or Os- or
        ({[Bsj+]} & Xd- & Xc+ & MX-);
```

We then use this symbol in many other actual word definitions.

We use many of these macros in the dictionary, to reduce redundancy;
there are many connector expressions that are used over and over in
longer expressions. Here are a few common ones:

- `<noun-main-...>` the "main" connectors for nouns, used to link
  them to the rest of the sentence (as subject, object, etc).
- `<noun-sub-...>` the "sub" connectors for nouns, used to link them
  to modifiers like prepositional phrases and relative clauses.
- `<verb-...>` These macros are for verbs; they distinguish different
  forms of the same verb. That is, they contain connector types like
  `S-`, `PP-`, etc. that distinguish different forms of the same
  verb. `<verb-s>` is for singular verbs, `<verb-pp>` for past
  participles, `<verb-sp,pp`> for forms which are both simple past and
  past participle, etc..
- `<vc-...>` These macros are for verb complements; they stand for
  different complement expressions. Some verbs can connect to a direct
  object, using `O+`; some can connect to an infinitive verb, using
  `TO+`; and so on.

#### Word-Files

The most basic way to write the dictionary is to list all the words in
a particular category, followed by a colon, followed by their
connector expression. There is another way, however. One can put all
the words in a category in a file, choose a name for the file, and put
that filename in the dictionary in place of the list of words. When
listed in the dictionary, the filename must be preceded by a slash
`/`.

Here are the word files that are in use at the moment:

- `words.n.1` singular countable (i.e. not mass) nouns
- `words.n.2.s` plural nouns ending in "s"
- `words.n.2.x` plural nouns not ending in "s"
- `words.n.3` mass nouns
- `words.n.4` nouns that may be mass or countable
- `words.n.p` proper names that are also ordinary words when not
  capitalized (see Section 3.1 for explanation)
- `words.n.t` nouns that can be used as titles, like "president"

(In the following verb files, the final number indicates the verb
form. `.1` is for infinitive-plural forms, `.2` is for singular forms,
`.3` is for simple-past / past-participle forms, `.4` is for present
participles, `.5` is for gerunds. On intransitive verbs, the present
participle and gerund expression are combined into a single dictionary
entry.)

- `words.v.1.(1-4)` intransitive verbs
- `words.v.1.p` special two-word passives ("lied_to_", "paid_for")
- `words.v.2.(1-5)` optionally transitive verbs
- `words.v.4.(1-5)` transitive verbs
- `words.v.5.(1-4)` intransitive verbs that may form two-word verbs
  with particles like "up" and "out"
- `words.v.6.(1-5)` optionally transitive verbs that may form two-word
  verbs
- `words.v.8.(1-5)` transitive verbs that may form two-word verbs
- `words.v.10.(1-4)` verbs that may be used in quotation expressions,
  like "said" ("John is here, he said").
- `words.adj.1` ordinary adjectives, with no special complements
- `words.adj.2` ordinary comparative adjectives (e.g. "bigger")
- `words.adj.3` ordinary superlative adjectives (e.g. "biggest")
- `words.adv.1` ordinary manner adverbs ("quickly", "angrily")
- `words.adv.2` ordinary clausal adverbs ("fortunately")
- `words.adv.3` adverbs like "chemically"
- `words.y` common year numbers ("1990", etc.)
- `words.s` US state names and abbreviations

#### Word Subscripts

A single word can be given several different dictionary entries. To do
this, the entries must be distinguished by giving the words different
subscripts. Words may be followed by a subscript such as `.n`. For
example:

```
    run.n: A+ or B+...
    run.v: C+ or D+...
```

If a word is listed more than once with the same subscript, or if it
is listed once with a subscript and once without, the parser will
generate a warning message and will ignore one of the entries.

The parser starts at the right end of every string of characters. Any
sequence of ASCII letters, possibly with a dash, to the right of the
right-most period in the string will be considered the
subscript. (Periods at the end of a string are simply considered part
of the string.)

In searching for linkages, the parser will consider each entry for the
word as a different word, and will generate all linkages found for all
entries. The subscript is shown in the display, thus indicating which
entry the parser chose for a particular linkage.

The main word subscripts we use are `.n` for nouns, `.v` for verbs,
and `.a` for adjectives. Most nouns, verbs, and adjectives are
subscripted in this way. Certain other subscripts are used to
distinguish two forms of the same word; some subscripts are used to
refine a linguistic category for a word. A list of the most commonly
used subscripts is given below.

Although the subscripts can be used as part-of-speech indicators, not
all words are subscripted, and some subscripts are ambiguous. A robust
POS-tagging strategy based in link-grammar would use subscripts in
combination with the fine-graned part-of-speech that a disjunct
represents.

```
.a
    Adjective
.a-c
    Adjective, comparative/relative
.a-s
    Adjective, superlative
.b
    Given names that can be masculine or feminine
.c
    Currency names
.d
    (Not used/not defined)
.e
    Adverbs
.eq .eqn
    Binary operators e.g. 2 + 2
.f
    Given names that are always feminine
.g
    Gerund
.h
    (Not used/not defined)
.i
    Misc usage, mostly pertaining to units, lengths, times.
.id
    Identifiers: e.g. "vitamin A"
.ij
    Interjections
.j
    Conjunctions.
.j-a
    Conjunctions -- adjectives: "the black and white cat"
.j-c
    Conjunctions -- comparatives: "he is bigger, and badder, than the pope."
.j-g
    Conjunctions - proper names: e.g. "The Great Southern and Western Railroad"
.j-m
    Conjunctions -- post-nominal modifiers
.j-n
    Conjunctions -- nouns: "Jack and Jill"
.j-o
    Conjunctions -- ditransitive e.g. "I gave Bob a doll and Mary a gun"
.j-opnr
    Clause openers -- e.g. "but you are wrong!"
.j-q
    Conjunctions -- Conjoined question words.
.j-r
    Conjunctions -- adverbs/prepositional phrases e.g. "the man for whom and with whom ..."
.j-ru
    Conjunctions -- interval e.g. "two to threefold more abundant"
.j-sum
    Conjunctions -- numerical sums: e.g. "It's a hundred and two in the shade."
.j-v
    Conjunctions -- verbs: "sang and danced"
.k
    (Not used/not defined)
.l
    Location (cities, states, towns, etc.)
.m
    Given names that are always masculine
.n
    Noun
.n-u
    Noun, uncountable (mass noun)
.o
    Organizations (corporations)
.ord
    Ordinal numbers e.g. first second third
.p
    Plural count nouns
.q
    verb, Question-related or paraphrasing
.q-d
    verb, past tense
.r
    Prepositions and related
.s
    Singular, mass or count nouns
.t
    Titles, roles. e.g. President, Captain
.ti
    Time, date e.g. AM, PM, December 2nd
.tz
    Timezones e.g. CDT, UTC
.u
    Units of measurement
.v
    Verb
.v-d
    Verb, past tense
.w
    Verb
.w-d
    Verb, past tense
.x
    Prefix abbreviations, e.g. Mr., Dr., Mrs.
.y
    Postfix abbreviations, e.g. Ave., St., Co.
.z
    (Not used/not defined)
```

The above is not a complete list; other, less frequently used
subscripts occur in the dictionary. Some of these are used in an
ad-hoc, inconsistent manner to disambiguate words. Such ad-hoc usage
is subject to change, whereas the above usage is maintained over
different versions of the dictionary. Over time, the dictionary has
evolved (and will continue to evolve) in such a way that more suffixes
are introduced to define more fine-grained morphological and semantic
categories.

#### Batch-Mode

It is possible to make a file of sentences, and then run them through
the parser all at once. Simply create a file, with one sentence on
each line. When running the parser, type

```
    parse [dictionary name] < [filename]
```

When inputting a file of sentences, it is sometimes useful to use
another feature known as "batch-mode". In this mode the user indicates
in the input file which sentences should be rejected, and which should
be accepted; the parser then notifies the user when its judgments
differ. To say that the parser "rejects" a sentence means that it does
not find any linkages without null-links. (Batch-mode does not allow
null-links; the `!batch` command automatically turns null-links off.)
To prepare a file for use in batch-mode, put `!batch` at the top of
the file. Then, for each sentence that should be rejected, precede the
sentence with `*` in the file. If it should be accepted, precede it
with nothing. After processing a batch file, the parser will then
print the number of errors in the file: i.e., the number of sentences
on which its judgments differ with the judgments indicated by the
symbols.

The symbol `:` can also be used at the beginning of a line. This means
"linkage should be found with non-zero cost". If a linkage is found
with zero cost, or no linkage is found, an error will be reported. (An
absence of symbol means "linkage should be found, either with cost or
without".)

When running batch-mode, the parser will ordinarily output only the
number of errors it makes. Thus it is primarily useful for checking
sentences, to see if a particular dictionary produce the desired
results (or to make sure that no earlier work has been broken by
recent changes). If one begins the batch file with the command
`!echo`, the parser will also output the sentences as it parses them,
as well as display information for the sentences on which its
judgments disagree with the user's.

Our github directory contains several large batch-files; the three
most important ones are `corpus-basic.batch`, `corpus-fixes.batch` and
`corpus-fix-long.batch`. The `corpus-basic.batch` file contains about
900 sentences which systematically test many features of the
parser. Many sentences are incorrect, and are marked with `*`. With
version 4.1, this file parses with 0 errors. More recent parser
versions expand parse coverage to a larger set of sentences, in part
by loosening restrictions on allowed constructions. This has caused
approximately 50 'ungrammatical' sentences to be accepted, albeit some
rather unusual parses: for example, an ungrammatical sentence with the
personal pronoun "I" might not make sense, but can be parsed when "I"
is considered to be a roman numeral: e.g. "Pope Pious I"

The `corpus-fixes.batch` contains another 4 thousand sentences, many
of which were not parsed by the 4.0 parser, but most of which are
handled correctly by later versions. Other corpus-batch files contain
samples from biotech, Voice-of-America and the like. Other languages
contain similarly-named batch files as well.

##### Unit tests

The batch file can be thought of as a loose kind of unit test. A
stricter, proper unit test, testing the parser, the tokenization
stage, and various parts of the API, can be found in the python
bindings directory. Specifically, it is in
`./bindings/python-examples/tests.py`. See the accompanying README file
for more information.

#### Commands And Variables

It is possible to modify the running of the parser in various ways,
while running it, by typing in certain commands. The basic commands
can be seen by typing `!help`. Others are listed under
`!variables`. Many of these are self-explanatory. For example,
`!width` changes the width of the parser display. Other commands
relate to speed and robustness features.

A few commands deserve special mention. One useful command is
`!![word]`. This queries the parser for information about a particular
word. The parser will output list any entries of the word, with their
word subscripts, the word-files in which they appear, if any, and the
number of disjuncts on each word. (A disjunct is a combination of
connectors which constitutes a legal use of the word.) Multiple
entries of a word will be listed with their word subscripts.

The `!verbosity` command controls the amount of information that is
displayed. With `!verbosity=1` (the default), information such as the
following is shown:

```
linkparser> the quick brown fox jumped over the lazy dog
++++Time                                          0.04 seconds (0.04 total)
Found 2 linkages (2 had no P.P. violations)
  Linkage 1, cost vector = (UNUSED=0 DIS=0 AND=0 LEN=18)

 +---------Ds---------+              +-------Js------+
 |     +-------A------+              |   +-----Ds----+
 |     |       +---A--+---Ss--+--MVp-+   |     +--A--+
 |     |       |      |       |      |   |     |     |
the quick.a brown.a fox.n jumped.v over the lazy.a dog.n

Press RETURN for the next linkage.
linkparser>
```

With `verbosity=0`, no information is shown except for the graphic
linkage display. With verbosity set at 2 or 3, information is shown
about the individual stages of parsing the sentence. (Information is
also shown about the constituent derivation process, if this is being
done.) If one wants to suppress the graphic display as well, this can
be done with the command "!graphics". (This can be useful it one wants
to have only the constituent bracketing as output; in that case, type
"!verbosity=0", "!graphics", and "!constituents=1 (or 2)".

### Special Features of the Dictionary

#### Capitalization

The parser respects capitalization: that is, the use of upper- and
lower-case letters. If a string is listed in the dictionary beginning
with a capital letter, then an input word will match only it if it has
the same capitalization. (The same with strings with capital letters
in the middle, although this is probably of little use.) However,
there are a few special cases here.

Any word which is capitalized but is not listed in the dictionary is
assigned to the special dictionary entry `CAPITALIZED_WORDS`. This
dictionary entry is designed to handle proper (given) names. There is
another entry, `PL_CAPITALIZED_WORDS`, for capitalized words ending in
an "s" -- this allows parses that treat the capitalized word as a
plural. The guessing and assignment of words to these categories is
controlled by the `4.0.regex` file, which uses regular expressions to
identify unknown word types. It includes a pattern for recognizing
roman numerals, Latinate nouns and adjectives (common in biomedical
texts) and the like; this is described in greater detail below, under
"Unknown Words".

A special situation occurs with words at the beginning of the
sentence. If the first word of the sentence has an uncapitalized first
letter, it is treated in the normal manner. If it is capitalized, the
parser will first look to see if it is listed in the dictionary as a
either a capitalized word or an uncapitalized word. If it is listed as
both, the parser will try to use it in both ways. This allows certain
common names, such as "Will", "Sue" and "Rob" to also be recognized as
nouns or verbs.

If the first word is listed in the dictionary only as uncapitalized,
then a question is asked: "can this word plausibly be a proper name,
or a part of a proper name?". If it is, then the parser will attempt
to use it both as a capitalized, proper name, and as an uncapitalized
word. So, for example, if a sentence begins with the words "Great
Southern Railroad", then parses are attempted by considering both
"great.a" (the adjective) and "Great" (a part of a proper name).

```
                    +------Ost------+
                    |  +-----Dsu----+
     +---G---+--Ss--+  |    +---A---+
     |       |      |  |    |       |
   Great Southern is.v a good.a company.n
```

The `G` link above indicates that "Great Southern" is an entity name,
and is thus handy for entity identification, whereas the `A` link below
simply indicates that the "Southern" is modified by the adjective
"great".

```
                      +------Ost------+
                      |  +-----Dsu----+
      +----A---+--Ss--+  |    +---A---+
      |        |      |  |    |       |
   great.a Southern is.v a good.a company.n
```

In general, nouns and adjectives are taken to be "plausible" proper
names. Specifically, the two markers `<marker-common-entity>` and
`<marker-entity>` are used in the dictionary to indicate lower-case
words that might also be plausible upper-case entity names when they
occur at the start of a sentence.

The situation at the beginning of the sentence also applies after a
colon. Sometimes, after a colon, the following word is capitalized as
if it was the beginning of a sentence; the parser recognizes this. So,
for example, the following sentence is accepted: "The problem is this:
The dog ran."

#### Hyphenated Expressions

The dictionary also contains a special category called
`HYPHENATED_WORDS`. If a string contains a hyphen, and it is not
listed in the dictionary, the parser will assign it to the category
`HYPHENATED_WORDS`. This is, again, useful, since hyphenated words are
used somewhat "productively", and it would be very difficult to list
them all.

#### Number Expressions

The dictionary contains a category "NUMBERS". Any numerical expression
-- that is, a string consisting entirely of numerical characters --
will be assigned to this category unless it is explicitly listed
elsewhere in the dictionary. (The string may also contain a period,
i.e. a decimal point, or a comma, as in "3,287". It may also contain a
colon; thus time expressions like "4:30" are treated as generic
numbers.)

#### Unknown Words

The dictionary also permits a feature known as "unknown words". A
category can be defined using the string "UNKNOWN-WORD.x", where x is
any subscript. If a word beginning with a lower-case letter is typed
in that is not recognized, it will be assigned to that category. The
word is then displayed with a question-mark in brackets, like "blah"
below:

```
      +-----Wd----+
      |    +---D--+--Ss--+-Pp+
      |    |      |      |   |
    ///// the blah[?].n is here
```

Several different unknown word categories may be generated, labeled
with different subscripts: for example, corresponding to nouns, verbs,
and adjectives and adverbs. (These are the four categories we use,
labeled .n, .v, .a, and .e, respectively.) The parser will search for
all linkages that can be found using each entry. If it only finds a
linkage for the "noun" category, then the output will show the unknown
word labeled ".n": in effect, the parser is then guessing that the
word is a noun.

Version 4.0 of the parser has an new feature for handling unknown
words, known as "morpho-guessing". This is a system for guessing the
syntactic category of an unknown word (that is, a word not explicitly
listed in the dictionary) based on its spelling. Words that end in
"-s" are assumed to be plural nouns or singular verbs; these are
assigned to a category listed as "S-WORDS" in the
dictionary. Similarly, words ending in "-ed" are assumed past-tense
(or passive) verbs; those ending in "-ing", present participles; those
ending in "-ly", adjectives. This greatly improves the ability of the
parser to handle sentences containing multiple unknown words. Words
that have been treated in this way are marked with a "[!]". Click here
for more information about this feature.

Version 4.5 adds support for a spelling checker, which can be used to
guess at alternate spellings for unknown words. This is described in
greater detail here.

#### Punctuation And Affix-Files

The parser is capable of handling a variety of punctuation
symbols. There are two issues to be discussed here. One is the listing
of symbols in the dictionary; the other is the way they are "read" by
the parser when they are used in sentences.

Punctuation symbols can be listed in the dictionary just like words,
and given ordinary linkage expressions. The same is true for strings
containing multiple punctuation symbols or a mixture of letters and
punctuation. The problem here is that certain punctuation symbols are
also used as the "syntax" of the dictionary: colons, semi-colons,
ampersands, etc.. Our solution to this is as follows: when listing
these special characters, or a string containing them, one must put
them in quotation marks:

```
    ";": A+ or B-;
    "+": C+ or D-;
```

(The special characters that must be treated this way are precisely
those which are used in the dictionary in a "syntactic" way: "(", ")",
"{", "}", "[", "]", "@", "%", "&", "*", "+", "-", "/", "<", ">".)

When punctuation symbols are used in sentences, they will be used in
linkages according to the connector expressions listed in the
dictionary, in the normal way. There is a difference, however. It may
be noted that although many punctuation symbols are similar to words
in the ways they are used, they are often not separated from preceding
or following words by spaces. In order for these symbols to be
recognized as separate units, then, they must be "stripped off": that
is, a space must be inserted between the symbol and the adjacent word.

With version 4.0 we provide a new system for handling this "stripping
off" process. Rather than being hard-wired into the system, it can now
be easily modified and expanded by the user, using an "affix file"
which is read in by the parser when the program is run. An affix file
is similar in format to a link grammar dictionary, with lists of
strings (they need not be individual symbols, but may be any length),
followed by a connector type. Strings to be stripped off from the left
are listed under the category "LSTRIP+"; those to be stripped off from
the right are listed under the category "RSTRIP+". In the affix-file
that we provide, for example, "$" is listed as a "LSTRIP+" symbol; ","
is listed as a "RSTRIP+" symbol. (Click here for more information
about affix files.)

In the default affix file we provide (4.0.affix), the "RSTRIP+"
strings include these:

```
    , . ! ? % ) : ; ' 's 're 'll 've 'd ...
```

The "LSTRIP+" strings include these:

```
    $ ( ...
```

Note that we also use the affix file for a few things besides
punctuation. The "right-stripped" list includes strings like "'s",
representing a possessive ("John's") or a contraction ("he's");
strings like "'re" (as in "you're") are also included, representing
the fact that these should really be treated as independent words. A
further point: the parser will perform this stripping process on a
string repeatedly, if necessary, perhaps stripping off several
characters. For example, it will convert the first sentence below into
the second:

>    John, a professor (who got a raise of 5%), is here

>    John , a professor ( who got a raise of 5 % ) , is here

There is one difference between right-stripped and left-stripped
characters. Right-stripped characters can also be used at the right
end of a string defined in the dictionary; for example, one could
actually define "Mrs." or "it's" as ordinary dictionary
entries. Before stripping off right-stripped characters, the parser
will make sure that the string is not present in the dictionary as it
appears.

If punctuation symbols are used in the middle of strings, they will be
treated just like any other symbols. (And if they are used in
sentences in undefined strings, they will be treated as some kind of
unknown string.) (Note that periods are special, however; if the
string ends with a period followed by a letter, this will be
interpreted as the word subscript, not part of the string. See section
3.3 above.)

One exceptional case is quotation marks. Quotation marks may not be
defined in the dictionary; and they are simply ignored when they are
used in sentences. This is sufficient to handle most uses of quotes;
generally, the presence of quotes does not affect the well-formedness
of sentences, and they often only subtly affect meaning. However there
are a few constructions, such as the last pair of sentences below,
which seem to be correct only when quotes are included.

>    "John is leaving," she said

>    John is leaving, she said

>    I am meeting with my "advisor" today

>    I am meeting with my advisor today

>    She said, "John is leaving".

>    ?She said, John is leaving.

We are unable to control such usages at the moment.

The percent sign ("%") is used for comments. If a % appears at the
beginning of a sentence inputted to the parser, that sentence will
simply be ignored. This is useful if one is inputting a file of
sentences, and one wants to include some comments in the file. A % at
the beginning of a line can also be used for putting comments in a
dictionary.

##### Measurement Units

Measurement units are treated in more or less the same way as
suffixes. This allows sentences such as "It is 5ft long" to be parsed
as "It is 5 ft long", with "ft" identified as a unit of measure.

##### Currency Symbols, Utf-8 Markup

The affix file also recognizes many different types of foreign
currency symbols, as well as various styles of parenthesis most
commonly seen in Asian texts containing English.

#### The Sorting Of Unknown Strings

Notice that the parser must make decisions about how to handle strings
of characters which are not explicitly listed in the dictionary. The
ordering of the decisions is important. At the moment, the parser
proceeds as follows:

- If the string is the first string in a sentence, and its first
  letter is capitalized, then generate the lower-case-first-letter
  form of the string, and perform the following steps on both the
  capitalized and lower-case forms.
- Strip off any "strip-able" strings from the left end of the string
  (as described above). Perform subsequent steps on both the stripped
  string and the remainder.
- Look up the string in the dictionary as is. If there is an exactly
  matching string in the dictionary, use that.
- Strip off any "strip-able" punctuation string from the right end of
  the string (as described above). Repeat step 3 on both the
  punctuation string and the remaining string. If there is more than
  one such string, repeat steps 3 and 4 repeatedly.
- If the string still has not been assigned, see if it matches any of
  the "guessed-word" categories. Guessed words are controlled by
  regular-expression matching to regular expressions in the 4.0.regex
  file. Thus, for example, if the string begins with a capital letter,
  assign it to the category "CAPITALIZED-WORD", which treats such
  words as proper names. If the string consists entirely of numbers,
  assign it to the category "NUMBERS". Words ending in "s" are guessed
  to be plural nouns, while words ending in "us" or "ae" are guessed
  to be Latinate adjectives (e.g. luteus,influenzae), and so on.
- If the string still has not been assigned, assign it to any "UNKNOWN-WORD" categories.
- If none of these alternatives are available, the parser will say
  "the following words are not in the dictionary: [whatever]", and
  will give no other output for the sentence.

If at any point the parser finds more than one way of analyzing a
string, it generates both of them, and tries parsing the sentence with
both forms of the string. This might happen a) if there are multiple
forms of the word in the dictionary (with different subscripts); b) if
the string is capitalized and occurs at the beginning of the sentence,
and both the capitalized and lower-case forms are listed in the
dictionary; or c) if there is more than one UNKNOWN-WORD category.

Any of the generic word categories - UNKNOWN-WORD (any or all of
them), S-WORD (or the other "guessed word" categories),
CAPITALIZED-WORD, HYPHENATED-WORD, or NUMBERS - may be omitted from
the dictionary. In this case, the parser will skip over the
corresponding step in the procedure above. For example, if
"HYPHENATED-WORD" is omitted from the dictionary, and an unknown
hyphenated word is entered, it will be treated like an
UNKNOWN-WORD. If no UNKNOWN-WORD categories are present, and a string
is entered which fits none of the other categories, the parser will
proceed to step 9 above.

#### The Wall(S)

It proved to be useful to imagine that there was a dummy word at the
beginning of every sentence. We call this "the wall". The wall has a
linking requirement like any other word; it is listed in the
dictionary under "LEFT-WALL". If this entry is included in the
dictionary, the wall will be automatically inserted at the beginning
of every sentence. Because of the connectivity rule, it is then
necessary for the wall to be linked to the rest of the sentence in
order for the sentence to be valid.

There is also a "right-hand wall", which is similar to the original
wall at the other hand of the sentence. This is only needed for
certain punctuation phenomena. In most sentences, we use a special
"RW" connector to simply connect the left hand wall to the right hand
one. The right-wall's dictionary entry is "RIGHT-WALL". (Since the
left-wall is much more important than the right-wall, we often refer
to the left-wall simply as "the wall".)

In most sentences, the left-wall connects to the sentence with a "Wd"
link, and the right-wall connects to the left-wall with "RW". When
only these connectors on the walls are being used, they are not
displayed in the linkage diagram. When other connectors on the walls
are being used, instead or as well, the walls are shown. (For example,
the left-wall is shown in questions and imperatives.) To make it so
that the walls are _always_ shown, type "!walls".

Either wall can be deactivated by simply removing the "LEFT-WALL" or
"RIGHT-WALL" entry from the dictionary.

#### Idioms

A string of words can be defined as a single dictionary entry. To do
this, simply join the words together with underbars:

```
    a_la_mode: A+ or B-;
```

Most idioms can be interpreted either as a single "idiom" or as a
string of words (for example, "in question"). In this case, the parser
will find all linkages with both interpretations.

In reading idiomatic strings from the dictionary, the parser breaks
them up into individual words and assigns them "dummy" link-types
which simply link the words of the idiom together in series. These
link-types are assigned four-letter names of the form ID[X][Y], where
X and Y are arbitrary letters.

Idioms cannot be given subscripts; if "a_la_mode.a" is included in the
dictionary, this will not be accepted. However, an idiom can be listed
in the dictionary more than once, without subscripts.
5. Conjunctions

Conjunction refers to the joining together different parts of a
sentence using either coordinating conjunctions, correlative
conjunctions, or subordinating conjunctions. The most common
coordinating conjunctions are and, or, nor, but, and are used to join
together two grammatically similar or identical words or
phrases. Correlative conjunctions and subordinating conjunctions are
set phrases enforcing more complex, long-range structure. Examples
include either ... or ..., not only ... but also ..., if ... then ...,
and so on. Conjunctions of any of these types are (mostly) handled by
the same technique within link grammar, although there is some
variation. The technique currently used for handling sentences with
conjunctions is described here.

This mechanism for handling conjunctions was introduced in version
4.7.0 of the parser. Earlier versions of the Link Grammar parser
(those prior to version 4.7.0) used a different, special technique for
parsing sentences containing conjunctions. This technique, described
here, proved to have a number of disadvantages, and is now deprecated
and is in the process of being removed. Problems included:

- A relatively non-specific way of conjoining parses, which leads to
- A combinatorial explosion of possible linkages, which results in
- Poor performance when parsing long, complex sentences.

Worse, the technique was encoded purely algorithmically, in C code,
making it (very) hard to modify, expand, or refine. None-the-less,
this was done because the original authors believed that there was no
other way; that the handling of coordinating conjunctions did not fit
"naturally" into the theory of link grammar. The current maintainers
believe that this is not at all the case: that coordinating
conjunctions can be handled quite well within the context of the main
theory. In fact, using ordinary links to handle conjunctions increases
specificity and coverage, allowing a broader range of sentences to be
parsed correctly, while reducing combinatorial explosion, and
providing a tremendous boost to performance (quite often, a factor of
ten or more for most well-written, "literate" texts, of the kind that
might contain long, complex sentences). The current technique,
introduced in version 4.7.0, is described here. By default, the use of
the old-style, "fat" linkages is disabled; it can be enabled by
specifying the !use-fat=1 flag at the parser prompt, or by calling
parse_options_set_use_fat_links(TRUE) from C code.

### Post-Processing

#### The Logic Of Post-Processing

Besides conjunctions, there are certain phenomena in English which the
parser is incapable of dealing with in its basic form. To solve these
problems, we developed a post-processing system, based on a concept we
call "domains". A domain is a subset of the links that make up a
sentence. After a linkage has been found, the post-processing
mechanism goes through the linkage and divides the sentence up into
domains based on the kind of links that are present in the
sentence. It then further divides the links into "groups": sets of
links which share a particular domain membership. It then applies
rules which may declare the linkage invalid based on the combinations
of links present in a given group.

The information about the the domains to be formed and the rules to be
applied must be included in a "post-process knowledge file". The file
we provide with version 4.0 is called "4.0.knowledge". This is the
default post-process file, and will be used if no other file is
specified. As explained earlier, a post-process file can be specified
on the command line as follows: parse [dictionary] -pp [post-process
file] If you type "-ppoff" rather than "-pp [post-process file]", then
no post-process file will be used and no post-processing will be done.

#### The Domain Structure

A domain is started by a certain type of link; we call this the "root
link" of the domain. The word on the left end of this link is the
"root word". Different types of links start different types of
domains. To understand how domains are formed, imagine a linkage as a
kind of street map, through which paths can be traced. In most cases,
the domain of a link consists of all the links in the sentence that
can be reached from that link, without tracing through the root
word. (Another way of saying this is: the domain contains everything
reachable from the right end of the root link, without tracing through
the root link itself.) For example, assume that the C link in the
following sentence begins a domain. This domain will include the Sp
link and the I, but not the Ss and the O.

```
             +--C---+
         +-Ss+O-+   +Sp(e)+I(e)+
         |   |  |   |     |    |
    He told me they would  go
```

(The letters in parentheses indicate that the Sp and I link are in an
e-type domain.) Very roughly speaking, domains tend to include the
links to the right of that link. However, there are many
exceptions. In the following sentence, the C link starts a domain;
this includes the Ss and O links, but not the Xc, CO, or Sp, even
though the Sp is entirely to the right of the C.

```
          +---------CO---------+
          +-------Xc--------+  |
          +-C-+Ss(s)+O(s)+  |  +Sp+
          |   |     |    |  |  |  |
    After he   saw  us  ,  we left
```

In the case below, the domain started by the C link actually extends
back to the left of the root link, to contain the B link as well. This
follows naturally from the way domains are defined. The B link can be
reached from the right end of the C link, without tracing left through
the C. In this case, note that the B link extends to the left of the
root word.

```
         +---------Bsw(e)------+
         |   +---I---+         |
         |   +SI+    +-C--+S(e)+
         |   |  |    |    |    |
    Who do you think you  saw
```

If one wants a certain link type to start a domain, it must be
included in the list "DOMAIN_STARTER_LINKS" in the file
"post-process.knowledge". It must also be included in the following
list, ("STARTING_LINK_TYPE_TABLE"), along with the name of the
domain-type that it starts.

As we saw above, it is possible for domains to be traced back to the
left of the root word; and from there, they might be extended
indefinitely. This tends to be prevented, however, by what we call
"restricted links". If a link is restricted, this means that if a
domain is being traced through it to the left, and if the link extends
to the left of the root word of the domain (the left end of the root
link), the domain will be traced no further through the restricted
link. So, for example, Bsw is a restricted link. This means that, in
the sentence above, the "e" domain started by the C will contain the
Bsw; but if there are any links which can be traced from the left end
of the Bsw (i.e., another link coming out of the word "who"), they
will not be included in the domain.

There are a few other complications in the way domains are generated.

1. The root link of a domain may or may not be included in the domain
   it starts. Root links will not be included, unless they are listed
   in a special list in post-process.c, "DOMAIN_CONTAINS_LINKS".
2. Some domain-types are "bounded domains". This means that they are
   not allowed to extend to the left of their root link at all (even
   with a "restricted link"). If they do extend in this way in a
   linkage, the linkage will be declared invalid. (See "C" in the
   Guide to Links for an explanation of how this is used.) Domain
   types in this category must be listed under "BOUNDED_RULES".
3. As well as ordinary domains, there are two special kinds. One kind
   is "urfl" domains. As well as including everything that can be
   reached from the right end of the root link, these domains include
   everything that can be reached from the left end of the root link,
   tracing to the right, underneath the root link (but not over it),
   hence the name -- "Under Root From Left". In the example below, the
   TOo link starts an "urfl" domain; as well as including the "I"
   link, as a normal domain would, this domain also includes the O.

   ```
          +---TOo--+
      +-S-+O(x)+   +I(x)+
      |   |    |   |    |
      I asked him to   go
   ```

   The final kind of domain is "urfl-only". These include ONLY links
   that can be reached from the left of the root link, tracing to the
   right underneath the root link. In the case below, the Ss*g link
   starts an "urfl-only" domain.

   ```
         +-----Ss*g------+
         +---O(d)---+    |
         +     +D(d)+    +-O+
         |     |    |    |  |
      playing the piano is fun
   ```

   "Urfl" and "urfl-only" domains are defined by the link-types that
   start them. Any link that is added to the `URFL_DOMAIN_STARTER_LNKS`
   list will start an "urfl" domain; any link that is added to the
   `URFL_ONLY_DOMAIN_STARTER_LINKS` will start an "urfl-only" domain.

4. Finally, certain link types are simply ignored by
   post-processing. No domains may be traced through them, nor can
   they start domains. These are listed under "IGNORE_THESE_LINKS".

Domains may be nested; a link may therefore be in several domains at
once. The domain membership of a given link can be shown in the
following way:

```
  +----------------------RW-------------------+
  +--W-+-S+-P-+-MV-+-C+-S-+-C+-S+--P--+       |
  |    |  |   |    |  |   |  |  |     |       |
///// he got mad when I said I was leaving  \\\\\

               /////          RW      <---RW---->  RW        RIGHT-WALL
 (m)           /////          Wd      <---Wd---->  Wd        he
 (m)           he             Ss      <---Ss---->  S         got
 (m)           got            Pa      <---Pa---->  Pa        mad
 (m)           mad            MV      <---MVs--->  MVs       when
 (m)           when           Cs      <---Cs---->  C         I
 (m) (s)       I              Sp*i    <---Sp*i-->  S         said
 (m) (s)       said           Ce      <---Ce---->  C         I
 (m) (s) (e)   I              Sp*i    <---Spii-->  S*i       was
 (m) (s) (e)   was            Pg      <---Pg---->  Pg        leaving
```

To have the parser produce a "link list" of this kind, type
"!links". (In the structure shown here, the domain structure is
strictly hierarchical; every domain that is partially inside another
is completely inside that domain. There is no a priori reason why
domain structure should always be strictly hierarchical; but we
believe that, given the current grammar, it will almost always be
strictly hierarchical, except in a few very obscure cases.)

#### Groups

The domain structure is really a means to creating a more useful kind
of structure. This is the "group". A "group" of links is the set of
links that have the same domain membership. In the above example,
then, the "Spii" and "Pg" are part of the same group. The "Ce" and
"Sp*i" are in another group. The Ce and Pg are not in the same
group. Groups correspond roughly to subject-verb expressions - groups
of links that are part of a clause, but not part of any dependent
clauses within that clause. For example, in the above case, "He got
mad" is one subject-verb expression; "I said ..." is another, "I was
leaving" is a third.

#### Post-Processing Rules

The domain structure thus divides a sentence into groups of
links. This then allows us to enforce constraints on the link-types
that are in a subject-verb expression. This is useful in cases where
there are constraints on the combinations of links that can be present
in a clause, but the links may be separated (i.e., they may not all
connect to the same word), making the constraints difficult to enforce
using link logic. We do this by using certain kinds of rules. One is
the "contains_one" rule. This says that if a group contains a link of
a certain type, it must contain a link of another type. Another kind
of rule is the "contains_none" rule. This says that if a group
contains one kind of link, it may not contain any of a certain kind of
link.

In each case, we have a "triggering" link-type: a link that triggers
the rule, and enforces a certain constraint. We also have a
"criterion" link-type: a link that defines the constraint (whether it
is "must contain X" or "may not contain X"). The triggering link for a
rule must be contained in a line of the form

```
        X, Y Z, "Warning!",
```

where "X" is the triggering link-type, "Y" and "Z" are the criterion
links for the rule, and "Warning" is a message that will be outputted
when the rule is violated. (This warning will only be outputted when
the incorrect linkage itself is outputted, and this only happens in
"!bad" mode. It will also only be outputted when the "!links" display
is shown.)

If such a rule is listed under "CONTAINS_ONE_RULES", this means, "A
group containing an X connector must contain either a Y or a Z". (The
group may contain more than one from the set: a Y and a Z, 2 Y's,
etc.) If it is listed under "CONTAINS_NONE_RULES", this means "a group
containing an X link may not contain either a Y or a Z".

One can also define a symbol as a set of links:

```
        @Blah: Y Z
```

In this line, "@Blah" is defined as the set of links {X, Y}. "@Blah"
can then be used in actual rules. Given this definition, the rule
below will have the same effect as the rule stated above:

```
        X, Blah, "Warning",
```

where "Y" and "Z" are the criterion links for the rule.

A further kind of rule is used in post-processing, which does not
relate to domain structure. If a certain link type is included in the
list "MUST_FORM_A_CYCLE", this means that any links of that type may
only be used in cycles. For example, "R" is on list. The linkage below
satisfies this rule in the case of "R", because "R" is used in a cycle
here.

```
            +-------Ss------+
  +----Wd---+----Bs---+     |
  |    +-Ds-+--R-+Sp*i+     +-Pp-+
  |    |    |    |    |     |    |
///// the man.n I.p saw.v is.v here
```

Certain link-types (relating to punctuation) proved to disrupt the
domain structure; it seemed preferable for them to simply be ignored
by post-processing. Thus we created a list in post-process.knowledge,
"IGNORE_THESE_LINKS", which are ignored for in the creation of the
domain structure (that is, domains are not traced through them), and
also in the application of the post-processing rules. (They may be
included in the "MUST_FORM_A_CYCLE" list, however, if desired.)

#### Post-Processing And Conjunctions

The interaction of post-processing and conjunctions is
straightforward. As discussed earlier, any linkage with a conjunction
can be regarded as several sub-linkages, and in fact is generally
displayed that way. In post-processing, these sub-linkages are treated
individually; domains are generated and rules are applied in each
sub-linkage. A conjunctive linkage is only approved by post-processing
if all of its sub-linkages are approved.

#### Link-Type Matching In Post-Processing

Link-type matching in post-processing requires some explanation. In
the dictionary, subscripts are used to create sub-categories of
connector-types. "Ss+" will link with "Ss-" and "S-", but not
"Sp-". The character "*" is used as a wild-card; it will match to any
character. An unsubscripted connector name, like "S+", can thus be
regarded as equivalent to "S***...+"

The post-processor also requires a system for matching connector
types. While the linkage stage is looking at link-types on connector
expressions, post-processing is looking at the resulting link-types
that are formed when a linkage is complete. (If an "Ss+" has linked
together with a "S*a-", what the post-processor sees is "Ssa".) It is
then comparing them to link-names listed in "post-process.c" (as
domain-starting links, as triggering links for rules, as criterion
links for rules, etc.). The link-type matching system used in
post-processing is similar to the linkage-level one, but it is a
little different. As mentioned above, from the dictionary's point of
"*" is a wild-card character that matches to any other character (see
section 3.1). From the post-processor's point of view, however, "*" is
just another character; "S*" in a linkage does _not_ match with an
"Ss" in post-process.knowledge. Nor does an "S*" in
post-process.knowledge match with an "Ss" in a linkage. However, there
is also a wild-card character in post-processing; this is "#". An "S#"
in post-process.knowledge does match with a "Ss" in the dictionary, as
well as with an "S*".

As mentioned above, at the linkage stage, the parser treats any
unsubscripted places in a link name as "*"'s. For the post-processor,
however, any empty subscript places in a link name - either in a
linkage or in a post-processing rule - are treated as "#'s". In short:
at both the linkage stage and the post-processing stage, empty
subscript places are treated as wild-cards that match to anything. For
explicitly labeling a subscript place as a wild-card, however, one
uses "*" at the linkage-stage and "#" in post-processing.

The specific uses of post-processing are fully explained in the "Guide
to Links". For example, see "SF: filler-it"; "SI", and "MV:
Comparatives".

#### The `!bad` Command.

For people editing the dictionary or post-processing, a useful display
feature is "!bad". The usual running of the parser is that it will
display the linkages in order of cost (lowest-cost ones first);
additional linkages after the first one can be seen one at a time by
typing RETURN. Only linkages passing post-processing are outputted. If
the "!bad" variable is toggled, however, the parser will output _all_
of the linkages it finds, including those that fail
post-processing. The invalid linkages will be outputted after the
valid ones, one by one, as long as the user types RETURN. The parser
will only output the linkages it finds at whatever stage it had gotten
to when it found a valid linkage. For example, if it had gotten to
null-link stage 2 before finding its first valid linkage, it will also
output invalid linkages found at null-link stage 2 (see section 7.1
for explanation of null-links). There is no way of seeing invalid
linkages found at earlier stages.

### Speed and Robustness Features

The original version of the parser, as described in previous sections, did an exhaustive search for all correct linkages; if none were found, it produced nothing. However, this meant that the parser was not "robust": it could not do anything useful with a sentence unless it could parse the entire thing. It was also quite slow. We have developed several remedies to these problems.

#### The Null-Link System

An important feature of the parser is the "null-link" system. This
effectively allows robust parsing: that is, it allows the parser to
assign some structure to a sentence even when it cannot fully
interpret it. Basically, if the parser cannot parse a sentence
normally (that is, if it cannot find any valid linkages), it tries
ignoring one word in the sentence. It finds all the linkages it can,
ignoring just one word (some linkages may ignore one word, some may
ignore another). This is "null link stage 1". Failing that, it then
attempts to find linkages ignoring 2 words. This is "null link stage
2". Failing that, it will continue to increment the number of null
links, until it finds some valid linkages; it will then output all the
linkages found at this stage, and stop. There may be some cases where
it cannot find a valid linkage unless it ignores _all_ the words in
the sentence; in this case, it simply gets to "null link stage N"
(where N is the number of words in the sentence), and then gives up.

In the graphic display, "null-linked" words are shown in brackets,
with no links attached to them. In the sentence below, "gosh" and ","
are null-linked:

```
             +--Dsu--+---Ss---+----O---+
             |       |        |        |
[gosh] [,] this sentence.n uses.v null-links
```

In null-link parsing, the connectivity requirement is suspended (see
Section 1.3). This means that disconnected "islands" may
form. However, each island represents one added null link. That is, if
a sentence can be parsed as three disconnected islands (but with all
the words otherwise connected with regular links), this will linkage
will be found at null link stage 2.

Note that the null-link systems respects post-processing. It keeps
incrementing the number of null-links until it finds linkages that
pass post-processing. For example, if linkages are found at null-link
stage 0, but they all fail post-processing, the parser will decide
that no valid linkage has been found and will proceed to null-link
stage 1. However, if some of the links in a linkage are not indirectly
connected to the left-wall--as may occur in some "islands"--they may
not be contained in any post-processing domain. Such links will not be
subject to "contains_one" and "contains_none" rules, which apply only
to links that are in a domain.

The null-link system can be turned on or off by typing the command
"!null". The default is that null-links are on. If null-links are
turned off, then, when the parser is unable to find a complete linkage
for a sentence, it will say "No complete linkages found", and prompt
for the next sentence.

#### The Link-Length Limit

In studying the parser's performance on very long sentences (on which
it was often very slow), we discovered that it was often considering
extremely long links even for link-types which are generally very
short, such as "D" (connecting determiners to nouns). For this reason,
we installed a "link-length-limit": links are only allowed to be a
certain length, in terms of the number of words from end to
end. However, not all link-types are always short; some are sometimes
quite long, such as "S" and "MV". Thus we include a list in the
dictionary, "UNLIMITED-CONNECTORS", for link-types which are to be
exempted from this limit. The limit for short link-types can be
adjusted while running the parser using the command
"!short=[length]". The default value for this is 6.

If you wish to disable the length limit, so that all link-types may be
any length, remove the "UNLIMITED-CONNECTORS" list from the
dictionary. If you want all link-types to be _short_, so that none are
exempted from the length limit, you must include the
"UNLIMITED-CONNECTORS" list in the dictionary, with some bogus
connector such as "NO+", but otherwise empty.

The interaction between the length limit and conjunctions is
complex. In sentences containing a conjunction, it seemed sensible to
relax the length limit. For example, D links are very rarely 7 words
long (as in sentence 1 below), but they might be this long in a
sentence containing a conjunction (sentence 2).

```
 +-------------D-------------+
 |                           |
The big big big big big big dog ran (rejected)

The big big dog and big big cat ran (accepted)
```

The logical thing to do seemed to be to apply the length limit only to sub-sentences; that is, when the length of a link to one element in an "and"-list is calculated, the length of any intervening elements in the "and"-list is subtracted. We call this adjusted length the "effective length" of a link. Therefore sentence 1 above is rejected; sentence 2 is accepted. In null-link stages, however, this is not done; link length is simply equal to actual length. (For complex reasons, linkages with conjunctions which exceed the length limit may occasionally be accepted in null-link stages.)

#### The Post-Processing Limit

Since post-processing proved to be a major source of the slowness of
the parser, we installed a "post-processing limit". This is simply a
limit on the number of linkages that will be considered by
post-processing. If the limit is set at 100 (this is the default),
then only 100 linkages will be considered by post-processing, even if
many more than that are generated; the others will just be
discarded. This means, of course, that the "best" linkage (by the
parser's heuristics, for example) may be discarded. However, the
linkages to be considered by post-processing are selected randomly
from all the generated ones, which means that at least one linkage is
likely to be found which is fairly similar to the correct one. The
number of sentences considered by post-processing can be controlled
with the variable "!limit=[number]".

#### The Timer

The parser also has a timer. When the timer is set to a positive
value, the parser will simply abort parsing of a sentence after that
number of seconds has elapsed. (When the time is set to -1 -- its
default -- it does nothing, and the parser will run indefinitely.) Set
the timer while running the parser by typing "!timeout = [time value
in seconds]".

#### Panic Mode

Combining several of these features, we created a new mode of parsing
called "panic mode", in which the parser can parse even very long
sentences quickly, but with considerably reduced accuracy. Panic mode
has the following features. 1) All link-types are considered "short",
even those included in the UNLIMITED-CONNECTORS list. 2) Panic mode
begins immediately with null-link parsing, skipping regular parsing
(the main consequence of this is that the "effective length" of links
is considered to be their actual length; see Section 7.3). 3) Whereas
only connectors of cost 0, 1 or 2 are considered in regular parsing,
all connectors are considered in panic mode. At the moment, the only
connectors in the dictionary with cost greater than 2 (they have cost
3) are connectors on nouns which allow them to make no main connection
at all:

```
dog man house: {@A-} & D- & (S+ or O- or J- or [[[()]]]);
```

In effect, this allows noun-phrases to be treated as complete
entities, not connected to anything else. (Recall that in null-link
parsing, the connectivity rule is suspended, so that disconnected
"islands" may form.) In a typical "panic mode" linkage, then, various
noun-phrases and clauses within the sentence will be fully parsed, but
they will often not be connected to each other.

Panic mode is invoked whenever the timer runs out on regular parsing
and no valid linkages have been found. For example, if the timer is
set for 15 seconds, panic mode will begin after 15 seconds. Panic mode
can be disabled (or turned back on again), while running the parser,
by typing "!panic".
