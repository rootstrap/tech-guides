# Opening a Pull Request(PR)

Think in your PR as something you are selling to your fellow developers, you the author are the seller, and the reviewers are the customers. You want to be as effective as possible in demostrating the value of your code, and why it is needed. This guide will try to help you accomplish that.

1. Define scope (What are you tackling on this PR?):
      
      **User Stories/Features:**
      
      The maximum scope of a PR should be a complete User Story.
            However, sometimes a single User Story may result in too many changes in the code base making your PR too         difficult to review and once reviewed, too difficult to address all the comments you received.  
           In this cases a better approach is to break the User Story even further.
    
      For example, we get this User Story: "As a user, I want to be able log in to the app." 
      This User Story can be implemented in different PRs to facilitate review, as follows:
      
         - "As a user, I want to be able to enter my email and password into a log in form and hit the submit button"
         - "As a user I should see errors if the email or password I entered are incorrect"
         - "As a user I should be logged in to the system if I entered correct email and password"


      **Bug fixes/Minor tasks:**
      
      It may sound like a good idea to mix together a lot of small bug fixes in a single PR, yet this will result on reviewers having a hard time identifying the topic of your PR or even, understanding what is it about.
      A good practice would be to either have one PR per bug fix or -in some cases- have a few bug fixes that are related with each other in a single PR.
    
    
2. Implement the needed code changes:
    If tackling a big/complex feature is considered good practice to discuss the approach with teammates and tech colleagues that will be reviewing your code later. 
3. Run/test your code manually to make sure it works and all the scoped functionality works as expected without breaking pre-existent functionality. 
4. Make sure your Unit Tests, Automated Tests, etc document all the changes.
5. Make sure that pre-existent tests still run correctly. 
6. Use descriptive messages in your commits.
7. Add any tags you consider relevant to your PR.
8. Choose a PR title that describes the main intent of it.
9. Add a description enumerating: Issues fixed, user stories addressed and any relevant information for the reviewer. This might include screenshots and/or gifs showcasing the intended feature.
10. Update status of User Story and link it to the PR.
11. Request a review for at least two developers familiar to the technology or code-base.
    If there are reviewers assigned to your project make sure to request a review from them.
