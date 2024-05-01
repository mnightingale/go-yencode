#!/bin/bash

# Flatten rapidyenc source files and rewrite their #include directives

set -eo pipefail

cd $(dirname ${BASH_SOURCE[0]})

find . -maxdepth 1 \( -name '*.c' -o -name '*.cc' -o -name '*.h' \) -delete
find rapidyenc -maxdepth 1 \( -name '*.c' -o -name '*.h' \) -exec cp \{\} . \;
find rapidyenc/src \( -name '*.c' -o -name '*.cc' -o -name '*.h' \) -exec cp \{\} . \;
find rapidyenc/crcutil-1.0 \( -name '*.c' -o -name '*.cc' -o -name '*.h' \) -exec cp \{\} . \;
find . -maxdepth 1 \( -name '*.c' -o -name '*.cc' -o -name '*.h' \) -exec sed -i'' -e 's|#include \+".*/\([^"]\+\)"|#include "\1"|' \{\} \;
mv crc_arm.cc crc_arm64.cc
rm decoder_neon.cc