# let vs let!

Understanding the difference between `let` and `let!` is fundamental when starting to learn RSpec.

Use `let` to define a memoized helper method. The value will be cached
across multiple calls in the same example but not across examples.

Note that `let` is lazy-evaluated. That means that the expression is not evaluated until the first time it is invoked from somewhere else. You can use `let!` to force the expression's invocation before each example.

### When should `let!` be used?
- When there's a need to trigger an insertion into the database before running an example block.
- An alternative to `let!` is invoking the variable from a `before` or `subject` block, or even from inside an example. This practice is discouraged.

### Example

#### Bad
```
let!(:user) { create(:user) }

let!(:membership) { create(:membership, user: user) }
```

#### Good
```
let(:user) { create(:user) }

let!(:membership) { create(:membership, user: user) }
```
---
#### Bad
```
let!(:params) do
  {
    email: 'user@example.com',
    password: 'password'
  }
end
```

#### Good
```
let(:params) do
  {
    email: 'user@example.com',
    password: 'password'
  }
end
```
Take a look at `params`. The expression is defining in-memory attributes, so there's no need to use `!`.

---

In conclusion, prefer the use of `let` unless there is a compelling reason to choose `let!`.
### Resources:
- [Let and let!](https://relishapp.com/rspec/rspec-core/v/2-5/docs/helper-methods/let-and-let)
