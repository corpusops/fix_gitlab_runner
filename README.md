# gitlab fixers

# DISCLAIMER

**UNMAINTAINED/ABANDONED CODE / DO NOT USE**

Due to the new EU Cyber ​​Resilience Act (as European Union), even if it was implied because there was no more activity, this repository is now explicitly declared unmaintained.

The content does not meet the new regulatory requirements and therefore cannot be deployed or distributed, especially in a European context.

This repository now remains online ONLY for public archiving, documentation and education purposes and we ask everyone to respect this.

As stated, the maintainers stopped development and therefore all support some time ago, and make this declaration on December 15, 2024.


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
