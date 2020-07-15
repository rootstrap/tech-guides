# Open Source Recommendations

Rootstrap enjoys being a part of the open source community and considers that open source is good for everyone. By embracing open source, it enables collaboration for solving specific problems and helps in reducing bugs.

This is a guide for publishing and maintaining open source projects, check the Github guidelines for Open Source:
  - [Getting started](https://opensource.guide/starting-a-project/)
  - [How To contribute](https://opensource.guide/how-to-contribute/)
  - [Best practices for maintainers](https://opensource.guide/best-practices/)
  - [Code of Conduct](https://opensource.guide/code-of-conduct/)

**Make sure to have:**
- License (default: [MIT](https://opensource.org/licenses/MIT))
- Code of Conduct (default: [Contributor Covenant](https://www.contributor-covenant.org/))
- Continuous Integration (default: [TravisCI](https://travis-ci.org))
- Code Quality tools (default: [CodeClimate](https://codeclimate.com))
- Readme with: Description, Prerequisites/Installation, Usage, Company credits and links to items above (template: [README example](./OSS_README_example.md))
- Follow [semver](https://semver.org/) for good versioning. Start with version `0.1` and once it has been successfully used in at least one project upgrade to `1.0`. Generate a new git tag when releasing a new version.
- For libs use the `master` branch not the `develop` branch as we'd normally do with apps.
- Add https://rootstrap.com as the repo website and remove unused tabs and sections
  - <img src="https://user-images.githubusercontent.com/5280619/87554028-fd41f980-c689-11ea-97f9-4cf4dc90b777.gif" width="500">


**The items listed below are nice to have for the repository but aren't mandatory:**
- Add Changelog
- Blocked main branch for force push

For ruby specific details check [developing Gems](./developing_gems.md)
