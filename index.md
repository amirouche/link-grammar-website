*By Davy Temperley, John Lafferty and Daniel Sleator*

*Maintained and extended by [Linas Vepstas](http://) , [Dom Lachowicz](http://), the [Open Cognition project](http://) and [Abiword](http://).*

## News

September, 2016: [link-grammar 5.3.11 released](http://)! See below
for a description of recent changes.

The 5.0.0 version of Link Grammar now uses a new license: the LGPL
v2.1 license. Older versions remain available under the BSD
license. This license change was made to allow greater participation
in the project.

The new version includes the Persian and Arabic systems, which were
previously distributed separately. It also includes prototype,
experimental dictionaries for Lithuanian, Indonesian, Vietnamese,
Hebrew and Turkish. In addition, the programming interfaces for python
and ocaml are now integrated, joining those for java and common
lisp. A shell script to run the JSON network parse server is included.

## What is Link Grammar?

The Link Grammar Parser is a syntactic parser of English, Russian,
Arabic and Persian (and other languages as well), based on Link
Grammar, an original theory of syntax and morphology. Given a
sentence, the system assigns to it a syntactic structure, which
consists of a set of labelled links connecting pairs of words. The
parser also produces a "constituent" (HPSG style phrase tree)
representation of a sentence (showing noun phrases, verb phrases,
etc.). The RelEx extension provides Stanford-style Dependency Grammar
output.

The theory of Link Grammar parsing, and the original version of the
parser was created in 1991 by Davy Temperley, John Lafferty and Daniel
Sleator, at the time professors of linguistics and computer science at
the Carnegie Mellon University. It is the product of decades of
academic research into grammar and morphology, and is discussed in
numerous publications.

## Linguistic Disclaimer

Link Grammar is a natural language parser, not a human-level
artificial general intelligence. This means that there are many
sentences that it cannot parse correctly, or at all. There are entire
classes of speech and writing that it cannot handle, including twitter
posts, IRC chat logs, Valley-girl basilect, Old and Middle English,
stock-market listings and raw HTML dumps.

Link Grammar works best with "newspaper English", as taught to and
written by those educated in American colleges: standard-sized
sentences, with good grammar, proper punctuation, and correct
capitalization. Link Grammar has difficulties with the following types
of textual input:

- Phrases (that are not a part of a complete sentence).
- Twitter posts. These tend to be sentence fragments, often lacking
  proper grammatical structure.
- Any text containing a large number of spelling errors.
- "Registers", such as newspaper headlines, where determiners are
  omitted; for example, "Thieves rob bank."
- Dialog, stage plays and movie scripts. Such dialog tends to consist
  of interleaved sentences.
- Speech-to-text output. Such systems generate large numbers of
  mis-heard words that, taken at face value cannot be a part of valid
  sentences. Even such recognition was perfect, spoken English tends
  not to be as well-constructed or grammatical as written English.
- Support for British English and Commonwealth English is poor. This
  includes any English dialects spoken in India, Pakistan, Nigeria,
  Bangladesh, South Africa, as well as former American protectorates,
  such as the Phillipines. British and regional spelling of words is
  missing from the dictionaries.
- Slang and various regional non-middle-class-American dialects. This
  includes most dialects spoken by anyone living in economically poor
  or under-educated geographical regions, whether in urban housing
  projects or the red-state small-town and rural
  poor. Self-identifying subgroup dialects are also not handled, such
  as drug-culture, gang-culture and hacker-culture.
- Long run-on sentences. These can generate thousands of alternative
  parses in a combinatorial explosion.

It is hoped that the unsupervised learning of language proposal will
be of sufficient power and ability to handle most of these exceptional
cases. Work is ongoing.
