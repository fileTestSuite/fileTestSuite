meta:
  id: file_test_suite_common
  title: Common types for binary types for fileTestSuite
  encoding: utf8
  endian: le
  license: Unlicense

doc-ref: https://github.com/fileTestSuite/fileTestSuite

types:
  header:
    seq:
      - id: signature
        type: strz
        size: 8
        doc: one can use integers in the impl!
      - id: version
        type: version
  version:
    seq:
      - id: minor
        type: u1
        -default: 0
      - id: major
        type: u1
        -default: 0
  string:
    seq:
      - id: size
        type: u1
        doc: so you can skip strings without scanning them
      - id: value
        type: strz
        size: size + 1
        if: size != 0
