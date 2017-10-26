# RSpec style guide

This RSpec style guide outlines our recommended best practices so that our developers can write code that can be maintained by other (future) developers.
This is meant to be a style guide that reflects real-world usage, holding to an ideal that has been agreed upon by many of the people it was intended to be used by.


## Style Guide Rules

### Line Returns after `feature`, `context`, or `describe`

Do not leave line returns after `feature`, `context` or `describe`
descriptions. It makes the code more difficult to read and lowers the
value of logical chunks.

#### Bad Example

```ruby
describe Article do

  describe '#summary' do

    context 'when there is a summary' do

      it 'returns the summary' do
        # ...
      end
    end
  end
end
```

#### Good Example

```ruby
describe Article do
  describe '#summary' do
    context 'when there is a summary' do
      it 'returns the summary' do
        # ...
      end
    end
  end
end
```

### `let`, `subject`, and `before`/`after` group line returns

Leave one line return after `let`, `subject`, and `before`/`after` blocks.

#### Bad Example

```ruby
describe Article do
  subject { create(:some_article) }
  describe '#summary' do
    # ...
  end
end
```

#### Good Example

```ruby
describe Article do
  subject { create(:some_article) }

  describe '#summary' do
    # ...
  end
end
```

### `let`, `subject`, `before`/`after` grouping

Only group `let`, `subject` blocks and separate them from `before`/`after`
blocks. It makes the code much more readable.

#### Bad Example

```ruby
describe Article do
  subject { create(:some_article) }
  let(:user) { create(:user) }
  before do
    # ...
  end
  after do
    # ...
  end
  describe '#summary' do
    # ...
  end
end
```

#### Good Example

```ruby
describe Article do
  subject { create(:some_article) }
  let(:user) { create(:user) }

  before do
    # ...
  end

  after do
    # ...
  end

  describe '#summary' do
    # ...
  end
end
```

### `it` block line returns

Leave one line return around `it` blocks. This helps to separate the
expectations from their conditional logic (contexts for instance).

#### Bad Example

```ruby
describe '#summary' do
  let(:item) { double('something') }

  it 'returns the summary' do
    # ...
  end
  it 'does something else' do
    # ...
  end
  it 'does another thing' do
    # ...
  end
end
```

#### Good Example

```ruby
describe '#summary' do
  let(:item) { double('something') }

  it 'returns the summary' do
    # ...
  end

  it 'does something else' do
    # ...
  end

  it 'does another thing' do
    # ...
  end
end
```

### `before(:each)`or `before`

There is no need to specify `(:each)` for `before`/`after` blocks, as it is
the default functionality. The expression `before(:all)` should be rarely used,
but if you find a case where it is necessary, just write it out as `before(:all)`

#### Bad Example

```ruby
describe '#summary' do
  before(:each) do
    subject.summary = 'something'
  end
end
```

#### Good Example

```ruby
describe '#summary' do
  before do
    subject.summary = 'something'
  end
end
```

### 'should' it or 'should not' in `it` statements

Do not write 'should' or 'should not' at the beginning of your `it` blocks.
The descriptions represent actual functionality - not what might be happening.

#### Bad Example

```ruby
it 'should return the summary' do
  # ...
end
```

#### Good Example

```ruby
it 'returns the summary' do
  # ...
end
```

### The One Expectation

Use only one expectation per example. There are very few scenarios where two
or more expectations in a single `it` block should be used. So, general rule
of thumb is one expectation per `it` block.

#### Bad Example

```ruby
describe ArticlesController do
  #...

  describe 'GET new' do
    it 'assigns new article and renders the new article template' do
      get :new
      expect(assigns[:article]).to be_a(Article)
      expect(response).to render_template :new
    end
  end

  # ...
end
```

#### Good Example

