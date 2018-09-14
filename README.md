# ansible/gitlab-mirroring

Mirrors repositories from a private hosted Gitlab instance to Gitlab.com and Github.com

To avoid naming conflicts on the target repositories, all source repositories belonging
to a group, the group name will be appended like `<groupname>-<reponame>`

# mandatory variables to set

This role needs to know the API-Access tokens for the self hosted Gitlab instance (source) as well as for the targets:

* SOURCE_GITLAB_TOKEN
* GITLAB_TOKEN
* GITHUB_TOKEN

# optional variables

Please consult the `defauls/main.yml`.
