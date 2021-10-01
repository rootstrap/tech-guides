Code Review
===========

A guide for reviewing code and having your code reviewed.

Everyone
----

- Accept that many programming decisions are opinions. Discuss tradeoffs, which you prefer, and reach a resolution quickly.
- Ask questions; don't make demands. ("What do you think about naming this `:user_id`?")
- Ask for clarification. ("I didn't understand. Can you clarify?")
- Avoid selective ownership of code. ("mine", "not mine", "yours")
- Avoid using terms that could be seen as referring to personal traits. ("dumb",
"stupid"). Assume everyone is attractive, intelligent, and well-meaning.
- Be explicit. Remember people don't always understand your intentions online.
- Be humble. ("I'm not sure - let's look it up.")
- Don't use hyperbole. ("always", "never", "endlessly", "nothing")
- Don't use sarcasm.
- Keep it real. If emoji, animated gifs, or humor aren't you, don't force them. If they are, use them with aplomb.
- Talk in person if there are too many "I didn't understand" or "Alternative solution:" comments. Post a follow-up comment summarizing offline discussion.

Having Your Code Reviewed
----

- Add 2 reviewers to the project (in some explicit cases could be more), the reviewers should have the expertise needed, ideally one of them has business knowledge of the project.
- Add a good description to the PR, it helps the reviewers to understand the code and the context of it. You can follow [Pull Request Format](pr-template.md)
- Add screenshots with the PR description if there are visual changes, gifs or before/after images are also appreciated but not mandatory.
- Use labels to identify the PR status (ask to an repo admin if there are a missing label), some of them are: On hold and Awaiting info.
- Be grateful for the reviewer's suggestions. ("Good call. I'll make that change.")
- Don't take it personally. The review is of the code, not you.
- Explain why the code exists. ("It's like that because of these reasons. Would it be more clear if I rename this class/file/method/variable?")
- Link to the code review from the ticket/story. ("Ready for review: https://github.com/organization/project/pull/1")
- Push commits based on earlier rounds of feedback as isolated commits to the branch. Do not squash until the branch is ready to merge. Reviewers should be able to read individual updates based on their earlier feedback.
- Seek to understand the reviewer's perspective.
- One of the reviewers or you can merge once:
  - Continuous Integration (CircleCi, Github Actions, etc) tells you the test suite is green in the branch.
  - Two reviewers approved the PR

Reviewing Code
----

Understand why the change is necessary (fixes a bug, improves the user
experience, refactors the existing code). Then:

- Communicate which ideas you feel strongly about and those you don't.
- Identify ways to simplify the code while still solving the problem.
- If discussions turn too philosophical or academic, move the discussion offline to a regular Friday afternoon technique discussion. In the meantime, let the author make the final decision on alternative implementations.
- Offer alternative implementations, but assume the author already considered them. ("What do you think about using a custom validator here?")
- Seek to understand the author's perspective.
- Sign off on the pull request with the approving tool of Github/Bitbucket .
- Use and reference the recommended style guide of the technology.
