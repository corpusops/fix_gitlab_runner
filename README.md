# gitlab fixers
**UNMAINTAINED/ABANDONED CODE / DO NOT USE**
## fix 1736
- see [#1736](https://gitlab.com/gitlab-org/gitlab-runner/issues/1736)
    - see [defaults](./roles/fix_gitlabrunner_perms/defaults/main.yml)
    - setup umask ``0022`` as ``pre_clone_script``
    - clear/remove any cache volumes
    - clear/remove any gitlab data containers
- you need to ``pip install tomlkit`` inside your ansible python install.

```sh
ansible-playbook -vvv fix1736.yml  # [-e "{fix_gitlab_dryrun: 1}"]
```
