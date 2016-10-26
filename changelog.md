## ChangeLog

### Version 5.3.11: (28 September 2016)

Notable: A conflict of the bundled version of minisat with the
system-provided version is minimzed: LG will now use the
system-provided version, if it is available (and not install the
bundled version).

- Re-enable postscript header printing!
- Cleanup python API (in a non-backwards-compat fashion).
- Fix certain adverbial uses of "only".
- Fix some interjective openers to questions.
- Fix serious error with subject-verb inversion to past participle.
- Remove most calls to exit() from the library.
- Update the SAT solver code to use MiniSAT 2.2.
- Use the system minisat2 library if available, instead of the bundled one. 

### Version 5.3.10: (14 September 2016)

Notable: Fixes a build-break for OSX! Also, a large restructuring of
the English-language dictionaries to handle a greater variety of
sentences with "as" and "so" in them.

- Implement `make installcheck`.
- Pull #371: Simplification of API when handling disconnected words.
- Fix SAT parser crashes.
- Expand default list of Java JDK search paths.
- Fix python bindings: after timeout, no further parsing is performed.
- Fix various adverbial, conjunctive uses of "as", "so".
- Extended list of exclamations.
- Remove CC link, add VC link, for clauses to coordinating conjunctions.
- Fixes for the verb "dare", "someone or other", etc.
- Fix OSX build break, concerning undefined locale_t.
- Pull #385: Fix ancient bug that made dictionary debugging difficult. 

### Version 5.3.9: (27 August 2016)

Emergency release to fix a fatal error in the previous release!

- Pull req #354: Major changes to support Cygwin.
- Pull req #356: SAT parser bug fix.
- General python binding cleanup.
- Fatal error: Unable to open default dictionary. 

### Version 5.3.8: (15 August 2016)

The big change in this release is the support for python2 and python3
bindings, large improvements in Windows support, and the use of
locales in dictionaries, which should help avoid locale-related
difficulties (for example, capitalization is locale-dependent; and so
mis-set locales break Turkish).

- Disambiguate "Bob" the given name from "bob" the verb.
- Pull req #300: Crash while parsing certain Russian sentences.
- Pull req #301: MSVC compiler error, and warnings.
- Pull req #304: Python failure when no parses are possible.
- Pull req #309: Add MSVC14 support, remove MSVC9, MSVC12.
- Pull req #317: Make Java build reproducible.
- Remove (obsolete) binreloc support.
- Enable both python2.7 and python3.4 bindings to be built.
- Improved Cygwin and MinGW support (as well as improved MSVC support).
- Dictionaries now specify the appropriate locale. 

### Version 5.3.7: (7 May 2016)

- Fix another MacOS build break, regarding library exports. 

### Version 5.3.6: (1 May 2016)

- Add missing `parses-quotes-en.txt` file that python tests need.
- Fix build break related to lg_fgetc when libeditline is missing. 

### Version 5.3.5: (28 April 2016)

Fix strange Apple Mac OSX behavior.

- Modified (hacked) Kazakh.
- MacOS bug fix: fgetc behaves oddly in OSX, see bug #293. 

### Version 5.3.4: (16 March 2016)

- Fix broken handling of apostrophe (issue #281).
- Revamp the README file; describe transitivity.
- Revised Turkish dictionary from Tatiana Batura, et al.
- Prototype Kazakh dictionary from Tatiana Batura, et al.
- Parse priority tweaks for the OpenCog chatbot.
- Fix Windows printing problem affecting some utf8 codepoints (issue #285). 

### Version 5.3.3: (23 December 2015)

Fix build break for Apple Mac OSX.

- Improve support for quoted phrases.
- Fixes for assorted zero-infinitive speech acts.
- Add 37 paraphrasing verbs.
- Add Greek mythological names.
- A few dozen more common computing terms added to dictionary.
- Misc coordination and question fixes.
- Misc abbreviations.
- Vietnamese dictionaries!
- Major overhaul of subject-verb inversion.
- Performance improvements on long sentences. (pull #247)
- Change default setting of 'islands_ok' back to false (bug #140).
- Fix for build break on Mac OSX el_capitan w/clang (bug #255).
- Disable perl bindings by default; use Lingua::LinkParser 

### Version 5.3.2: (4 December 2015)

Fix build break for Apple Mac OSX.

- Performance improvements, esp. for long sentences.
- Use std=c11 (the 2011 C standard) by default.
- Partial Irish English support.
- A few dozen common computing terms added to dictionary.
- Fix for build break on Mac OSX. 

### Version 5.3.1: (22 November 2015)

Fix build break.

- Fix build break with SAT solver. 

### Version 5.3.0: (22 November 2015)

This is a major release of the parser, with many important changes in it. Most fundamentally, the tokenizer has been completely redesigned; the tokenizer is the device that splits sentences in sequences of words and (for non-English languages) morphemes.

Another very important change: The python bindings are completely redesigned, and not in a backwards-compatible way. The new python bindings are much closer to how the parsing process should be thought about in the abstract.

There are also various fixes: the SAT solver is no longer crippled. Assorted performance speedups have been implemented, especially affecting longer sentences. Assorted bugs and cleanup has been performed.

- Major redesign of the python bindings.
- Major redesign of sentence tokenization (the "wordgraph" design)
- Verb 'steal' is optionally transitive.
- Fixes for misc MSVC warnings.
- Hebrew dictionary expansion.
- Enhanced diagram printing, giving more space for link names.
- Minor work on phonetic agreement for 'a' vs. 'an'.
- Add ability to histogram the costs of different parses.
- Improve support for splitting sentences.
- Change default setting of 'islands_ok' to true.
- Improve performance on long sentences.
- Fix rare crash due to memory corruption on long sentences.
- Random morphology generation can be enabled at runtime.
- Remove obsolete, unmaintained MacOSX build file.
- Extensive updates to man page.
- Fix crash on long sentences (issue #137).
- Fix a memory leak in language bindings (issue #138).
- Remove bogus post-processor API function.
- Fix broken domain letter printing.
- New regex-file feature - negative regex'es.
- Correct the handling of moprhology stems with non-LL links.
- Fix !!LEFT-WALL and !!RIGHT-WALL
- SAT solver now linked statically.
- Assorted SAT sovler cleanup and improvements.
- Performance improvement in fast macher: 15% faster on fixes.batch. 

A list of older changes can be found here.