```ruby
describe ArticlesController do
  #...

  describe 'GET new' do
    it 'assigns a new article' do
      get :new
      expect(assigns[:article]).to be_a(Article)
    end

    it 'renders the new article template' do
      get :new
      expect(response).to render_template :new
    end
  end
end
```

### Context Cases

`context` blocks should pretty much always have an opposite negative case. It
should actually be a strong code smell if there is a single context (without a
matching negative case) that needs refactoring, or may have no purpose.

#### Bad Example

```ruby
# This is a case where refactoring is the correct choice
describe '#attributes' do
  context 'the returned hash' do
    it 'includes the display name' do
      # ...
    end

    it 'includes the creation time' do
      # ...
    end
  end
end

# This is a case where the negative case needs to be tested, but wasn't
describe '#attributes' do
  context 'when display name is present' do
    before do
      subject.display_name = 'something'
    end

    it 'includes the display name' do
      # ...
    end
  end
end
```

#### Good Example

```ruby
# Refactored
describe '#attributes' do
  subject { create(:article) }

  expect(subject.attributes).to include subject.display_name
  expect(subject.attributes).to include subject.created_at
end

# Negative case added
describe '#attributes' do
  context 'when display name is present' do
    before do
      subject.display_name = 'something'
    end

    it 'includes the display name' do
      # ...
    end
  end

  context 'when display name is not present' do
    before do
      subject.display_name = nil
    end

    it 'does not include the display name' do
      # ...
    end
  end
end
```

### `context` descriptions

`context` block descriptions should always start with 'when' or ‘with’, and be in the
form of a sentence with proper grammar.

#### Bad Example

```ruby
context 'the display name not present' do
  # ...
end
```

#### Good Example

```ruby
context 'when the display name is not present' do
  # ...
end
```

### `it` descriptions

`it` block descriptions should never end with a conditional. This is a code
smell that advices the `it` most likely needs to be wrapped in a `context`. This also happens when the description is too long.

#### Bad Example

```ruby
it 'returns the display name if it is present' do
  # ...
end
```

#### Good Example

```ruby
context 'when display name is present' do
  it 'returns the display name'
end

# This encourages the addition of negative test cases that might have
# been overlooked
context 'when display name is not present' do
  it 'returns nil'
end
```

### `describe` block naming

- use hash `#method` for instance methods
- use dot `.method` for class methods

Given the following exists

```ruby
class Article
  def summary
    #...
  end

  def self.latest
    #...
  end
end
```

#### Bad Example

```ruby
describe Article do
  describe 'summary' do
    #...
  end

  describe 'latest' do
    #...
  end
end
```

#### Good Example

```ruby
describe Article do
  describe '#summary' do
    #...
  end

  describe '.latest' do
    #...
  end
end
```

### `it` in iterators

Do not write iterators to generate tests. When another developer adds a
feature to one of the items in the iteration, he must then break it out into a
separate test - he is forced to edit code that has nothing to do with his pull
request. Use shared examples instead.

#### Bad Example

```ruby
[:new, :show, :index].each do |action|
  it 'returns 200' do
    get action
    expect(response).to be_ok
  end
end
```

#### Good Example

more verbose for the time being, but better for the future development

```ruby

shared_examples 'responds successfully' do
  it 'returns 200' do
    get method
    expect(response).to be_ok
  end
end

describe 'GET new' do
  let(:method) { 'new' }

  it_behaves_like 'responds successfully'
end

describe 'GET show' do
  let(:method) { 'show' }

  it_behaves_like 'responds successfully'
end

describe 'GET index' do
  let(:method) { 'index' }

  it_behaves_like 'responds successfully'
end
```

### Factories/Fixtures

