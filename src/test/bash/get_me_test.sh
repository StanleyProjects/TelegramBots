#!/usr/local/bin/bash

ISSUER="$tgbots/get_me.sh"

ACTUAL_VALUE="$(${ISSUER})"
. $asserts/ne.sh $? 0
. $asserts/eq.sh "${ACTUAL_VALUE}" 'Wrong arguments!'
