### Promote a healthy culture when it comes to reviewing PRs
Try to be polite, and empathetic, it is always better to enjoy our daily basis with our colleagues

If you need to request a change, instead of comenthing like this
[Agressive comment](https://github.com/rootstrap/tech-guides/pull/84#discussion_r1336005098)

You can comment like this, asking for his/her opinion and using emojis
[Good comment](https://github.com/rootstrap/tech-guides/pull/84#discussion_r1336010709)

It is important trying to maintain a good environment when at work, because at the end, we pass a big part of our week on it.

### Ask if you don't understand something
When you don't understand something or it's not completely clear to you why a decision was took, just ask. It's always better to clear all doubts than to approve something you are not sure.

### Promote a learning culture when reviewing code
It is important to understand that we make code review to be sure that our base of code is optimal, and has the best practices in every PR, but code reviewing is also a good moment to learn and explain concepts to/from other devs.

`Perhaps we can avoid using ILIKE in a query because it doesn't exist on SQLServer and if we change of DBMS it can break . What do you think?`

### Focus on code review standards instead of personal preferences
When we code review it is important to base ourselves on best practices when developing and not so much on personal preferences. In the end, software development will always include personal points of each developer and it is also important to take this into account.

### Do you have a checklist?
It's important to make code review having in mind the quality attributes. Let's see an example related to performance

```ruby
#Assuming you have this HTML file

# products/index.html.erb
@products.each do |product|
  product.tags.each do |tag|
    <%= tag.name %>
  end
end

#There is a performance difference between these two controller implementations
# In the first one we are performing a query each time we call a tag
# But in the second one, we only perform just one query with everything we need, and after that, we render

class ProductsController < ApplicationController
  def index
    @products = Product.all
  end
end

VS

class ProductsController < ApplicationController
  def index
    @products = Product.all.includes(:tags)
  end
end
```

### Understand what are you looking for
It is important to understand why we do CR and what points we must take into account for CR to be truly effective and useful. Some suggestions for this:

- Do I understand what the code does?
- Does the code work as I expect it to?
- Does this code fulfill regulatory requirements?
- Do tests cover all possible scenarios?
- Does each module of code is being tested?
