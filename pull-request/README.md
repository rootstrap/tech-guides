# Opening a Pull Request

- Define scope (What are you tackling on this PR?):
    The maximum scope of a PR should be a complete User Story.
    However, sometimes a single User Story may result in too many changes in the code base making your PR too difficult to review and once reviewed, too difficult to address all the comments you received.  
    In this cases a better approach is to break the User Story even further.
    
    For example, we get this User Story: "As a user, I want to be able log in to the app." 
    This User Story can be implemented in different PRs to facilitate review, as follows:
        - "As a user, I want to be able to enter my email and password into a log in form and hit the submit button"
        - "As a user I should see errors if the email or password I entered are incorrect"
        - "As a user I should be logged in to the system if I entered correct email and password"
    
    
- Implement the needed code changes:
    If tackling a big/complex feature is considered good practice to discuss the approach with teammates and tech colleagues that will be reviewing your code later. 
- Run/test your code manually to make sure it works and all the scoped functionality works as expected without breaking previous functionality. 
- Make sure your Unit Tests, Automated Tests, etc document all the changes.
- Make sure that pre-existent tests still run correctly. 
- Add any tags you consider relevant to your Pull Request.
- Update status of User Story and link it to the Pull Request.
- Request a review for at least two developers familiar to the technology or code-base.
    If there are reviewers assigned to your project make sure to request a review from them.
