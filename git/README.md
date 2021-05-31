# Git Workflow

We use style guides and standards on a daily basis to help us keep a unified criterion regarding each type of technology. The main aim of this document is to create a git workflow standard for all the different projects in the company.

There are many advantages that come with the use of the previously mentioned criteria. One of them is that it allows us to have the same nomenclature to make it easy to incorporate new team members as well as keeping a better project organization. Furthermore, it tackles common problems by providing effective solutions. Last but not least, the workflow focuses on keeping a tidy and reliable history that truly reflects the project’s current state.

Below is listed the document content. Some of the instructions are mandatory and need to be followed throughout the development process of any project. The mandatory specifications are highlighted with a **[Required]** label. Even though some of the directions are not mandatory, they are highly recommended.


 [Spanish version](./README-es.md)


## Table of Contents

- [Branches](#branches)
  - [Before releasing to production](#before-releasing-to-production)
    - [Develop branch (develop)](#develop-branch-develop-required)
    - [Staging branch (staging)](#staging-branch-staging-required)
    - [QA branch (qa)](#qa-branch-qa-optional)
    - [Feature branch (feature/x)](#feature-branch-featurex)
    - [Fix branch (fix/x)](#fix-branch-fixx)
    - [Enhancement branch (enhancement/x)](#enhancement-branch-enhancementx)
    - [Feedback branch (feedback/x)](#feedback-branch-feedbackx)
    - [Demo branch (demo)](#demo-branch-demo)
  - [Post production release](#post-production-release-)
    - [Master branch (master)](#master-branch-master-required)
    - [Release branch (release_branch_x)](#release-branch-release_branch_x-required)
      - [Integration of a Release branch to master and develop](#integration-of-a-release-branch-to-master-and-develop)
    - [Feedback branch (feedback/x)](#feedback-branch-feedbackx-1)
    - [Hotfix branch (hotfix/sign-up)](#hotfix-hotfixsign-up-required)
- [Release management](#release-management)
  - [Before releasing to production](#before-releasing-to-production-1)
  - [After releasing to production](#after-releasing-to-production-required)
    - [First release to production](#first-release-to-production)
    - [Other releases to production](#other-releases-to-production)
      - [Major changes (MAJOR)](#major-changes-major)
      - [Minor changes (MINOR)](#minor-changes-minor)
      - [Bug fixes (PATCH)](#bug-fixes-patch)


# Branches

## Before releasing to production

This section contains aspects related to branch management before releasing to production.

### Develop branch (develop) **[Required]**

This branch is the main one because it reflects the work done by the whole team during the development phase in a project. It is used as the base branch until the app is released to production.


* **Origin:** *master* (in the initial project set up this branch is created from master)
* **Destination:** -
* **Use case:** Integration of the work done by the development team.

### Staging branch (staging) **[Required]**

This branch has all the features ready to be tested by the Client.

If the project has CD configured, every time something is merged into this branch the code will be automatically deployed to the Staging environment for the Client to test.

* **Origin:** *master* (in the initial project set up this branch is created from master)
* **Destination:** -
* **Use case:** Integration of the work done by the development team which is already tested and approved by the QA team and ready for the Client to review.

### QA branch (qa) **[Optional]**

This branch has all the features ready to be tested by the QA team.

If the project has CD configured, every time something is merged into this branch the code will be automatically deployed to the QA environment.

* **Origin:** *master* (in the initial project set up this branch is created from master)
* **Destination:** *staging*
* **Use case:** Integration of the work done by the development team ready for QA team to test.

**_Note_**: *If a feature merged into the QA branch is not ready to be promoted to the Staging branch, then all needed changes (like: fixes, removing the feature, disabling access to it, etc) should be made in the Develop branch, followed by the promotion of those changes to the QA branch to continue the flow.*

### Feature branch (feature/x)

This branch’s purpose is to develop a new feature. It has all the progress until the functionality being developed is completed. Pull requests are created from these type of branches and once they have passed the code review process, they have to be merged to develop.

_Example: feature/sign-up_

* **Origin:** *develop*
* **Destination:** *develop*
* **Use case:** Develop a new feature during a sprint.

<p align="center">
  <img src="GitWorkflowDiagram.png" width="600px" height="440px"/>
</p>

### Fix branch (fix/x)

This branch is created in order to fix a bug during the development phase.

_Example: fix/sign-up-error-messages_

* **Origin:** *develop*
* **Destination:** *develop*
* **Use case:** Fix a bug during development

### Enhancement branch (enhancement/x)

This branch is created to add an enhancement during the development phase on something that was already merged to the development branch.

_Example: enhancement/users-retrievement-query_

* **Origin:** *develop*
* **Destination:** *develop*
* **Use case:** Add an enhancement during development.

### Feedback branch (feedback/x)

It is used to work on feedback provided by any team member or the PO about a previously developed feature.

_Example: feedback/sign-up-change-inputs-order_

* **Origin:** *develop*
* **Destination:** *develop*
* **Use case:** Implement feedback given by the PO or any other team member about a specific feature previously developed

### Demo branch (demo)

This branch has two main aims:

1. Avoid interference with code review process
2. Show the PO all the progress done by the team in a review session

It is a temporal branch created from develop where all branches that are not ready to be integrated to develop are merged. The only purpose of this branch is to present things in the demo, so it should be immediately discarded after performing it.

Changes in this branch will be reflected in develop after reviewed and approved in a code review process.

* **Origin:** *develop*
* **Destination:** - (delete branch)
* **Use case:** Integration of all the features (completed or not) needed in a review session. A PR approved by code review is a requirement to merge a new feature to **_develop_**, sometimes, due to different reasons (incomplete or unreviewed code), new features are not ready on time to be presented to the PO in a demo. In order to solve this inconvenience, a temporal branch is created to be deployed or to create a build from it (depending on technology); there, all the branches to be shown in a review can be merged automatically without the need of a code review.

If there is a change of any kind in the feature branches in a commit (*git amend*) or in the history (*git rebase*), a new *demo* branch can be created to reflect the change or it can just be merged in the existing branch.

**_Note_**: *Despite the fact that this branch's main purpose is showing the progress in a review, it is not advised to send a version from that branch. In these cases you should talk to project or company referents.*

*This branch can be deployed in an environment previous to staging such as development. See: Environment management base on the git workflow (work in progress).*

<p align="center">
  <img src="demo-branch.jpg" width="420px" height="500px"/>
</p>

## Post production release <a name="post-release"></a>

This section’s purpose is explaining branch management after releasing to production.

All the previously mentioned branches must be used in the same way they were used before release, except for those branches which are explained again under this section.

The main purpose is to keep commits history as clean as possible. As a consequence, classical approaches based on *cherry-pick* and *merge* to keep branches up to date are replaced for the use of *rebase*.

### Master branch (master) **[Required]**

It reflects the current code deployed in production, therefore, it must be stable. All the new features to be developed are going to have as origin *develop* and they are going to be merged to master once they are working as expected and approved by PO in the Staging environment.

* **Origin:** -
* **Destination:** -
* **Use case:** Reflect production’s current state.

### Release branch (release_branch_x) **[Required]**

Its main objective is to separate new features ready to be released to production from those that either the team or the client do not consider to be ready for release. As a consequence, this branch only contains features that are production ready.

It should be deployed in a testing environment (usually staging) accessible to the client and all the feedback given by him/her must be included in this branch.

The timing in which this branch should be created depends on the project and the team. In projects with big teams is convenient to create it when the development of the first feature in the version starts. However, when teams are small it is better to create it once all the features to be released are completed. This is the most common scenario in the company.

* **Origin:** *develop*
* **Destination:** *master and develop*
* **Use case:** Merge feedback or fixes to code that were released to a testing environment. If there are bugs to fix or feedback to include after the branch has been released to a testing environment, they should be merged to this branch and not to *develop.* In this way, we avoid releasing future features that belong to a different release and were merged to *develop* by another developer in the team. Furthermore, it allows us to keep track of features we will release next.

#### **Integration of a Release branch to master and develop**

Once the release branch is ready to go to production it should be included in master and develop as well.

**Master**

It is directly included in **master** through a Pull Request created from master. Ideally, every commit in that PR passed through a code review process, consequently, another code review is unnecessary to merge it, the developer should just check everything is correct.

**Develop**

It is directly included in **develop** through a Pull Request created from the release branch. Everything said for the master branch applies here too.

### Feedback branch (feedback/x)

This branch is created to work on feedback related to a specific feature.

_Example: feedback/sign-up-change-inputs-order_

* **Origin:** *release branch*
* **Destination:** *release branch*
* **Use case:** Feedback from the client or any team member about a feature after its release branch has been deployed to a testing environment.

### Hotfix (hotfix/sign-up) **[Required]**

This branch is created to solve bugs or critical changes that should not be mixed with the current development —*develop*— branch.

Development bugs should not be confused with these bugs, development bugs should be merged to *develop or a release branch.* Not every bug deserves a hotfix, a hotfix aims to solve a critical bug that directly affects essential system functionality.

It is the **developer's responsibility** to reflect that hotfix in develop by also submitting a Pull Request from this branch.

* **Origin:** *master*
* **Destination:** *master and develop*
* **Use case:** Critical changes that affect the expected behaviour of the application in production.

<p align="center">
  <img src="hotfix-branch.png" width="600px" height="600px"/>
</p>


# Release management

In this section, we explain how releases before and after production should be handled.

**_What is a release?_**

It is a link to a new version with notes describing all the changes implemented since the last version.

These versions are handled with tags which are automatically created with every new release. Tags are immutable pictures of a branch.

**_Advantages_**

Version management sprint to sprint or post production is a way of keeping track of all the versions available in staging and specially in production, so we can better organize our work.

## Before releasing to production

Once the sprint is finished and feedback from the client was included, a release is created. See [https://help.github.com/articles/creating-releases/](https://help.github.com/articles/creating-releases/)

* **Origin:** develop
* **Versión:** v0.x, x being the current sprint number.
* **Title:** Release sprint x, x being the current sprint number.
* **Description:** should contain a list with all the features developed during the sprint.

_Note: version management before releasing to production is highly recommended but not mandatory._

## After releasing to production **[Required]**

Releases after production are the most important ones because they allow us to have an immutable image of the code in production. In this case, releases are always created from *master*. For example, after merging a hotfix or release branch into master.

### First release to production

The first time the app is released to production, there must be a merge of all the content in *develop* to *master.* Then, the release is created.

* **Origin:** master
* **Version**: v1.0
* **Title:** Release v1.0
* **Description:** high level details of the features developed


### Other releases to production

After the first release to production, it is recommendable to use the standard MAJOR.MINOR.PATCH.

#### Major changes (MAJOR)

Version in which incompatible changes with the previous version or a big number of features that represent a change at the business level are introduced.

* **Origin:** master
* **Version:**  (vMAJOR + 1).0.0
* **Title:** Release (vMAJOR + 1).0.0
* **Description:** new features and minor bug fixes

#### Minor changes (MINOR)

When new functionalities and non-critical bug fixes are released we increase the MINOR value to generate a new version.

* **Origin:** master
* **Version:** vMAJOR.(MINOR + 1).0
* **Title:** Release vMAJOR.(MINOR + 1).0
* **Description:** new features and minor bug fixes


#### Bug fixes (PATCH)

It contains urgent and non-urgent bug fixes. If bugs do not require immediate action, we wait until some bugs are fixed to release a new version. When a bug is urgent a new release must be created.

* **Origin:** master
* **Version:** vMAJOR.MINOR.(PATCH + 1)
* **Title:** Release vMAJOR.MINOR.(PATCH + 1)
* **Description:** fixed bugs that are important
