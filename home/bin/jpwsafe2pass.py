#! /usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Copyright (C) 2022 Chris Vasiladiotis <compor.dev@mailgw.com>. All Rights Reserved.
# Copyright (C) 2013 Stefan Simroth <stefan.simroth@gmail.com>. All Rights Reserved.
# Based on the script for KeepassX by Juhamatti Niemelä <iiska@iki.fi>.
# This file is licensed under the GPLv2+. Please see COPYING for more information.
#
# Features:
# * Besides the password also the fields 'username' and 'notes' (comment) will be inserted.
# * A warning is issued if an entry has no password, but it will still insert it.

import argparse
import sys
from subprocess import Popen, PIPE
from typing import List, Optional
import xmltodict
import logging
import logging.config

logger = logging.getLogger(__name__)


def sanitize(s: str) -> str:
    """ Sanitize string by using lowercase and replacing path unfriendly 
    characters. """
    return s.replace('\'', '').replace(' ', '-').lower()


# TODO use a library for this
def check_import_schema(doc) -> bool:
    """ Check that the import dict has the expected schema. """
    if 'pwlist' not in doc:
        return False

    pwlist = doc['pwlist']

    expected_fields = ['group', 'title', 'username', 'password', 'notes']

    for pwentry in pwlist['pwentry']:
        for f in expected_fields:
            if f not in pwentry:
                return False

    return True


def pass_import_entry(path: str, data: str, dry_run=True):
    """ Import new password entry to password-store using pass insert command. """
    cmd = ['pass', 'insert', '--multiline', path]
    cmd_str = ' '.join(cmd)
    logger.info(f'executing: {cmd_str}')
    print(data)
    print(data.encode('utf8'))

    if not dry_run:
        with Popen(cmd, stdin=PIPE, stdout=PIPE) as proc:
            proc.communicate(data.encode('utf8'))


def get_path_for(pwentry: dict):
    """ Generate path name from entry group and entry title. """
    group = pwentry['group']
    title = pwentry['title']
    path = '/'.join([group, title])
    path = sanitize(path)

    return path


def get_data_for(pwentry: dict, fields=['username', 'notes']):
    """ Return password data and additional info if available from password entry element. """
    data = ''
    password = pwentry['password']

    if password is not None:
        data = password + '\n'
    else:
        path = get_path_for(pwentry)
        logger.warning(f'No password for {path}')

    for field in fields:
        if field in pwentry:
            value = pwentry[field]
            if value is not None and not len(value) == 0:
                data += field + ':' + value + '\n'
        else:
            logger.warning(f'No key for {field}')

    return data


def import_entries(doc, groups: List[str] = None):
    """ Parse given passwordsafe XML file and import password groups from it. """
    entries = dict()

    pwlist = doc['pwlist']
    entry_count = 0

    for pwentry in pwlist['pwentry']:
        group = pwentry['group']

        if groups is not None and group not in groups:
            continue

        path = get_path_for(pwentry)
        data = get_data_for(pwentry)

        logger.info(f'[>>] Importing {path}...')

        entries[path] = data

        logger.info(f'[>>] Imported {path} successfully.')

        entry_count += 1

    logger.info(f'[ OK ] Done. Imported {entry_count} entries.')

    return entries


def pass_import_entries(imported_entries: dict, root_path: Optional[str] = None, dry_run=True):
    """ Import password entries to pass. """
    for k in imported_entries:
        path = k if root_path is None else '/'.join([root_path, k])
        pass_import_entry(path, imported_entries[k], dry_run)


def main():
    parser = argparse.ArgumentParser(
        description='Imports password entries from pwsafe (Java version) to pass.',
        epilog='''Copyright(C) 2022 Chris Vasiladiotis < compor.dev@mailgw.com >. All Rights Reserved.
        Copyright(C) 2013 Stefan Simroth < stefan.simroth@gmail.com >. All Rights Reserved.
        Based on the script for KeepassX by Juhamatti Niemelä < iiska@iki.fi >.
        This file is licensed under the GPLv2+. Please see COPYING for more information.''')

    parser.add_argument('--file', '-f', required=True,
                        type=str, help='Input XML file with pwsafe entries.')
    parser.add_argument('--root-path', '-r',
                        type=str, help='Add root path on every imported entry.')
    parser.add_argument('--groups', '-g', type=str, nargs='+',
                        default=None, help='Import only these groups.')
    parser.add_argument('--no-dry-run', '-n', dest='dry_run', default=True,
                        action='store_false',
                        help='Run without actually inserting entries to pass (default: true).')
    arg_group = parser.add_mutually_exclusive_group()
    arg_group.add_argument('--verbose', '-v', action='store_true',
                           help='Print messages verbosely (default: false).')
    arg_group.add_argument('--logger-config-file', '-l', type=str,
                           help='Config file for logging settings.')
    args = parser.parse_args()

    if args.logger_config_file:
        logging.config.fileConfig(
            fname=args.logger_config_file, disable_existing_loggers=False)

    if args.verbose:
        logger.addHandler(logging.StreamHandler())
        logger.setLevel(logging.DEBUG)

    imported_entries = dict()

    with open(args.file) as fd:
        doc = xmltodict.parse(fd.read())
        if not check_import_schema(doc):
            logger.error('Imported entries do not follow expected schema.')
            sys.exit(2)
        imported_entries = import_entries(doc, args.groups)
        print(imported_entries)
        pass_import_entries(imported_entries, args.root_path, args.dry_run)


if __name__ == '__main__':
    main()
