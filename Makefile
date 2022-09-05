build: clean
	mdbook build

install:
	cargo install mdbook
	cargo install mdbook-mermaid
	mdbook-mermaid install .

clean:
	mdbook clean
