@echo off

copy /-y resources\config.yaml.dist config.yaml
copy /-y resources\aliases.dist aliases

echo config file initialized!
echo aliases file initialized!
