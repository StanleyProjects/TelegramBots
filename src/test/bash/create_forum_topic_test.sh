#!/usr/local/bin/bash

ISSUER="$tgbots/create_forum_topic.sh"

ACTUAL_VALUE="$(${ISSUER})"
. $asserts/ne.sh $? 0
. $asserts/eq.sh "${ACTUAL_VALUE}" 'Wrong arguments!'

ACTUAL_VALUE="$(${ISSUER} 0)"
. $asserts/ne.sh $? 0
. $asserts/eq.sh "${ACTUAL_VALUE}" 'Wrong arguments!'

ACTUAL_VALUE="$(${ISSUER} 0 0)"
. $asserts/ne.sh $? 0
. $asserts/eq.sh "${ACTUAL_VALUE}" 'Wrong arguments!'

ACTUAL_VALUE="$(${ISSUER} 0 0 0 0)"
. $asserts/ne.sh $? 0
. $asserts/eq.sh "${ACTUAL_VALUE}" 'Wrong arguments!'

ACTUAL_VALUE="$(TG_BOT_ID='' TG_BOT_TOKEN='' ${ISSUER} '' '' '')"
. $asserts/ne.sh $? 0
. $asserts/eq.sh "${ACTUAL_VALUE}" 'Argument "TG_BOT_ID" is empty!'

ACTUAL_VALUE="$(TG_BOT_ID=0 TG_BOT_TOKEN='' ${ISSUER} '' '' '')"
. $asserts/ne.sh $? 0
. $asserts/eq.sh "${ACTUAL_VALUE}" 'Argument "TG_BOT_TOKEN" is empty!'

ACTUAL_VALUE="$(TG_BOT_ID=0 TG_BOT_TOKEN=0 ${ISSUER} '' '' '')"
. $asserts/ne.sh $? 0
. $asserts/eq.sh "${ACTUAL_VALUE}" 'Argument "TG_CHAT_ID" is empty!'

ACTUAL_VALUE="$(TG_BOT_ID=0 TG_BOT_TOKEN=0 ${ISSUER} 0 '' '')"
. $asserts/ne.sh $? 0
. $asserts/eq.sh "${ACTUAL_VALUE}" 'Argument "TG_TOPIC_NAME" is empty!'

ACTUAL_VALUE="$(TG_BOT_ID=0 TG_BOT_TOKEN=0 ${ISSUER} 0 0 '')"
. $asserts/ne.sh $? 0
. $asserts/eq.sh "${ACTUAL_VALUE}" 'Argument "TG_OUTPUT" is empty!'

ACTUAL_VALUE="$(TG_BOT_ID=0 TG_BOT_TOKEN=0 ${ISSUER} x 0 0)"
. $asserts/ne.sh $? 0
. $asserts/eq.sh "${ACTUAL_VALUE}" 'Wrong chat id!'

ACTUAL_VALUE="$(TG_BOT_ID=0 TG_BOT_TOKEN=0 ${ISSUER} 0 abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789a 0)"
. $asserts/ne.sh $? 0
. $asserts/eq.sh "${ACTUAL_VALUE}" 'Wrong topic name!'

POINTER="$(TZ=utc LC_ALL=C date +%Y%m%d%H%M%S%3N)"
TEST_OUTPUT="/tmp/${POINTER}.txt"

echo 'foo bar baz' > "${TEST_OUTPUT}"
[[ -f "${TEST_OUTPUT}" && -s "${TEST_OUTPUT}" ]] || exit 1

ACTUAL_VALUE="$(TG_BOT_ID=0 TG_BOT_TOKEN=0 ${ISSUER} 0 0 "${TEST_OUTPUT}")"
. $asserts/ne.sh $? 0
. $asserts/eq.sh "${ACTUAL_VALUE}" "File \"${TEST_OUTPUT}\" exists!"

echo -n '' > "${TEST_OUTPUT}"
[[ -f "${TEST_OUTPUT}" && ! -s "${TEST_OUTPUT}" ]] || exit 1

ACTUAL_VALUE="$(TG_BOT_ID=0 TG_BOT_TOKEN=0 ${ISSUER} 0 0 "${TEST_OUTPUT}")"
. $asserts/ne.sh $? 0
. $asserts/eq.sh "${ACTUAL_VALUE}" "File \"${TEST_OUTPUT}\" exists!"

rm "${TEST_OUTPUT}"
