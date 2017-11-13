# RSpec Tutorial/Guide

RSpec is a testing tool for Ruby, it is the most frequently used testing library in Ruby applications, and it was the source of inspiration for testing tools in other languages like jasmine and mocha.  This tutorial will aim to steer you into the path of testing and show you the different ways of testing.

There are some key parts in an RSpec test:
* `describe`: it is an example group, usually groups the tests of a method or class.
* `it`: the atom of the tests, it should contain one test/expectation.
* `before`: hook that executes before a  group of tests, depending where is located, if it’s located inside a describe or context, it will be executed before  the tests inside the describe or context. By default runs before each test, but you can pass the option `:all` to run before all of them only.  It’s usually used for testing setup
* `after`: same as before, but after the tests, it’s usually used for teardown setup.
* `context`: same behavior as `describe` but it’s used for a semantic purpose: each block of tests inside the context behaves in a certain way or under certain conditions. As an example, you can check it in model specs.
* `let`: it's a helper method for variables. The value will be cached across multiple calls in the same example but not across examples.

## Model specs
They are straightforward unit tests which tests small parts of the system, they shouldn’t test private methods, just model’s methods and callbacks. These unit tests follows the same rules as services, jobs, mailers and any other ruby classes, except controllers that needs some setup.

```
describe User do
  describe '#full_name' do
    let(:user) { create(:user) }

    it 'returns the correct name' do
      expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
    end
  end

  describe '.search' do
    let(:user) { create(:user) }

    context 'with the right term' do
      it 'returns a user' do
        expect(User.search(user.name)).to include user
      end
    end

    context 'with another term' do
      it 'returns 0 users' do
        expect(User.search('whatever')).to be_empty
      end
    end
  end
end
```

As you can see, instance methods are described with `# `and class methods with `.` .

## Feature specs
Feature specs are integration tests that aim to cover all the application flow, it starts when a user does something in the UI (like clicking a button) and finishes when the user sees the response (like an alert). Thus they are written from the user viewpoint, but in some cases you can check the Model/DB if there aren’t a visible response or to make sure the app is working as expected.

We use Capybara for interacting with the browser and PhantomJS (through the ruby driver poltergeist) or webkit to test pages with js. You can take a look at the capybara’s GitHub page [about drivers](https://github.com/teamcapybara/capybara#drivers). If your test doesn't need Javascript in order to verify the behavior, don't enable it. An example of feature test is:

```
describe 'User creates a task' do
  before do
    visit new_task_path
  end

  it 'can create a task' do
    fill_in 'Title', with: 'My new task'
    fill_in 'Description', with: 'I need to do the laundry'
    click_button 'Create Task'

    expect(page).to have_content 'The task was created'
  end
end
```

Also, Capybara comes with a built-in DSL for creating descriptive acceptance tests, where the previous code can be rewritten as:

```
feature 'User creates a task' do
  background do
    visit new_task_path
  end

  scenario 'can create a task' do
    fill_in 'Title', with: 'My new task'
    fill_in 'Description', with: 'I need to do the laundry'
    click_button 'Create Task'

    expect(page).to have_content 'The task was created'
  end
end
```

Both ways are accepted but the first one is the most used in the company because the other types of testings use the same structure. We recommend checking [this guide](https://robots.thoughtbot.com/write-reliable-asynchronous-integration-tests-with-capybara) that brings some tips at the time of doing feature testing.


## Controller specs
Although feature specs are great for acceptance tests, they are slower to run. So leave the edge case tests to your model or controller. However, don't use them for API test, you should be using requests specs for that. An example of it is the following:

```
describe RegistrationsController do  
  describe 'POST create' do
    let(:email) { 'email@example.com' }
    let(:password) { 'somepassword' }

    it 'redirects to the dashboard' do
      post :create, { email: email, password: password }
      expect(response).to redirect_to '/dashboard'
    end

    it 'creates an user' do
      expect do
        post :create, { email: email, password: password }
      end.to change(User, :count).by(1)
    end

    it 'shows a successfully flash' do
      post :create, { email: email, password: password }
      expect(flash[:notice]).to match(/You can start using the app!/)
    end    
  end
end
```

## Request specs
Requests specs are the integration tests for APIs (but way faster), they are designed to drive behavior through the full stack. We recommend doing requests specs over controller specs for APIs because the routes and real responses are covered. An example of them are:

```
describe 'POST api/v1/users/sign_in', type: :request do
  let(:user) { create(:user, password: password) }
  let(:params) do {
    user:
      {
        email: user.email,
        password: password
      }
    }
  end

  context 'with correct params' do
    before do
      post new_user_session_path, params: params, as: :json
    end

    it 'returns success' do
      expect(response).to be_success
    end

    it 'returns the user' do
      expect(json[:user][:id]).to eq(user.id)
      expect(json[:user][:email]).to eq(user.email)
    end
  end
end
```

## Testing tools
We use some tools that help and improve the testing experience, they are:

* [FactoryBot](https://github.com/thoughtbot/factory_bot): You can use `Product.create` in your test, but the setup of it could be tedious to do everywhere, so we prefer moving the data setup to one place: the factories. You can achieve this with Rails fixtures, but you don’t have too much control over them.
* [Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner): The idea behind it is to maintain a clean state between tests, so you don't have to worry about any data left by a previous test.
* [Faker](https://github.com/stympy/faker): It’s a library for generating fake data such as names, addresses, and phone numbers.
* [Webmock](https://github.com/bblimke/webmock)/[vcr](https://github.com/vcr/vcr):  It’s a library for stubbing HTTP request, you shouldn’t interact with real APIs during tests because you can reach API’s quota or make unexpected changes to real data.
