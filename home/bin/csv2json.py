#!/usr/bin/env python

import os
from os.path import basename
import argparse
import csv
import json


def csv2json(input_filename, output_filename):
    with open(input_filename) as f:
        reader = csv.DictReader(f)
        rows = list(reader)

    with open(output_filename, 'w') as f:
        json.dump(rows, f)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Convert CSV to JSON')

    parser.add_argument('input_filename', type=str, help='CSV file name')

    args = parser.parse_args()
    filename = basename(args.input_filename)
    output_filename = os.path.splitext(filename)[0] + ".json"

    csv2json(args.input_filename, output_filename)
