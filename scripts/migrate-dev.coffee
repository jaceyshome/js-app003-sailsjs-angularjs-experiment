sh = require 'shelljs'

if (sh.exec 'node ./node_modules/mongo-migrate/ -runmm').code != 0
  echo 'Error: migrate failed'
  exit 1