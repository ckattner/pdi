#!/bin/bash

echo 'std_out'
echo 'err_out' >&2

sleep $1

echo 'after_sleep'

exit $2
