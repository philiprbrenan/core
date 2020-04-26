# Manual installation instructions

- Install Raysect with special branch - feature/mesh_uv_points
    git clone raysect...
    cd raysect
    git checkout feature/mesh_uv_points
    python setup.py develop

- Install Cherab with master branch

    git clone https://github.com/cherab/core.git cherab
    cd cherab
    git checkout master
    python setup.py develop

- install VITA
    python setup.py develop --include-cherab

# Automated installation instructions

If you would prefer to see this software in action first before committing to
installing it on your own computer, please **fork** it first as described
below:

## Fork

The use of actions in this repo makes it easy for you to get results
immediately by:

1. Forking this repo to a new GitHub repo under your userid by pushing the
**Fork** button in the top right hand corner on page:

    https://github.com/vitaProject/core

2. Optionally making changes to the python files in the forked repo using the
GitHub online editor.

3. Creating and committing file:

    .github/control/runTestsInClone.txt

to the master branch with any random content in it to kick off the workflow in:

    .github/workflows/runTestsInClone.yml

4. Waiting for GitHub Actions to bring all the generated output svg images in
**out/** and and generated html files in **docs/** back up to date.

You can then see the effects of your changes directly on GitHub avoiding any
security/performance/installation issues on your local computer.

## Push

Any subsequent pushes you make to the master branch of the cloned repository
will invoke GitHub Actions to bring the master branch of this repository back
up to date as long as the control file:

    .github/control/runTestsInClone.txt

is present on the master branch.

## Clone

If you want to make lots of changes to your forked repository, you might prefer
to **clone** it to your own computer for faster local access or to a computer
that you have access to in the cloud.  This computer will need to be set up
appropriately with the correct software packages. The exact set up procedure is
unambiguously described in:

    .github/workflows/vita.yml

## Pull Request

Eventually you might want to submit some of the changes you have made back to
master copy at:

    https://github.com/vitaProject/core

To achieve this goal, you should update the master branch of your forked copy
so that it contains just the desired changes and nothing else. In particular
the forked copy should not contain any of the generated documentation or test
output files as the content of these files will differ from those in the master
repository. A pull requests with these files present will generate excessively
long pull request merge lists which GitHub is unable (at this time) to process.

These files can be conveniently deleted by running the workflow:

    github/workflows/prepareForPullRequest.yml

This workflow only runs if there is a file:

    .github/control/prepareForPullRequest.txt

present in the repository. The easiest way to ensure that this is the case is
to manually create such a file with any random text in it using the online
GitHub editor.  When this file is committed the workflow is automatically
started.

The control files:

    .github/control/prepareForPullRequest.txt
    .github/control/runTestsInClone.txt

are automatically deleted by a successful run of the workflow in:

    prepareForPullRequest.yml

so that subsequent pushes to the your repository will not trigger any workflow
until one or both of these files has been recreated.

Once the repository has been successfully prepared for a pull request, you
should create an issue on the master repository:

    https://github.com/vitaProject/core

requesting a pull request against the master branch of your forked copy.
