# Contributing

Open maintained product changes against `lineage-23.2-aesl`. Keep upstream
syncs separate from AESL product-policy changes.

Every pull request must identify the affected products and boards, upstream
source and immutable revision, licensing impact, memory/resource impact,
validation performed, remaining runtime evidence and any AI assistance.

Do not add mutable dependencies or unregistered binaries. Binary additions
also require the product-manifest SBOM and binary risk register to be updated.
Never include credentials, customer data or private vulnerabilities in a pull
request; use GitHub private vulnerability reporting.

Pull requests are reviewed by CODEOWNERS and the AESL Preloop PR review flow.
Use `Assisted-by:` for disclosed AI assistance; do not assign AI a
copyright-bearing `Co-authored-by:` trailer.
