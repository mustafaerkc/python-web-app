#!/bin/bash
# Print current version
cat python-app/values.yaml | grep version
# Update version using sed
sed -i 's|tag: .*|tag: "${VERSION}"|' python-app/values.yaml
# Print updated version
cat python-app/values.yaml | grep version
