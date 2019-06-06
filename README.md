# Projects API
This repository contains all project information developed by Clyde.

[![Build status](https://clydedsouza.visualstudio.com/Personal%20website/_apis/build/status/Projects%20Master)](https://clydedsouza.visualstudio.com/Personal%20website/_build/latest?definitionId=28) 
![Release status](https://clydedsouza.vsrm.visualstudio.com/_apis/public/Release/badge/803b6533-06e1-4f49-9519-39eca0216124/1/1) 
![Azure DevOps tests (branch)](https://img.shields.io/azure-devops/tests/clydedsouza/Personal%20website/28/master.svg?logo=Powershell&logoColor=white) 
![Development status](https://img.shields.io/static/v1.svg?label=status&message=under%20development&color=informational)

## Technical process
I'm using the concept of a [static API generator](https://css-tricks.com/creating-static-api-repository/) to generate `JSON` files from my static data, in this case, markdown files located in the `projects` folder.

### Markdown files
Each markdown file corresponds to a single project. The front matter part of the markdown file contains the meta data for the project that will be processed into the API file and optionally, some project write-up below it. At this stage, I'm not planning to use the write-up section but in future I'd probably have a 'project details' page on my site where I can display the markdown content (probably use a JS plugin to convert markdown to HTML) straight into my partial view.

To convert the front matter part of each markdown file into API, I'm using the [markdown-to-json npm package](https://www.npmjs.com/package/markdown-to-json). I've written a PowerShell script to invoke this utility.

### Azure DevOps
When I commit and push to `master`, a build is triggered that executes the PowerShell script in different ways (to generate various versions of the API based on the same data set) and make an artifact available. The release pipeline then picks up the contents made available by the build pipeline and deploys them to the `gh-pages` branch of this repository. I've used [this](https://marketplace.visualstudio.com/items?itemName=AccidentalFish.githubpages-publish) Azure DevOps task in my release pipeline to publish. 



