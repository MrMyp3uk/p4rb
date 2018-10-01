# P4RB
### Debian-based Review Board Docker image with Perforce VCS and LDAP auth support

## Usage
Simply run `docker-compose up -d` command from within the repository root using the default settings. Or use docker-compose.yml as a template and change any default settings (passwords, ports, etc) to whatever suit your needs.

## Using Review Board with P4V on Windows
First you need to create and configure [Perforce repository](https://www.reviewboard.org/docs/manual/dev/admin/configuration/repositories/perforce/#repository-scm-perforce) on the Review Board [admin page](https://www.reviewboard.org/docs/manual/dev/admin/admin-ui/overview/#administration-ui) as admin. Next, every RB user should follow these steps:
1. Install [RBTools](https://www.reviewboard.org/downloads/rbtools/)
2. Install [GNU diff](http://gnuwin32.sourceforge.net/packages/diffutils.htm) and add path to its bin folder to _PATH_ environment variable
3. Generate [API token](https://www.reviewboard.org/docs/manual/dev/users/settings/#api-tokens) to let RBTools utility safely access Review Board without asking for user credentials every time
4. Add `.reviewboardrc` file (use the [template](client/.reviewboardrc)) to the workspace root
5. Add P4V Custom Tool:
    - Download [tools.xml](client/tools.xml)
    - Run P4V app
    - Open user's workspace
    - Open **Tools** -> **Manage Custom Tools...** menu
    - Click **Import tools...** button, choose tools.xml file in the opened dialogue window
    - Press **Import** button in the _Import preview_ window then press **OK** to close the _Manage Custom Tools_ dialogue
6. To create a new review request select any pending (except for default one) or shelved change list and either
    - right-click selected change list and click **Review Request** context menu item
    - open **Tools** menu and click **Review Request** submenu
7. The above step will open P4V console window reporting the current Review Request _post_ progress. Once _post_ operation is finished, go to Review Board to preview the newly created review request, assign reviewers and finally publish the review request.

## Notes
This repository is based on [alpine-reviewboard](https://github.com/easybe/alpine-reviewboard) by @easybe so if you find it useful please consider giving a star to that fine gentleman :)