generate-from-docker: clean
	docker run -v $(CURDIR):/battle_asserts clojure /bin/bash -c 'cd /battle_asserts && clojure -m battle-asserts.core'

generate: clean
	clojure -m battle-asserts.core

clean:
	rm -rf issues/*

format:
	clojure -M:cljfmt-fix

checks: check-format check-namespaces check-style check-kondo

check-format:
	clojure -M:cljfmt-check

check-style:
	clojure -M:kibit

check-namespaces:
	clojure -M:eastwood

check-kondo:
	clj-kondo --lint src test

check-translations:
	clojure -X:check-translations

check-tags:
	clojure -X:check-tags

collect-tags:
	clojure -X:collect-tags

collect-disabled:
	clojure -X:collect-disabled

check-generators-and-solutions:
	clojure -X:check-generators-and-solutions

test:
	clojure -M:test

release: generate
	tar -czf issues.tar.gz issues/*

.PHONY: test issues