Use [FactoryBot](https://github.com/thoughtbot/factory_bot) to create test
objects in integration tests. You should very rarely have to use
`ModelName.create` within an integration spec. Do **not** use fixtures as they
are not nearly as maintainable as factories.

```ruby
subject { create(:some_article) }
```

### Mocks/Stubs/Doubles

Use mocks and stubs with caution. While they help to improve the performance
of the test suite, you can mock/stub yourself into a false-positive state very
easily. When resorting to mocking and stubbing, only mock against a small,
stable, obvious (or documented) API, so stubs are likely to represent reality
after future refactoring.

This generally means you should use them with more isolated/behavioral
tests rather than with integration tests.

```ruby
# double an object
article = double('article')

# stubbing a method
allow(Article).to receive(:find).with(5).and_return(article)
```

*NOTE*: if you stub a method that could give a false-positive test result, you
have gone too far. See below:

#### Bad Example

```ruby
subject { double('article') }

describe '#summary' do
  context 'when summary is not present' do
    # This stubbing of the #nil? method, makes the test pass, but
    # you are no longer testing the functionality of the code,
    # you are testing the functionality of the test suite.
    # This test would pass if there was not a single line of code
    # written for the Article class.
    it 'returns nil' do
      summary = double('summary')
      allow(subject).to receive(:summary).and_return(summary)
      allow(summary).to receive(:nil?).and_return(true)
      expect(subject.summary).to be_nil
    end
  end
end
```

#### Good Example

```ruby
subject { double('article') }

describe '#summary' do
  context 'when summary is not present' do
    # This is no longer stubbing all of the functionality, and will
    # actually test the objects handling of the methods return value.
    it 'returns nil' do
      allow(subject).to receive(:summary).and_return(nil)
      expect(subject.summary).to be_nil
    end
  end
end
```

### Dealing with Time

Always use [Timecop](https://github.com/travisjeffery/timecop) instead of
stubbing anything on Time or Date.

#### Bad Example

```ruby
it 'offsets the time 2 days into the future' do
  current_time = Time.now
  allow(Time).to receive(:now).and_return(current_time)
  expect(subject.get_offset_time).to be_the_same_time_as (current_time + 2.days)
end
```

#### Good Example

```ruby
it 'offsets the time 2 days into the future' do
  Timecop.freeze(Time.now) do
    expect(subject.get_offset_time).to eq 2.days.from_now
  end
end
```


### `let` blocks

Use `let` blocks instead of `before(:each)` blocks to create data for the spec
examples. `let` blocks get lazily evaluated. It also removes the instance
variables from the test suite (which don't look as nice as local variables).

These should primarily be used when you have duplication among a number of
`it` blocks within a `context` but not all of them. Be careful with overuse of
`let` as it makes the test suite much more difficult to read.

```ruby
# use this:
let(:article) { create(:article) }

# ... instead of this:
before { @article = create(:article) }
```

### `subject`

Use `subject` when possible

```ruby
describe Article do
  subject { create(:article) }

  it 'is not published on creation' do
    expect(subject).not_to be_published
  end
end
```

### Magic Matchers

Use RSpec's 'magical matcher' methods when possible. For instance, a class
with the method `published?` should be tested with the following:

```ruby
it 'is published' do
  # actually tests subject.published? == true
  expect(subject).to be_published
end
```

### Incidental State

Avoid incidental state as much as possible.

#### Bad Example

```ruby
it 'publishes the article' do
  article.publish

  # Creating another shared Article test object above would cause this
  # test to break
  expect(Article.count).to eq(2)
end
```

#### Good Example

```ruby
it 'publishes the article' do
  expect { article.publish }.to change(Article, :count).by(1)
end
```

### DRY

Be careful not to focus on being 'DRY' by moving repeated expectations into a shared environment too early, as this can lead to brittle tests that rely too much on one another.

Generally, is it best to start doing everything directly in your `it`
blocks even if it is duplication and then refactor your tests once they are working, to be a little more DRY.
However, keep in mind that duplication in test suites is NOT frowned upon,
in fact it is preferred if it provides easier understanding and reading of a test.


# Credit

We based this guide on [reachlocal/rspec-style-guide](https://github.com/reachlocal/rspec-style-guide)
