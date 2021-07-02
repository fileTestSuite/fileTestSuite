meta:
  id: file_test_suite_onthology
  title: Onthology file for fileTestSuite
  file-extension: ftsonth
  encoding: utf8
  endian: le
  license: Unlicense
  imports:
    - ./file_test_suite_common

doc-ref: https://github.com/fileTestSuite/fileTestSuite

seq:
  - id: header
    type: file_test_suite_common::header
    valid:
      expr: _.signature == "ftsonth"
  - id: args_count
    type: u1
  - id: args
    type: arg
    repeat: expr
    repeat-expr: args_count
    doc: Arguments array.

types:
  arg:
    seq:
      - id: id
        type: u1
        doc: identifies the argument and is impl defined. You need an arg onthology to interpret it.
      - id: type
        type: u1
        enum: arg_type
      - id: name
        type: file_test_suite_common::string

    enums:
      arg_type:
        0: blob
        1: int
        2: string
        3: double
