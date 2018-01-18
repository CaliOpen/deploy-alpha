#!/usr/bin/env python
# coding: utf8
"""Extract recovery emails of registered users."""

from __future__ import unicode_literals

import argparse

from caliopen_storage.config import Configuration
from caliopen_storage.helpers.connection import connect_storage


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-f', dest='conffile')

    args = parser.parse_args()
    Configuration.load(args.conffile, 'global')
    connect_storage()

    from caliopen_main.user.core.user import User
    from caliopen_main.user.core.setups import setup_system_tags

    users = [User(x) for x in User._model_class.all()]
    for user in users:
        setup_system_tags(user)
 