@echo off

copy /-y resources\config.yaml.dist config.yaml
copy /-y resources\aliases.dist aliases
copy /-y resources\after.sh after.sh

echo Devops box initialized!
