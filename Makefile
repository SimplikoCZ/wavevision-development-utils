run=docker compose run --rm tests
php=php
src=src
tests=tests
codeSnifferRuleset=codesniffer-ruleset.xml
dirs:=$(src) $(tests)
bin=vendor/bin

fix: check-syntax phpcbf phpcs phpstan test

check-syntax:
	$(run) $(bin)/parallel-lint -e $(php) $(dirs)

phpcs:
	$(run) $(bin)/phpcs -sp --standard=$(codeSnifferRuleset) --extensions=php $(dirs)

phpcbf:
	$(run) $(bin)/phpcbf -spn --standard=$(codeSnifferRuleset) --extensions=php $(dirs)

phpstan:
	$(run) $(bin)/phpstan analyze $(dirs)

ci: check-syntax phpcs phpstan

test:
	$(run) $(bin)/phpunit tests

composer:
	$(run) composer $(cmd)
