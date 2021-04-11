#!/usr/bin/env python

"""Convert fish history to zsh history

This script takes the fish shell history and converts it to be used in the zsh
shell. Script is modified for python3 from here:

https://gist.github.com/mateuspontes/f6c26c94ca87eaa49cc977f33043405f
"""

import os
import re

"""fish to zsh helper function

Converts multi-line commands in the history.
"""
def fish_to_zsh(cmd):
    return (cmd.replace('; and ', '&&')
               .replace('; or ', '||'))

with open(os.path.expanduser('~/.zsh_history'), 'a') as o:
    with open(os.path.expanduser('~/.local/share/fish/fish_history')) as f:
        for line in f:
            line = line.strip()
            if line and re.match('^- cmd:', line):
                meta, command = line.split('- cmd: ', 1)
                line = f.readline().strip()
                if line and re.match('^when:', line):
                    meta, when = line.split('when: ', 1)
                    o.write(': %s:0;%s\n' % (when, fish_to_zsh(command)))
