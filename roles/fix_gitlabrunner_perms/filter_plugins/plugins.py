# -*- coding: utf-8 -*-
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import tomlkit


def add_pre_clone_script(config, umask, ansible_vars):
    cfg = tomlkit.parse(config)
    for runner in cfg.get('runners', []):
        pcs = runner.setdefault('pre_clone_script', '')
        if 'umask' not in pcs:
            pcs += '\numask {0}'.format(umask)
        runner['pre_clone_script'] = pcs
    return tomlkit.dumps(cfg)


__funcs__ = {
    'add_pre_clone_script': add_pre_clone_script,
}


class FilterModule(object):

    def filters(self):
        return __funcs__
# vim:set et sts=4 ts=4 tw=80:
