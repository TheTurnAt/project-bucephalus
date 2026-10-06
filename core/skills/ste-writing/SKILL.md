---
name: ste-writing
description: Write agent instructions, handoffs, reports, commit messages, and docs in a simplified technical English based on ASD-STE100, the aerospace maintenance writing standard. Use for every task assignment, report, status email, skill, runbook, and OpenLore note, so that humans and agents read each instruction one way only.
---

# STE writing (about 80% of ASD-STE100)

ASD-STE100 (Simplified Technical English) is the writing standard for aircraft
maintenance documents. It makes instructions clear and hard to misread. We use
about 80% of it: the rules below. We do not use the full approved dictionary,
because software needs its own technical words.

## Rules for sentences
1. Write instructions in the command form: "Run the tests." Not "The tests
   should be run."
2. Use the active voice. Say who or what does the action.
3. Write one instruction in each sentence. If two actions occur at the same
   time, you can put them in one sentence.
4. Keep instructions to 20 words or fewer. Keep descriptions to 25 words or
   fewer.
5. Write one topic in each paragraph. Use no more than six sentences in a
   paragraph.
6. Use the articles "the", "a", and "an". Do not delete words to make a
   sentence shorter.
7. Do not use more than three nouns in a row. Write "the token for the signing
   repo", not "signing repo access token secret".

## Rules for words
8. Use one word for one meaning. If you call it a "branch", do not later call
   it a "PR" or a "change".
9. Use simple verbs: "use", not "utilize". "Start", not "initiate".
10. Use technical names exactly as they appear: file names, commands, field
    names, error messages. Put them in code format.
11. Do not use words with two meanings when a clear word exists: "after", not
    "once"; "because", not "since"; "if", not "when" for a condition.
12. Do not use "should", "might", or "could" in an instruction. Write "do" or
    "do not". Use "can" only for a permitted option.

## Rules for procedures
13. Write steps as a numbered list, in the sequence that the reader does them.
14. Put a warning or a caution before the step that it is about, not after.
15. Give the condition before the action: "If the dry run shows zero records,
    stop." Not "Stop if the dry run shows zero records."
16. Tell the reader the result to expect after a step that can fail.

## Example
Not STE:
> Once you've made sure the migration has been reviewed, you should probably
> go ahead and push it, though it might be worth re-running tests since main
> may have moved.

STE:
> 1. Make sure that the reviewer approved the branch.
> 2. Merge `main` into the branch.
> 3. Run the tests. Make sure that all tests pass.
> 4. Push the branch.

## The 20% we skip
- The full STE approved-word dictionary. Software terms are always permitted.
- Strict word counts in tables, code comments, and commit message subjects.
- Conversation with William. Chat can be normal. Instructions and reports use
  STE.
