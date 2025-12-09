#!/bin/sh
set -e

# validate subscription status
API_URL="https://agent.api.stepsecurity.io/v1/github/$GITHUB_REPOSITORY/actions/subscription"

# Set a timeout for the curl command (3 seconds)
RESPONSE=$(curl --max-time 3 -s -w "%{http_code}" "$API_URL" -o /dev/null) || true
CURL_EXIT_CODE=$?

# Decide based on curl exit code and HTTP status
if [ $CURL_EXIT_CODE -ne 0 ]; then
  echo "Timeout or API not reachable. Continuing to next step."
elif [ "$RESPONSE" = "200" ]; then
  :
elif [ "$RESPONSE" = "403" ]; then
  echo "Subscription is not valid. Reach out to support@stepsecurity.io"
  exit 1
else
  echo "Timeout or API not reachable. Continuing to next step."
fi


if [ -n "${GITHUB_WORKSPACE}" ]; then
  cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit
fi

echo '::group::🐶 Installing shfmt ... https://github.com/mvdan/sh'
TEMP_PATH="$(mktemp -d)"
"${GITHUB_ACTION_PATH}/install_shfmt.sh" -b "${TEMP_PATH}"
echo '::endgroup::'

# shellcheck disable=SC2086
"${TEMP_PATH}/shfmt" ${INPUT_SHFMT_FLAGS} -w .
