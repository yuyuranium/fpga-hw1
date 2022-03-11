# fpga-hw1
Homework 1 of FPGA design

## Getting started

### Project structure

Let's follow the structure shown below.

```
fpga-hw1
|-- Problem1
|   |-- bit
|   |-- src
|   |   `-- divider.v
|   `-- xdc
|       |-- blinky.xdc
|       `-- pynq-z2_v1.0.xdc
|-- Problem2
|   |-- bit
|   |-- src
|   |   `-- divider.v
|   `-- xdc
|       |-- blinky.xdc
|       `-- pynq-z2_v1.0.xdc
`-- README.md
```

### To clone the repo

```bash
git clone git@github.com:yuyuranium/fpga-hw1.git
```

### Following GitHub flow

The *GitHub flow* is a popular workflow for numerous collaborators working on a single repository. Let's follow the flow.

1. **Create a branch**

   Whenever we want to *add or modify something*, we should first create a branch.

   - Make sure we have the latest update of `main`

     ```bash
     git checkout main
     git pull origin main
     ```

   - Create and checkout a new branch from `main`

     ```bash
     # On branch main
     git checkout -b <the_branch_name>
     ```

   - `checkout` means we want to checkout another branch

   - The `-b` flags means that we also want to create a new branch with its name being `<the_branch_name>`

   - **How to name our branch**

     Let's follow the format

     ```
     <author>/<branch-type>/<branch-name>
     ```

     - `<author>` is just our id, like `yuyuranium`.

     - `<branch-type>` can be one of the following:

       - `wip`, work in progress, meaning that the work is in progress, and I am aware *it will not finish soon*.
       - `bug`, the bug which needs to be fixed soon.
       - `feat`, feature, meaning that some features are added to our work.

     - `<branch-name>` should simply summarize what we are going to do.

       For example, in the last homework, `yuyuranium` was working on the top module, so he could name his branch like

       ```
       yuyuranium/wip/add-top-module
       ```

       or say `WillyChennnn` fixed the [issue #4](https://github.com/yuyuranium/fpga-hw0/issues/4) for the `busy` signal

       ```
       WillyChennnn/bug/fix-busy-signal#4
       ```

       Note that we can use `#4` to indicate that this branch is to fix the [issue #4](https://github.com/yuyuranium/fpga-hw0/issues/4).

   - After that, we should now on our own branches. (Use `git status` to check that)

2. **Make changes**

   Once we're on our own branch, we may add and commit whatever we've added or altered as usual.

   ```bash
   git add .
   git commit -m "Commit message"
   ```

3. **Push changes to GitHub**

   We push our commits to GitHub so that we can see each other's work.

   ```shell
   git push origin <the_branch_name>
   ```

   - `origin` simply means the remote repo on **GitHub**
   - Make sure that we pushed to the branch with the same name, i.e. `<the_branch_name>`, as that we created on our local repo.
   - **Don't push to `main` directly**.

   Continue to make, commit, and push changes to your branch until you are ready to ask for feedback (i.e., Create a *pull request*).

4. **Create a *pull request (PR)***

   - **Pull request** is to ask other collaborators checkout our work, give us some feedbacks and finally include our work into `main`.

   - Once we pushed our commits to GitHub, we can see the button like this

     ![](https://imgur.com/64e3ZVg.png)

   - Press **Compare & pull request**.

     ![](https://imgur.com/ofzZDBi.png)

   - Here we can simply summarize what we have done by leaving a comment.

   - Make sure to **request others to be the reviewers** so that everyone can review our work.

   - After that, press **Create pull request**.

     ![](https://imgur.com/aZrbsiJ.png)

   - Then the **pull request** would look like the figure above.

   - If we are reviewers (we should receive an email from GitHub asking us to review the PR), click **Files changed** to see what contents were changed in this PR.

     ![](https://imgur.com/2gYT3Jd.png)

   - We can even add comment to a single line of code by clicking blue `+` button beside the line number.

     ![](https://imgur.com/1YfDrXm.png) 

   - We should think of GitHub as a **social media** platform where we can collaborate together, leave comments, ask for help, and communicate with one another.

5. **Merge your *pull request***

   - **We should wait until everyone reviews and approves our PR. (i.e., no *pending reviewers*)**

   - We can merge it ourselves when *all reviewers have approved the PR* or the *last reviewer* can directly approve and help the author merge the PR.

     ![](https://imgur.com/NKe9JUi.png)

   - Let's try it [here](https://github.com/yuyuranium/fpga-hw0/pull/8). (Review and approve `yuyuranium`'s PR)

6. **Delete your branch (optional)**

   After the branch is merged into `main`, our work have been successfully included in the `main` branch. We can now safely delete the branch by clicking **Delete branch**, which indicates that the work on the branch is complete and prevents you or others from accidentally reusing old branches.

   ![](https://imgur.com/j36nn6O.png)

   - We should not use the merged branch again, unless we just want to do a hot-fix (small changes that are in a hurry).
   - If we continue work on other things (like adding another module, fixing some bugs), **create a new branch** instead.

7. **Follow up the main branch**

   When someone's PR is merged into main, we could follow up the update by

   ```shell
   git checkout main     # Go back to the main branch
   git pull origin main  # Pull the latest commits on the main branch of the remote repo
   ```

   If you are working on another branch and you also want to pull the update to your branch.

   - **Don't pull main in your branch**.

   - **Don't merge main in your branch**.

   - Do this instead

     ```bash
     # On your own branch
     git pull origin main --rebase  # Pull the update on origin main to your own branch and rebase
     
     # Or if your local main has the latest update already, simply do
     git rebase main
     
     # Finally update the remote repo
     git push origin <your_branch_name> -f  # Force update the branch on the remote repo
     ```

     - `--rebase` will change the root of your branch(i.e., base) directly to the latest commit of the main branch.

     - `-f` will **force** push your local branch and **overwrite** the remote branch.
       - **This command is dangerous so don't ever try it on the branch that is not yours.**

   - An example to visualize

     Imagine that we are currently working on the branch `wip`, and the `master`(or say, `main`) has 2 new updates(commit `4ad1503` and `0c20d57`) that were not included in our branch. After the `--rebase` operation, our branch `wip` will directly grow on the head of `master` branch as follow. Now those 2 new commits are included in our branch.

     - Before

       ![](https://imgur.com/VH6HcwR.png)

     - After

       ![](https://imgur.com/xK6KbYW.png)

​		For further details, please reference [here](https://docs.github.com/en/get-started/quickstart/github-flow).
